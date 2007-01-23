Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 23 Jan 2007 09:41:20 +0000
From: Stephen Crane <jscrane@maths.tcd.ie>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070123094120.GA79734@salmon.maths.tcd.ie>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Subject: [Bluez-devel] SDP: deleting service record attributes
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,
I've noticed that service_update_req() in sdpd/service.c doesn't allow
previously-set attributes to be removed from a service record, only
new attributes to be added or existing ones updated.

The attached patch (against CVS) clears an existing service record's 
attributes before reading a new set from an SDP_SVC_UPDATE_REQ message.

Regards,
Steve

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="service.c.patch"

diff -u -r1.20 service.c
--- service.c   20 Jan 2007 20:42:27 -0000      1.20
+++ service.c   22 Jan 2007 17:55:47 -0000
@@ -289,6 +289,9 @@
                        rec->handle = handleExpected;
                        sdp_record_add(device, rec);
                }
+       } else {
+               sdp_list_free(rec->attrlist, (sdp_free_func_t)sdp_data_free);
+               rec->attrlist = NULL;
        }

        while (localExtractedLength < seqlen) {

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--UlVJffcvxoiEqYs2--
