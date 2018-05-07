Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 0/1] ECC Cleanup
Date: Mon,  7 May 2018 15:35:23 -0700
Message-Id: <20180507223524.32070-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Revert ecc_make_key to original implementation, and cleanup API

Brian Gix (1):
  shared/ecc: Make ecc_make_key() a stand alone API

 src/shared/ecc.c | 25 +++++++++++++++++--------
 src/shared/ecc.h |  4 +++-
 2 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.14.3

