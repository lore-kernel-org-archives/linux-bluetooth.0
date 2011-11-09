Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Add SMP MITM hooks into MGMTOPS
Date: Wed,  9 Nov 2011 11:13:45 -0800
Message-Id: <1320866027-14202-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


This includes:
1. Addition of BR/EDR vs LE breakout in user_confirm_reply
	1.1 Adds SMP placeholder
2. Addition of user_passkey_reply, with both BR/EDR (SSP) and LE (SMP) handling
	2.1 Adds approriate SSP HCI opcodes
	2.2 Adds appropriate MGMT opcodes
	2.3 Adds SMP placeholder

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
