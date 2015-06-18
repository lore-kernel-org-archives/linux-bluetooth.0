Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Jun 2015 08:55:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [BlueZ v9 00/16] Multi-advertising
Message-ID: <20150618055552.GA11172@t440s.P-661HNU-F1>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
 <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

On Thu, Jun 18, 2015, Florian Grandel wrote:
> Florian Grandel (16):
>   doc/mgmt-api: multi-adv implementation details
>   doc/mgmt-api: fix typos
>   tools/btmgmt: make inst duration configurable
>   tools/mgmt-tester: error message when unexp params
>   tools/mgmt-tester: expect 0 rp when removing all adv inst
>   tools/mgmt-tester: comment add adv test setup
>   tools/mgmt-tester: rename add adv tests
>   tools/mgmt-tester: increase max adv inst
>   tools/mgmt-tester: keep instances on power cycle
>   tools/mgmt-tester: test adv inst override
>   tools/mgmt-tester: make test timeout configurable
>   tools/mgmt-tester: allow for event-only tests
>   tools/mgmt-tester: test advertising timeout
>   tools/mgmt-tester: test le off
>   tools/mgmt-tester: fix duplicate code
>   tools/mgmt-tester: test multi-adv
> 
>  doc/mgmt-api.txt      | 105 +++++--
>  doc/test-coverage.txt |   4 +-
>  tools/btmgmt.c        |  28 +-
>  tools/mgmt-tester.c   | 838 +++++++++++++++++++++++++++++++++++---------------
>  4 files changed, 681 insertions(+), 294 deletions(-)

I've been running mgmt-tester with your latest kernel and user space
patch sets, and there are four tests either failing or not getting run:

Read Advertising Features - Success 1 (No instance)  Failed       0.019 seconds
Read Advertising Features - Success 2 (One instance) Failed       0.025 seconds
Multi Advertising - Success 1 (Instance Switch)      Not Run
Multi Advertising - Success 2 (Add Second Inst)      Failed       0.030 seconds

Are these passing for you?

The detailed failures look like this:

Read Advertising Features - Success 1 (No instance) - run
  Sending command 0x003d
  Test condition added, total 1
  Command 0x003d finished with status 0x00
  Unexpected cmd response parameter value
Read Advertising Features - Success 1 (No instance) - test failed

Read Advertising Features - Success 2 (One instance) - run
  Sending command 0x003d
  Test condition added, total 1
  Command 0x003d finished with status 0x00
  Unexpected cmd response parameter value
Read Advertising Features - Success 2 (One instance) - test failed

Multi Advertising - Success 1 (Instance Switch) - setup
  Adding two instances with timeout 1 and duration 1
  Add Advertising setup complete (instance 1)
Multi Advertising - Success 1 (Instance Switch) - setup failed

Multi Advertising - Success 2 (Add Second Inst) - run
  Registering Advertising Added notification
  Test condition added, total 1
  Registering HCI command callback
  Test condition added, total 2
  Sending command 0x003e
  Test condition added, total 3
  Command 0x003e finished with status 0x03
Multi Advertising - Success 2 (Add Second Inst) - test failed

Do these failures indicate a kernel bug or a test case having a bug or
otherwise needing updating (e.g. to match your latest changes)?

Johan
