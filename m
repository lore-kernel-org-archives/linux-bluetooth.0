Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@gmail.com, pgynther@google.com, luiz.dentz@gmail.com,
        Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH v2 0/3] Optionally destroy uHID devices on disconnect
Date: Tue, 28 Feb 2017 17:06:53 -0800
Message-Id: <1488330416-10463-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes since v1:
 * Add UHIDDestroy configuration option and make it control uHID lifetime

Juha Kuikka (3):
  input: Add UHIDDestroy configuration option
  input: Add UHIDDestroy option into input.conf
  hog: Optionally destroy uHID device when disconnected

 profiles/input/hog-lib.c  | 29 +++++++++++++++++++++++++++++
 profiles/input/hog-lib.h  |  1 +
 profiles/input/input.conf |  4 ++++
 profiles/input/manager.c  | 13 ++++++++++++-
 4 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.7.4

