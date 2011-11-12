Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] Bluetooth: Add MITM protection to SMP
Date: Fri, 11 Nov 2011 16:23:56 -0800
Message-Id: <1321057441-7921-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


This is a resend of the original patches (without modification)
and two additional patches which adds the MITM protection into SMP.

This will not work for MITM protection without modifications to ther
User side code (to take advantage of new MGMT Passkey interface) unless
the other device is also a KeyboardDisplay device, or KeyboardOnly device.

If the remote side is a NoInputNoOutput device, it will work the same
as it did prior to these patches.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
