Return-Path: <cyrus@holtmann.org>
Message-ID: <47C7E6D9.1030202@access-company.com>
Date: Fri, 29 Feb 2008 12:04:57 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47C7D90A.9020306@access-company.com>
In-Reply-To: <47C7D90A.9020306@access-company.com>
Content-Type: multipart/mixed; boundary="------------030906010407050909070500"
Subject: Re: [Bluez-devel] [patch] alignment trap in hcid
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
--------------030906010407050909070500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


Updated patch, checks NULL return from malloc spotted by jhe

Frédéric Dalleau wrote:
> Dear all,
>
> I recently met an alignment trap in hcid.
> Some device sent me an sdp request and the answer had to be fragmented 
> because the device reception buffer was very small.
> After that i saw alignment trap.
> The last trace I saw was : Continuation state size: 8
> The trace is located at sdpd/request.c : static sdp_cont_state_t 
> *sdp_cstate_get(uint8_t *buffer)
> This function returns an unaligned pointer.
>
> I think this patch is ok, but it has never been tested, and possibly 
> other problems are hidden behind.
> Instead of returning an unaligned pointer, the patch allocates a buffer.
>
> To test it, i could build a bluez with small sdp reception buffer and 
> ask an arm to give me fragmented reply.
> This would save me some time if someone could tell me where to change 
> this value...
>
> BR,
> Frederic
>
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


--------------030906010407050909070500
Content-Type: text/x-patch;
 name="upf_hcid_align.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="upf_hcid_align.patch"

diff --git a/sdpd/request.c b/sdpd/request.c
index 20e68b6..566367f 100644
--- a/sdpd/request.c
+++ b/sdpd/request.c
@@ -179,7 +179,10 @@ static sdp_cont_state_t *sdp_cstate_get(uint8_t *buffer)
 
 	pdata += sizeof(uint8_t);
 	if (cStateSize != 0) {
-		sdp_cont_state_t *cstate = (sdp_cont_state_t *)pdata;
+		sdp_cont_state_t *cstate = malloc(sizeof(sdp_cont_state_t));
+		if(!cstate)
+			return NULL;
+		memcpy(cstate, (sdp_cont_state_t *)pdata, sizeof(sdp_cont_state_t));
 		debug("Cstate TS : 0x%lx", cstate->timestamp);
 		debug("Bytes sent : %d", cstate->cStateValue.maxBytesSent);
 		return cstate;
@@ -408,6 +411,8 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 	}
 
 done:	
+	if(cstate)
+		free(cstate);
 	if (pattern)
 		sdp_list_free(pattern, free);
 
@@ -593,6 +598,8 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	buf->buf_size += sizeof(uint16_t);
 
 done:
+	if(cstate)
+		free(cstate);
 	if (seq)
                 sdp_list_free(seq, free);
 	if (status)
@@ -754,6 +761,8 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	}
 
 done:
+	if(cstate)
+		free(cstate);
 	if (tmpbuf.data)
 		free(tmpbuf.data);
 	if (pattern)

--------------030906010407050909070500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------030906010407050909070500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030906010407050909070500--
