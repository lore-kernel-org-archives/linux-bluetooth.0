Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v6 0/4] tools/mgmt-tester: multi-advertising additions
Date: Tue, 26 May 2015 02:35:51 +0200
Message-Id: <1432600555-8008-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432507209-23081-1-git-send-email-fgrandel@gmail.com>
References: <1432507209-23081-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

patch set accompanying the introduction of a multi-advertising
infrastructure in the kernel

v1 ... v4:
- fix tests to test for correct behavior when removing all adv instances
  by passing in the 0x00 instance identifier

v4 -> v5:
- factored userland code changes into a separate change set for easier
  review

v5 -> v6:
- documented add advertising test setup
- renamed add advertising tests to make them more readable
- added test to reproduce a bug found by Marcel (executing add-adv twice
  for the same instance should override the adv data)

Florian Grandel (4):
  tools/mgmt_tester: expect 0 rp when removing all adv inst
  tools/mgmt-tester: comment add adv test setup
  tools/mgmt-tester: rename add adv tests
  tools/mgmt-tester: add an additional add adv test

 doc/test-coverage.txt |   4 +-
 tools/mgmt-tester.c   | 273 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 189 insertions(+), 88 deletions(-)

-- 
1.9.1

