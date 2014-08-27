Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/5] Add HDP channel connect and destroy test cases
Date: Wed, 27 Aug 2014 15:38:55 +0300
Message-Id: <1409143140-19651-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patchset contains sdp search fix and channel connect and destroy
test cases.

Ravi kumar Veeramally (5):
  android/health: Avoid multiple times of sdp search
  android/tester: Add HDP Connect Source Reliable Channel test case
  android/tester: Add HDP Destroy Source Reliable Channel test case
  android/tester: Add HDP Connect Sink Streaming Channel test case
  android/tester: Add HDP Destroy Sink Streaming Channel test case

 android/health.c     |  75 ++++++-----
 android/tester-hdp.c | 367 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 407 insertions(+), 35 deletions(-)

-- 
1.9.1

