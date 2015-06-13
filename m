Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v8 00/15] doc/tests/btmgmt: multi-advertising
Date: Sat, 13 Jun 2015 05:42:44 +0200
Message-Id: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
References: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
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

v6 -> v7
- correctly split mangled patches

v7 -> v8
- several additional test documentation improvements
- documenting multi-adv implementation details in the mgmt api doc
- made the debugging of cmd response messages easier
- made the duration parameter accessible via btmgmt
- provided test infrastructure for timed tests
- fix duplicate code
- fix a few typos
- added test for advertising timeout
- added test for le off
- added multi-adv tests

Florian Grandel (15):
  doc/mgmt-api: multi-adv implementation details
  doc/mgmt-api: fix typos
  tools/btmgmt: make inst duration configurable
  tools/mgmt-tester: error message when unexp params
  tools/mgmt-tester: expect 0 rp when removing all adv inst
  tools/mgmt-tester: comment add adv test setup
  tools/mgmt-tester: rename add adv tests
  tools/mgmt-tester: increase max adv inst
  tools/mgmt-tester: test adv inst override
  tools/mgmt-tester: make test timeout configurable
  tools/mgmt-tester: allow for event-only tests
  tools/mgmt-tester: test advertising timeout
  tools/mgmt-tester: test le off
  tools/mgmt-tester: fix duplicate code
  tools/mgmt-tester: test multi-adv

 doc/mgmt-api.txt      |  96 +++++--
 doc/test-coverage.txt |   4 +-
 tools/btmgmt.c        |  28 +-
 tools/mgmt-tester.c   | 775 ++++++++++++++++++++++++++++++++++----------------
 4 files changed, 616 insertions(+), 287 deletions(-)

-- 
1.9.1

