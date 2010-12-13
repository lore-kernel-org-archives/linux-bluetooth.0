Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, rshaffer@codeaurora.org
Subject: [PATCH 0/2] Implement Long reads for GATT/ATT
Date: Mon, 13 Dec 2010 09:24:24 -0800
Message-Id: <1292261066-28100-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


These patches implement long attribute reads for GATT clients.

The first patch implements the ATT_OP_READ_BLOB_REQ opcode pkt in ATT.

The second patch modifies the gatt_read_char() API to recognize long
attributes, and build up the result over multiple ATT calls to both
ATT_OP_READ_REQ and ATT_OP_READ_BLOB_REQ, until the entire attribute
has been retrieved. It then forwards to the original requester.

The public GATT API is unchanged, and the input parameters, and returned
results are the same.

Over-the-air, the request-result sequence is unchanged unless a long
attribute is detected.

Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 

