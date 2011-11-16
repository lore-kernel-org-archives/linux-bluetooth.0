Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <padovan@profusion.mobi>
Subject: [PATCH-v4 0/9] Bluetooth: Add MITM protection to LE-SMP
Date: Wed, 16 Nov 2011 13:53:11 -0800
Message-Id: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



This version of the patch-set accomplishes two things:

1. It has been rebased, picking up Johan's changes to MGMT error codes,
   and making coresponding matching changes in the error codes this
   code in these patches return as well.

2. Splits what *was* the 3rd patch of the old set, into patches
   2 and 3 of this set:  Patch 2 restructures, Patch 3 adds the
   code to recognize the difference between LE and BR/EDR connections.
   This refactoring is per Gustavo's request.

--
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
