Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Dec 2010 15:43:47 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linville@tuxdriver.com
Cc: linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth-2.6 2010-12-13
Message-ID: <20101213174347.GA3142@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

The latest Bluetooth patches to linux 2.6.37. First is very critical fix a
break in the DUN profile connection setup. Second patch is also critical and
adds a NULL pointer protection in HCI code.

Please pull or let me know any problems! Thanks.


The following changes since commit 0a54917c3fc295cb61f3fb52373c173fd3b69f48:

  orinoco: fix TKIP countermeasure behaviour (2010-12-08 15:24:06 -0500)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git master

Johan Hedberg (1):
      Bluetooth: Fix initial RFCOMM DLC security level

Jun Nie (1):
      Bluetooth: add NULL pointer check in HCI

 drivers/bluetooth/hci_ldisc.c |    6 ++++--
 net/bluetooth/rfcomm/core.c   |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)


-- 
Gustavo F. Padovan
http://profusion.mobi
