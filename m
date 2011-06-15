Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jun 2011 16:23:38 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linville@tuxdriver.com, linux-wireless@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: pull request: bluetooth-2.6 2011-06-15
Message-ID: <20110615192338.GC23248@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

Three regressions fix intended for 3.0. Two of them fix a change made in our
HCI security process for 3.0. The third one fixes an issue with non-SSP devices.
All of them are critical fixes. They should be in 3.0. Please pull! Thanks.

	Gustavo


The following changes since commit d6124baf8a098aacdbb85ff5b171da68dad6930e:

  Merge branch 'master' of master.kernel.org:/pub/scm/linux/kernel/git/padovan/bluetooth-2.6 (2011-06-10 15:05:34 -0400)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git master

Ilia Kolomisnky (1):
      Bluetooth: Fix L2CAP connection establishment

Johan Hedberg (1):
      Bluetooth: Fix accepting connect requests for defer_setup

Luiz Augusto von Dentz (1):
      Bluetooth: Fix L2CAP security check

 net/bluetooth/hci_conn.c   |    6 +++---
 net/bluetooth/l2cap_core.c |   21 +++++++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)

