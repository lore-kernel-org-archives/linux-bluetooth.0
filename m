Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Robert Huitl <bluez-devel@huitl.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 24 May 2007 20:45:56 +0200
References: <200705170207.52710.bluez-devel@huitl.de>
	<200705171521.38889.bluez-devel@huitl.de>
	<d89ddf300705240624u15df9655gb9624e0955d6d195@mail.gmail.com>
In-Reply-To: <d89ddf300705240624u15df9655gb9624e0955d6d195@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k1dVGci0zunTVHW"
Message-Id: <200705242045.56308.bluez-devel@huitl.de>
Subject: Re: [Bluez-devel] headsetd has problems serving two applications at
	a time
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

--Boundary-00=_k1dVGci0zunTVHW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Donnerstag, 24. Mai 2007, Brad Midgley wrote:
> Robert
>
> > Could it be that some of the ALSA plugins only work with hardware
> > devices?!
>
> that is a real possibility. libalsa plugins are definitely second-class.
>
> i am searching around in headsetd to see if it restricts the mic and
> speaker sockets to be sent to the same application. it should be easy
> enough to keep track of these two independently.

The code already has provisions for one application connecting several time=
s.=20
In the Skype case, the pcm_sco shared object is already loaded into the=20
applications memory space and therefore it reuses the already established=20
connection to headsetd (in theory):

=A0 if(serverfd =3D=3D -1) {
=A0 =A0 /* First PCM to be opened, try to connect socket to headsetd */
=A0 =A0 serverfd =3D socket(PF_LOCAL, SOCK_STREAM, 0);
=A0 =A0 err =3D connect(serverfd, (struct sockaddr *)&socket_location,
=A0 =A0 =A0 =A0 sizeof(socket_location));
=A0 =A0 ...

Here it checks the static variable serverfd to see if a connection to heads=
etd=20
is already established. If so, it should actually use that connection witho=
ut=20
trying to establish another one.

Only if serverfd =3D=3D -1 (not Skype but the arecord|aplay case), it does =
the=20
do_cfg() and this blocks for a second application.

I'm not sure if this code works as expected for Skype. Need more investigat=
ion=20
here.

I patched headsetd to allow two applications to connect at the same time. F=
ind=20
the patch attached. It makes the arecord|aplay command work, but does not=20
help with Skype. (Also, it does not check if both applications tried to ope=
n=20
the device for playback, so both may end up sending out data to the headset=
,=20
corrupting the stream. Likewise, both applications reading at the same time=
=20
might corrupt the data as well.)

Robert

--Boundary-00=_k1dVGci0zunTVHW
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="sockets.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sockets.h.diff"

Index: sockets.h
===================================================================
RCS file: /cvsroot/bluetooth-alsa/plugz/alsa-plugins/headsetd/sockets.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sockets.h
--- sockets.h	20 Dec 2006 22:54:12 -0000	1.1.1.1
+++ sockets.h	24 May 2007 18:29:33 -0000
@@ -30,8 +30,9 @@
 #define IDX_SCO_SOCK          4
 #define IDX_PCM_APPL_SOCK     5
 #define IDX_SDP_SOCK          6
+#define IDX_PCM_APPL2_SOCK    7
 
-#define DAEMON_NUM_SOCKS 7
+#define DAEMON_NUM_SOCKS 8
 
 extern	int hspd_sockets[DAEMON_NUM_SOCKS];
 

--Boundary-00=_k1dVGci0zunTVHW
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="states.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="states.c.diff"

Index: states.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/plugz/alsa-plugins/headsetd/states.c,v
retrieving revision 1.4
diff -u -r1.4 states.c
--- states.c	25 Jan 2007 20:10:16 -0000	1.4
+++ states.c	24 May 2007 18:29:14 -0000
@@ -261,6 +261,10 @@
 		close(hspd_sockets[IDX_PCM_APPL_SOCK]);
 		hspd_sockets[IDX_PCM_APPL_SOCK] = 0;
 	}
+	if(hspd_sockets[IDX_PCM_APPL2_SOCK] != 0) {
+		close(hspd_sockets[IDX_PCM_APPL2_SOCK]);
+		hspd_sockets[IDX_PCM_APPL2_SOCK] = 0;
+	}
 	if(hspd_sockets[IDX_SCO_SOCK] != 0) {
 		close(hspd_sockets[IDX_SCO_SOCK]);
 		hspd_sockets[IDX_SCO_SOCK] = 0;
@@ -510,6 +514,10 @@
 		close(hspd_sockets[IDX_PCM_APPL_SOCK]);
 		hspd_sockets[IDX_PCM_APPL_SOCK] = 0;
 	}
+	if(hspd_sockets[IDX_PCM_APPL2_SOCK] != 0) {
+		close(hspd_sockets[IDX_PCM_APPL2_SOCK]);
+		hspd_sockets[IDX_PCM_APPL2_SOCK] = 0;
+	}
 	if(hspd_sockets[IDX_SCO_SOCK] != 0) {
 		close(hspd_sockets[IDX_SCO_SOCK]);
 		hspd_sockets[IDX_SCO_SOCK] = 0;
@@ -657,8 +665,7 @@
 	.getNextState  = genericGetNextState,
 };
 
-/* Streaming State */
-static void headsetStreamingEnter(struct State *this)
+static void sendStreamingIndication(struct State *this, int socket)
 {
 	/* Send sco socket to application using ancilliary data - see man 7 unix*/
         char cmsg_b[CMSG_SPACE(sizeof(int))];  /* ancillary data buffer */
@@ -688,10 +695,16 @@
         (*(int *)CMSG_DATA(cmsg)) = hspd_sockets[IDX_SCO_SOCK];
 
 	/* finally send it -we ignore PIPE signal & return code, as any errors will be caught later */
-	int ret = sendmsg(hspd_sockets[IDX_PCM_APPL_SOCK], &msgh, MSG_NOSIGNAL);
+	int ret = sendmsg(socket, &msgh, MSG_NOSIGNAL);
 	if(ret == -1) {
 		syslog(LOG_ERR, "Unable to send SCO socket to appl: %s", strerror(errno));
 	}
+}
+
+/* Streaming State */
+static void headsetStreamingEnter(struct State *this)
+{
+	sendStreamingIndication(this, hspd_sockets[IDX_PCM_APPL_SOCK]);
 	/* This is not a transitional state */
 	this->_next_state = this;	
 }
@@ -737,9 +750,46 @@
 	}
 }
 
+/* handle a second application trying to connect */
+static void headsetStreamingHandleApplConnReq(struct State *this)
+{
+syslog(LOG_INFO, "A second application connection is requested");                                
+	struct sockaddr_un client_addr;
+	unsigned int client_addr_len = sizeof(client_addr);
+	/* Per default stay in same state */
+	this->_next_state = this;
+	
+	/* Connect Appli to us */
+	int _appl_sock = accept(hspd_sockets[IDX_PCM_APPL_SRV_SOCK], (struct sockaddr *)&client_addr, &client_addr_len);
+	if(_appl_sock != -1) {
+		fcntl(_appl_sock, F_SETFL, O_NONBLOCK);
+		if(recv_cfg(_appl_sock, 0, 0) >= 0) {
+			if(hspd_sockets[IDX_PCM_APPL2_SOCK] == 0) {
+				/* secondary connection from application */
+				hspd_sockets[IDX_PCM_APPL2_SOCK] = _appl_sock;
+				sendStreamingIndication(this, _appl_sock);
+			}
+			else {
+				/* we already handle two connections with applications */
+				syslog(LOG_INFO, "Already handling two application connections, cannot accept another one");
+			        appl_send_error_pkt(EBUSY, _appl_sock);
+			        close(_appl_sock);
+			}
+		}
+		else {
+			/* else : stay where we are */
+			close(_appl_sock);
+		}
+	}
+	else {
+		syslog(LOG_ERR, "unable to accept 2nd local application connection, %s", strerror(errno));
+	}
+}
+
 struct State HeadsetStreamingState = {
 	.name = "Streaming",
 	.pollEvents = {
+                [IDX_PCM_APPL_SRV_SOCK] = POLLIN,
 		[IDX_CTL_APPL_SRV_SOCK] = POLLIN,
 		[IDX_PCM_APPL_SOCK]   = POLLIN,
 		[IDX_RFCOMM_SOCK] = POLLIN,
@@ -751,6 +801,7 @@
 	.readSco       = headsetStreamingReadSco,
 	.readCtlAppl   = connectedReadCtlAppl,
 	.getNextState  = genericGetNextState,
+        .handleApplConnReq = headsetStreamingHandleApplConnReq,
 };
 
 /* Zombie State */
@@ -761,6 +812,10 @@
 		close(hspd_sockets[IDX_PCM_APPL_SOCK]);
 		hspd_sockets[IDX_PCM_APPL_SOCK] = 0;
 	}
+	if(hspd_sockets[IDX_PCM_APPL2_SOCK] != 0) {
+		close(hspd_sockets[IDX_PCM_APPL2_SOCK]);
+		hspd_sockets[IDX_PCM_APPL2_SOCK] = 0;
+	}
 	/* This is not a transitional state */
 	this->_next_state = this;	
 }

--Boundary-00=_k1dVGci0zunTVHW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_k1dVGci0zunTVHW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_k1dVGci0zunTVHW--
