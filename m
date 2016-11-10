Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Bates, Will" <Will.Bates@johnsonoutdoors.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth Certification Testing L2CAP UCD Test Failing
Date: Thu, 10 Nov 2016 19:27:39 +0000
Message-ID: <0df70265eadc47179a4f5ac4abe6eacb@HQ-EX-01.joi.johnsonoutdoors.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I am trying to qualify Our Bluez 5.39 stack as a host subsystem with the Bluetooth Sig. Right now I am running into an issue with Unicast Connectionless Data (UCD) and the extended features mask.

My issue is running the following test:

TP/CLS/UCD/BV-01-C (also written TC_CLS_UCD_BV_01_C): Verify that the IUT has the UCD bit set in the L2CAP Extended Features Mask to indicate support for reception of Unicast Connectionless Data. Also verify that the IUT is able to receive data over the connectionless channel.

When I run this test, I get the following output:

Test case : TC_CLS_UCD_BV_01_C started
                - MTC: PTS successfully established an ACL connection.
                - MTC: Unicast Connectionless option is not supported in the IUT.
                - MTC: The L2CAP channel disconnected by IUT.
                - MTC: PTS successfully closed the active ACL connection.
                - CM_EXIT
                - CM_EXIT
                - CM_EXIT
                - MTC: Test case ended
                -Final Verdict: FAIL
TC_CLS_UCD_BV_01_C finished

It seems to me like the UCD bit is not set in the extended features mask, and I do not know how to set this bit. The tester shows the following mask:

ext_features:'00000000000000000000000010111000'B

Can anyone tell me how to enable this feature? I have seen postings on the bluez site where this feature has existed for a while now.

Thanks,
Will

The information in this email and any attachments may contain proprietary and confidential information that is intended for the addressee(s) only. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, retention or use of the contents of this information is prohibited. If you have received this email in error, please immediately contact the sender and delete the email.
