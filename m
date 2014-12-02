Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/3] android/handsfree-client: Some cleaning patches
Date: Tue,  2 Dec 2014 12:03:17 +0100
Message-Id: <1417518200-18428-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Couple minor fixes and clean patches to HFP client implementation

Lukasz Rymanowski (3):
  android/handsfree-client: Fix for correct audio state
  android/handsfree-client: Decrease number of memcpy
  android/handsfree-client: Trivial fix typo

 android/hal-msg.h          |  2 +-
 android/handsfree-client.c | 31 ++++++++++++++++---------------
 2 files changed, 17 insertions(+), 16 deletions(-)

-- 
1.8.4

