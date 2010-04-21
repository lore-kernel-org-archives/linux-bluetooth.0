Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Reply-To: scoe@intellimec.com
Date: Wed, 21 Apr 2010 12:32:54 -0400
Message-ID: <i2x9c9ad6a31004210932s33a0d402ocbd41cfdde3ed514@mail.gmail.com>
Subject: Race Condition between Read_Remote_Extended_Supported_Features and
	Remote_Name_Request causing BC6 crash
From: Stephen Coe <smcoe1@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am experiencing a race condition between
Read_Remote_Extended_Supported_Features and Remote_Name_Request which
is crashing our BC6 module.  It seems that Bluez (in
security.c:conn_complete) is requesting the remote name at the same
time that the kernel is requesting the extended features.  The
responses are coming out of order which is crashing the BC6 module
(given some time).  After contacting CSR support, they have said this
is a known issue and that to fix I need that ensure that the response
comes back prior to sending another command.

"Input from the firmware team points to it being an issue with the
remote_name_request. Can you please verify that this is responded to
before sending the read_remote_supported_features request? Also check
that any pending requests are responded to and that the
remote_name_request is responded to before continuing."

Does anyone have any suggestions on the best way resolve the issue?  I
have proven it out with a small delay but that is a really bad hack.

Please see dump below:

2007-09-20 12:01:24.263113 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 37 bdaddr 00:24:9F:F0:F8:DE type ACL encrypt 0x00
2007-09-20 12:01:24.263222 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
    handle 37
2007-09-20 12:01:24.263671 > HCI Event: Page Scan Repetition Mode
Change (0x20) plen 7
    bdaddr 00:24:9F:F0:F8:DE mode 1
2007-09-20 12:01:24.265568 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
2007-09-20 12:01:24.268835 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 37 slots 5
2007-09-20 12:01:24.275646 > HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
2007-09-20 12:01:24.280022 < HCI Command: Remote Name Request
(0x01|0x0019) plen 10
    bdaddr 00:24:9F:F0:F8:DE mode 2 clkoffset 0x0000
2007-09-20 12:01:24.283066 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-09-20 12:01:24.285635 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 37
    Features: 0xbf 0xfe 0x8f 0xfe 0x98 0x19 0x59 0x83
2007-09-20 12:01:24.285733 < HCI Command: Read Remote Extended
Features (0x01|0x001c) plen 3
    handle 37 page 1
2007-09-20 12:01:24.288261 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
2007-09-20 12:01:24.295597 > HCI Event: Read Remote Extended Features
(0x23) plen 13
    status 0x00 handle 37 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
2007-09-20 12:01:24.304385 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:24:9F:F0:F8:DE name 'BlackBerry 9530 scoe'
