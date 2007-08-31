Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46D84FBD.60203@gmail.com>
Date: Fri, 31 Aug 2007 14:28:29 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------000805050906030905050104"
Subject: [Bluez-devel] [PATCH] SDP lib memory leak
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
--------------000805050906030905050104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marcel and team,
Hi folks, I have made an application that makes use of the sdp lib. By 
running the app with valgrind [1] I found a memory leak.
There's an static variable called bluetooth_base_uuid that's being 
initializated once but then never freed.
I had added a method that should be called, only when the thread is 
about to end that frees that variable.
Attached you can see the patch.
Thanks,
Manuel


[1] http://valgrind.org/


--------------000805050906030905050104
Content-Type: text/x-patch;
 name="leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="leak.patch"

diff -uprN bluez-libs-3.17/include/sdp_lib.h bluez-libs-3.17.patched/include/sdp_lib.h
--- bluez-libs-3.17/include/sdp_lib.h	2007-05-09 03:40:39.000000000 -0300
+++ bluez-libs-3.17.patched/include/sdp_lib.h	2007-08-31 14:15:49.000000000 -0300
@@ -609,6 +609,9 @@ void sdp_pattern_add_uuidseq(sdp_record_
 
 int sdp_send_req_w4_rsp(sdp_session_t *session, uint8_t *req, uint8_t *rsp, uint32_t reqsize, uint32_t *rspsize);
 
+/** This function will cleanup the bluetooth base uuid, should be called only after the thread has ended it's work **/
+void sdp_cleanup();
+
 #ifdef __cplusplus
 }
 #endif
diff -uprN bluez-libs-3.17/src/sdp.c bluez-libs-3.17.patched/src/sdp.c
--- bluez-libs-3.17/src/sdp.c	2007-08-23 06:59:37.000000000 -0300
+++ bluez-libs-3.17.patched/src/sdp.c	2007-08-31 14:15:02.000000000 -0300
@@ -2152,6 +2152,11 @@ uint128_t *sdp_create_base_uuid(void)
 	return bluetooth_base_uuid;
 }
 
+void sdp_cleanup(){
+	if (bluetooth_base_uuid)
+		free(bluetooth_base_uuid);
+}
+
 uuid_t *sdp_uuid16_create(uuid_t *u, uint16_t val)
 {
 	memset(u, 0, sizeof(uuid_t));

--------------000805050906030905050104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--------------000805050906030905050104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------000805050906030905050104--
