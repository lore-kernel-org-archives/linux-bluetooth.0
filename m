Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080109002828.GB5883@ps.ms.mff.cuni.cz>
References: <20080109002828.GB5883@ps.ms.mff.cuni.cz>
Content-Type: multipart/mixed; boundary="=-tbLi3cfDGj4dP8udgCbO"
Date: Thu, 10 Jan 2008 20:54:50 +0530
Message-Id: <1199978691.23989.10.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH][HFP] - default device as hfp
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


--=-tbLi3cfDGj4dP8udgCbO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan, 

Attaching a patch which fixes a HFP bug in headset.c  

When a default device/stored device is registered, it cannot be used as
a handsfree (i.e hs->hfp_active = false) because the following condition
in rfcomm_connect_cb() fails. 

 if (server_is_enabled(HANDSFREE_SVCLASS_ID) && hs->hfp_handle != 0) 

This is because, hs->hfp_handle is not populated for the default
device.As a matter of fact, hs->hsp_handle is not populated either.
verified this by printing the handles.

The 2 handles are ONLY populated through a call to headset_init() with
its 2nd and 3rd arguments not being zero.

I have tested this patch with my setup. 

Let me know if my logic is wrong or the patch needs to be changed.


Thanks, 
Alok. 


--=-tbLi3cfDGj4dP8udgCbO
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/headset.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.c,v
retrieving revision 1.156
diff -u -5 -p -r1.156 headset.c
--- audio/headset.c	9 Jan 2008 12:36:58 -0000	1.156
+++ audio/headset.c	10 Jan 2008 14:43:36 -0000
@@ -752,10 +752,16 @@ static void get_record_reply(DBusPending
 		|| (uuid.type == SDP_UUID16 && uuid.value.uuid16 != id)) {
 		error("Service classes did not contain the expected UUID");
 		goto failed_not_supported;
 	}
 
+	if ((uuid.value.uuid32 == HANDSFREE_SVCLASS_ID)
+		|| (uuid.value.uuid16 == HANDSFREE_SVCLASS_ID)) {
+		hs->hfp_handle = record->handle;
+	}else
+		hs->hsp_handle = record->handle;
+
 	if (!sdp_get_access_protos(record, &protos)) {
 		ch = sdp_get_proto_port(protos, RFCOMM_UUID);
 		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free,
 					NULL);
 		sdp_list_free(protos, NULL);

--=-tbLi3cfDGj4dP8udgCbO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--=-tbLi3cfDGj4dP8udgCbO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-tbLi3cfDGj4dP8udgCbO--
