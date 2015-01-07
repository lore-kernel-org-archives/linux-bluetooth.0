Return-Path: <cyrus@holtmann.org>
From: kernel@gkr.i24.cc
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Gordon Kramer <kernel@gkr.i24.cc>
Subject: [PATCH v5 0/2] hid2hci add CSR 8510 A10 support
Date: Wed,  7 Jan 2015 23:03:58 +0100
Message-Id: <1420668240-5100-1-git-send-email-kernel@gkr.i24.cc>
In-Reply-To: <20150107203159.GA4571@t440s.P-661HNU-F1>
References: <20150107203159.GA4571@t440s.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gordon Kramer <kernel@gkr.i24.cc>

Hi Johan,

fixed the compilation bug. using following config
configure --enable-maintainer-mode --disable-systemd --disable-cups  --disable-monitor

i also only compile with
make tools/hid2hci

added a second patch that implements your suggestions with const uint_8 * 

Thanks!

Gordon Kramer (2):
  hid2hci add CSR 8510 A10 support
  use const uint_8* for pointer in control_message

 tools/hid2hci.1 |  2 +-
 tools/hid2hci.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 5 deletions(-)

-- 
1.9.1

