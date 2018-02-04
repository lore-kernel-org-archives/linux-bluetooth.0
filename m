Return-Path: <mussitantesmortem@gmail.com>
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH v2 0/5] lite fixes for ath3k
Date: Mon,  5 Feb 2018 00:09:42 +0300
Message-Id: <20180204210947.31002-1-mussitantesmortem@gmail.com>
In-Reply-To: <20180204205934.12117-4-mussitantesmortem@gmail.com>
References: <20180204205934.12117-4-mussitantesmortem@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry for the last series of patches

Maxim Zhukov (5):
  drivers: bluetooth: ath3k: replace hardcode numbers with define
  drivers: bluetooth: ath3k: do not init variables
  drivers: bluetooth: ath3k: remove blank line after if
  drivers: bluetooth: ath3k: Fix warning: quoted string split across lines
  drivers: bluetooth: ath3k: fix checkpatch warning

 drivers/bluetooth/ath3k.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

-- 
2.16.1
