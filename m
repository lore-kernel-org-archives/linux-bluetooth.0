Return-Path: <cyrus@holtmann.org>
From: Angela Bartholomaus <angelab@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Subject: [PATCH v2 0/4] Fix error reporting for SDP Requests
Date: Wed, 25 Aug 2010 10:01:41 -0700
Message-Id: <1282755705-28400-1-git-send-email-angelab@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed the following issues revealed while performing bluez qualification: 
- Incorrect error code was being reported for requests with invalid PDU size;
- No error was being reported if a request less than 0x07 was received.


--
Angela Bartholomaus
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
