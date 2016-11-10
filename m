Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: Bluetooth Certification Testing L2CAP UCD Test Failing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <0df70265eadc47179a4f5ac4abe6eacb@HQ-EX-01.joi.johnsonoutdoors.com>
Date: Thu, 10 Nov 2016 21:40:32 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <04F104FD-0221-4D6D-81B7-618DAD64DA91@holtmann.org>
References: <0df70265eadc47179a4f5ac4abe6eacb@HQ-EX-01.joi.johnsonoutdoors.com>
To: "Bates, Will" <Will.Bates@johnsonoutdoors.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Will,

> I am trying to qualify Our Bluez 5.39 stack as a host subsystem with the Bluetooth Sig. Right now I am running into an issue with Unicast Connectionless Data (UCD) and the extended features mask.
> 
> My issue is running the following test:
> 
> TP/CLS/UCD/BV-01-C (also written TC_CLS_UCD_BV_01_C): Verify that the IUT has the UCD bit set in the L2CAP Extended Features Mask to indicate support for reception of Unicast Connectionless Data. Also verify that the IUT is able to receive data over the connectionless channel.
> 
> When I run this test, I get the following output:
> 
> Test case : TC_CLS_UCD_BV_01_C started
>                - MTC: PTS successfully established an ACL connection.
>                - MTC: Unicast Connectionless option is not supported in the IUT.
>                - MTC: The L2CAP channel disconnected by IUT.
>                - MTC: PTS successfully closed the active ACL connection.
>                - CM_EXIT
>                - CM_EXIT
>                - CM_EXIT
>                - MTC: Test case ended
>                -Final Verdict: FAIL
> TC_CLS_UCD_BV_01_C finished
> 
> It seems to me like the UCD bit is not set in the extended features mask, and I do not know how to set this bit. The tester shows the following mask:
> 
> ext_features:'00000000000000000000000010111000'B
> 
> Can anyone tell me how to enable this feature? I have seen postings on the bluez site where this feature has existed for a while now.

I am almost certain that I actually implemented the UCD support. And looking at the Android qualification this test case is passing.

https://git.kernel.org/cgit/bluetooth/bluez.git/plain/android/pics-l2cap.txt

Since L2CAP is in the kernel, there is no difference between BlueZ for Android and Linux. The only thing I can think of is that you are running a kernel where a patch for UCD features setting is missing. However keep in mind that for BlueZ for Android we actually used the kernel backports project to update the Bluetooth subsystem. So you might have to consider doing that as well.

Anyway, I looked through the bluetooth-next tree and found these commits:

commit d40bffbc4e9afce9c0be6ea399b4103f72e50ec2
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Sat Oct 12 08:18:18 2013 -0700

    Bluetooth: The L2CAP fixed channel connectionless data is supported

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 12523c79eb3b..56f540e7a8fc 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -131,6 +131,7 @@ struct l2cap_conninfo {
 
 /* L2CAP fixed channels */
 #define L2CAP_FC_L2CAP         0x02
+#define L2CAP_FC_CONNLESS      0x04
 #define L2CAP_FC_A2MP          0x08
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e932ffda5445..8b5437c44c7b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -44,7 +44,7 @@
 bool disable_ertm;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
-static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP, };
+static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP | L2CAP_FC_CONNLESS, };


commit 547d103280690b8febd2354320e164ae508d912e
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Sat Oct 12 08:18:19 2013 -0700

    Bluetooth: Unicast connectionless data reception is supported

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8b5437c44c7b..13bb9da2c93a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -43,7 +43,7 @@
 
 bool disable_ertm;
 
-static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
+static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_UCD;
 static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP | L2CAP_FC_CONNLESS, };

There might be more patches needed since some of the security handling features might need an update for UCD, but I do not know how much PTS is testing. However I know that I have testing this for basic 3D glasses support. So upstream this should be all fixed. As I said, your kernel might not have the right set of patches.

Regards

Marcel

