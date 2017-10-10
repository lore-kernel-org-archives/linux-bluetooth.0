Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 0/3] android: Add LE Peripheral role support
To: linux-bluetooth@vger.kernel.org
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Tue, 10 Oct 2017 11:27:49 +0200
Message-ID: <20171010092748.30705.23283.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series adds a few missing pieces for Peripheral role support on Android 5.

This has been tested in the following configuration:
- Android 5.1.1
- Kernel 4.4
- nRF52 chip running Apache Newt firmware

