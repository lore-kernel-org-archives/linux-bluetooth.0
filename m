Return-Path: <cyrus@holtmann.org>
From: David Scherba <dscherba@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: [PATCH v2 0/2] Use HCI device type to determine suitability of HCI commands 
Date: Tue, 10 Aug 2010 11:15:02 -0400
Message-Id: <1281453304-30408-1-git-send-email-dscherba@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BlueZ assumes that HCI devices are either BR/EDR radios, or "RAW" (via
HCI_RAW).  At present, alternate radios are handled as RAW (reference
Marcel's 943da25d9 kernel commit).  More subtlety in BlueZ is useful as
AMP support is enhanced.

These patches remove the need to treat non-BR/EDR HCI devices as "RAW."

Cheers,
David

-- 
David Scherba
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
