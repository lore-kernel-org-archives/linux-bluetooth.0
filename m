Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH V2 BlueZ 0/3] android: Add LE Peripheral role support
To: linux-bluetooth@vger.kernel.org
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Fri, 13 Oct 2017 16:02:04 +0200
Message-ID: <20171013140204.19524.68439.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series adds a few missing pieces for Peripheral role support on Android 5.

This has been tested in the following configuration:
- Android 5.1.1
- Kernel 4.4
- nRF52 chip running Apache Newt firmware

Changes for V2:
- Only load keys if BRDE supported rather than always trying and ignoring error
- Use the bt_ad_* helper functions rather than open coding advertisement data
- free_adv_instance() accepts NULL like the other free family members
- Style fixes
- Remove SOBs

