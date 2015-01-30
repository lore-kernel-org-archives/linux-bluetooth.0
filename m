Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, davem@davemloft.net,
	linux-bluetooth@vger.kernel.org
Subject: sched/wait: Introduce a wait_on_bit_timeout() helper function
Date: Fri, 30 Jan 2015 13:14:35 +0200
Message-Id: <1422616476-2917-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We'd need this helper function for the btusb driver for waiting for
certain firmware loading stages which are indicated through a bit-field.
For now we made a local copy in btusb [1] with the intention to switch to
this global version as soon as it makes it upstream. If it's ok we can
also take the patch through the bluetooth-next tree and get it from
there upstream.

Johan

[1] http://marc.info/?l=linux-bluetooth&m=142260834526228&w=2

----------------------------------------------------------------
Johan Hedberg (1):
      sched/wait: Introduce wait_on_bit_timeout()

 include/linux/wait.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

