Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <padovan@profusion.mobi>
Subject: [PATCH 0/3] Bluetooth: Add Passkey Entry and User Confirm hooks for SMP
Date: Thu, 10 Nov 2011 12:52:52 -0800
Message-Id: <1320958375-24425-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While I actually prefer Johan's method of adding the User Confirm MGMT code,
with it's code re-use between user_confirm_reply, and user_confirm_neg_reply,
I have broken the user_passkey_reply out from user_passkey_neg_reply, and
added an additional patch to hook in the HCI/SSP based usage of passkeys.

This makes sense, I suppose, since the regular and neg replies for passkeys
are different sizes.

Passkey's only come into play only if our OI_CAP happens to be
KeyboardOnly (for BR/EDR/LER) or DisplayKeyboard (LE only).

So the summary of the changes is:

1. Addition of BR/EDR vs LE breakout in user_confirm_reply
	1.1 Adds SMP placeholder
	1.2 Keeps Johan's confirm_reply & confirm_neg_reply structure.
		1.2.1 Johan can defend or change that himself, but the existing code works.

2. Addition of user_passkey_reply, with both BR/EDR (SSP) and LE (SMP) handling
	2.1 Adds approriate SSP HCI opcodes
	2.2 Adds appropriate MGMT opcodes
	2.3 Adds SMP placeholder
	2.4 Seperate paths for passkey_reply & passkey_neg_reply

3. Addition of HCI event handling and forwarding for the appropriate BR/EDR SSP events


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 

