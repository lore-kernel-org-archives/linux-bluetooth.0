Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Two OOB related fixes
Date: Tue, 11 Sep 2018 14:10:11 +0300
Message-Id: <20180911111013.2739-1-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are two patches fixing handling of local OOB data.

Johan Hedberg (1):
      Bluetooth: SMP: Fix trying to use non-existent local OOB data

Matias Karhumaa (1):
      Bluetooth: Use correct tfm to generate OOB data

 net/bluetooth/smp.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

Johan
