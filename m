Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH-v5 0/6] Bluetooth: Add MITM protection to LE-SMP
Date: Wed, 23 Nov 2011 08:28:32 -0800
Message-Id: <1322065718-11570-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Mods made per Gustavo's request: Moved function Prototypes to Header
in the patch that they were created.

Also some mods to the blkcipher clean-up, and added a key NULL check
to handling of incoming SMP User Response.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
