Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Fix bug that caused a profile's accept() not to be called
Date: Fri,  4 Dec 2015 11:36:41 +0000
Message-Id: <1449229003-7193-1-git-send-email-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A profile's accept function callback was only been called once. If a device
was disconnected and reconnected, the accept would not been called because the
service's states were not been update accordingly.

These patches fixes this problem.

Felipe F. Tonello (2):
  core/device: call btd_service_disconnect when discconected from
    peripheral
  core/service: fix connection and disconnection state handling

 src/device.c  |  1 +
 src/service.c | 43 ++++++++++++++++++++++---------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

-- 
2.5.0

