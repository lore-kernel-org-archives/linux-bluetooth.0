Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/5] Bluetooth: experimental support for pm_limits
Date: Fri,  1 Oct 2010 15:47:05 +0300
Message-Id: <1285937230-547-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

First version of using power constraints interface to achieve
maximum bluetooth transfer speed. Otherwise HW goes to idle mode
and speed decreases 3 times.

Use empirical power management analyzer (TM) to define amount
of time device set high power constraints for.

May include hacks :-)

Andrei Emeltchenko (5):
  Bluetooth: board support for pm_limits
  Bluetooth: rm581: pm constraints support
  Bluetooth: rm680: pm constraints support
  Bluetooth: rm696: pm constraints support
  Bluetooth: pm constraints in bt transfer mode

 arch/arm/mach-omap2/board-rm581-peripherals.c |    8 ++
 arch/arm/mach-omap2/board-rm680-peripherals.c |    8 ++
 arch/arm/mach-omap2/board-rm696-peripherals.c |    8 ++
 arch/arm/plat-omap/include/plat/board-nokia.h |    1 +
 drivers/bluetooth/hci_h4p/core.c              |   92 ++++++++++++++++++++++++-
 drivers/bluetooth/hci_h4p/hci_h4p.h           |    1 +
 6 files changed, 117 insertions(+), 1 deletions(-)

