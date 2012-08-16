Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 16 Aug 2012 16:25:41 +0300
Message-ID: <CABBYNZJ16G7zOEm+AJwmb8SeEtRyGzfiKFf+QsK8NdQGUUGqDA@mail.gmail.com>
Subject: Moving bluetooth plugin to gstreamer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: gstreamer-devel@lists.freedesktop.org
Cc: linux-bluetooth@vger.kernel.org,
	Thiago Sousa Santos <thiagossantos@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Since we now have a proper library for SBC codec
(http://git.kernel.org/?p=bluetooth/sbc.git;a=summary) and its patent
has expired June 2, 2010. (source:
http://en.wikipedia.org/wiki/SBC_(codec)), I wonder if it wouldn't be
a good idea to move the plugin to gstreamer tree?

The plugin has the following elements:

bluetooth:  sbcenc: Bluetooth SBC encoder
bluetooth:  sbcdec: Bluetooth SBC decoder
bluetooth:  sbcparse: Bluetooth SBC parser
bluetooth:  avdtpsink: Bluetooth AVDTP sink
bluetooth:  a2dpsink: Bluetooth A2DP sink
bluetooth:  rtpsbcpay: RTP packet payloader

-- 
Luiz Augusto von Dentz
