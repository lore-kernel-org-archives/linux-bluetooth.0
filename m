Return-Path: <cyrus@holtmann.org>
From: Angela Bartholomaus <angelab@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	marcel@holtmann.org,
	johan.hedberg@gmail.com
Subject: [PATCH 0/4] Fix error reporting for SDP Requests 
Date: Tue, 24 Aug 2010 15:14:16 -0700
Message-Id: <1282688060-10727-1-git-send-email-angelab@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed the following issues revealed while performing bluez qualification: 
- Incorrect error code was being reported for requests with invalid PDU size;
- No error was being reported if a request less than 0x07 was received.


Angela Bartholomaus
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
