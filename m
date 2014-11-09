Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/7] android/handsfree-client: First set of HFP HF
Date: Sun,  9 Nov 2014 01:24:12 +0100
Message-Id: <1415492659-3296-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In this set service record, slc creation and incoming/outgoing
connection support has been added.

This code has been tested on UPF49.

v2:
* Handle Szymon comments
* Fix for checking codec negotiation support in 4/7

Lukasz Rymanowski (7):
  android/handsfree-client: Typo fix in define name
  android/handsfree-client: Add service record
  android/handsfree-client: Add devices queue
  android/handsfree-client: Add incoming connection handling
  android/handsfree-client: Add SLC creation procedure
  android/handsfree-client: Add support for outgoing connection
  android/handsfree-client: Handle disconnect command

 android/hal-msg.h          |    2 +-
 android/handsfree-client.c | 1041 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 1036 insertions(+), 7 deletions(-)

-- 
1.8.4

