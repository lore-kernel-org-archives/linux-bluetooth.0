Return-Path: <cyrus@holtmann.org>
From: Vikrampal <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>
Subject: AVCTP and AVRCP packet decoder file structure in btmon
Date: Mon, 04 Aug 2014 14:18:56 +0530
Message-id: <001301cfafc0$ef11b350$cd3519f0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm working on AVRCP packet decoder for Bluetooth monitor module.
There's a separate file avctp.c/h for AVCTP packet decoder.

The file avctp.c is not a big file as such. So, I'm thinking whether or not
I should
include AVRCP decoder in this file itself.

Shall I create a separate file for AVRCP decoding?

If both AVCTP & AVRCP go in the same file then what should be the 
appropriate name of the file or shall I create a separate file for AVRCP as
well.

Please advise me. Thanks!

Regards,
Vikram

