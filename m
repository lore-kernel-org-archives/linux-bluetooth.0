Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: davem@davemloft.net
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 0/2] Bluetooth: Fix regressions for 3.0
Date: Sat, 16 Jul 2011 01:30:19 -0300
Message-Id: <1310790621-28510-1-git-send-email-padovan@profusion.mobi>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Gustavo F. Padovan (1):
  Bluetooth: Fix regression in L2CAP connection procedure

Ilia Kolomisnky (1):
  Bluetooth: Fix crash with incoming L2CAP connections

 net/bluetooth/l2cap_core.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

-- 
1.7.6

