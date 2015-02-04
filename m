Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Fix AMP initialization
Date: Wed,  4 Feb 2015 11:20:39 +0200
Message-Id: <1423041640-28763-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

BTW: What is the best way to initialize AMP? Shall we take into
account returned Local Supported Commands?

Andrei Emeltchenko (1):
  Bluetooth: Remove Read Local Supported Features from AMP controller

 net/bluetooth/hci_core.c | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.1.0

