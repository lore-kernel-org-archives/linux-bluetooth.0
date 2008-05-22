Return-Path: <cyrus@holtmann.org>
Message-ID: <48355289.7070906@access-company.com>
Date: Thu, 22 May 2008 13:01:29 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48075B6A.2060308@access-company.com>
	<1209058941.12684.37.camel@violet.holtmann.net>
In-Reply-To: <1209058941.12684.37.camel@violet.holtmann.net>
Content-Type: multipart/mixed; boundary="------------070507090508010003050809"
Subject: Re: [Bluez-devel] [patch] BNEP/PAN Qualification issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070507090508010003050809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> I got my hand over a BNEP and PAN test plan and tried to pass it with 
>> current PAN implementation (pand, not network service). I met several 
>> issues and tried to find some solutions to them.
>>
>> * Handling of 32 and 128 bits uuids,
>> * Correct response to invalid uuids,
>> * Respond to control messages before connection setup,
>> * Handling of bnep extension together with general headers,
>> * Handling of bnep extensions together with setup connection requests.
>> * Forwarding of unknown BNEP extensions (not available for broadcast, 
>> advice requested),
>> * Give up pan connection after 30 seconds,
>>
>> The result of that work is two patchs, one for the kernel (based on 
>> latest git) and one for pand (a bit old that one I fear). However, it 
>> should be easy to get similar patch for network service.
>>     
>
> I need both patches in unified diff format (-u). I am not a machine and
> can't read context diffs.
>
> Please break up the kernel patch in small chunks that solve each
> problem. It is easier for me to review them and then apply them.
>   

Sorry for long delay, i was ooto. Will split patch and send with -u.
For now here is first patch for pand and network service.

Give up pan connection after 30 seconds
TP/BNEP/CTRL/BV-02-C


Marcel, Luiz,
A part of the patch si to move handling of incoming setup_conn_req in 
kernel. In order to keep pan working with older kernel, some 
differenciation must be done. How to achieve this ?

Regards,
Frederic



--------------070507090508010003050809
Content-Type: text/x-patch;
 name="pand.timeout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pand.timeout.patch"

diff --git a/pand/bnep.c b/pand/bnep.c
index 604ed55..88c1184 100644
--- a/pand/bnep.c
+++ b/pand/bnep.c
@@ -259,6 +259,7 @@ int bnep_create_connection(int sk, uint16_t role, uint16_t svc, char *dev)
 	struct __service_16 *s;
 	unsigned char pkt[BNEP_MTU];
 	int r;
+	struct timeval t = { 30, 0 };
 
 	/* Send request */
 	req = (void *) pkt;
@@ -269,6 +270,8 @@ int bnep_create_connection(int sk, uint16_t role, uint16_t svc, char *dev)
 	s->dst = htons(svc);
 	s->src = htons(role);
 
+	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
 	if (send(sk, pkt, sizeof(*req) + sizeof(*s), 0) < 0)
 		return -1;
 
@@ -278,6 +281,9 @@ receive:
 	if (r <= 0)
 		return -1;
 
+	t.tv_sec = 0;
+	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
 	errno = EPROTO;
 
 	if (r < sizeof(*rsp))

--------------070507090508010003050809
Content-Type: text/x-patch;
 name="network.timeout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="network.timeout.patch"

diff --git a/network/connection.c b/network/connection.c
index 057fbba..9d09e83 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -109,6 +109,7 @@ static gboolean bnep_connect_cb(GIOChannel *chan, GIOCondition cond,
 	int sk;
 	DBusMessage *reply;
 	const char *pdev;
+	struct timeval t = { 0, 0 };
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -155,6 +156,8 @@ static gboolean bnep_connect_cb(GIOChannel *chan, GIOCondition cond,
 
 	sk = g_io_channel_unix_get_fd(chan);
 
+	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
 	if (bnep_connadd(sk, BNEP_SVC_PANU, nc->dev)) {
 		error("%s could not be added", nc->dev);
 		goto failed;
@@ -196,6 +199,7 @@ static int bnep_connect(struct network_conn *nc)
 	unsigned char pkt[BNEP_MTU];
 	GIOChannel *io;
 	int err = 0;
+	struct timeval t = { 30, 0 };
 
 	/* Send request */
 	req = (void *) pkt;
@@ -206,6 +210,8 @@ static int bnep_connect(struct network_conn *nc)
 	s->dst = htons(nc->id);
 	s->src = htons(BNEP_SVC_PANU);
 
+	setsockopt(nc->sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
 	io = g_io_channel_unix_new(nc->sk);
 	g_io_channel_set_close_on_unref(io, FALSE);
 

--------------070507090508010003050809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------070507090508010003050809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------070507090508010003050809--
