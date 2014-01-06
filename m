Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: peter@hurleysoftware.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jslaby@suse.cz,
	stable@vger.kernel.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v3 0/4] Regression fixes for rfcomm/tty.c
Date: Mon,  6 Jan 2014 21:23:49 +0100
Message-Id: <1389039834-24491-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches fix three regressions introduced with the
rfcomm tty_port conversion.

The first patch restores the expected behaviour of the rfcomm port when
it's created with the flag RFCOMM_RELEASE_ONHUP.

The second patch moves rfcomm_get_device() and is preparatory for the
third patch.

The third patch fixes two regressions:
1) when the tty is opened with O_NONBLOCK or CLOCAL is set (fixes
   wvdial)
2) when the rfcomm device is created with the flag RFCOMM_REUSE_DLC
   (fixes ModemManager)

The fourth patch removes rfcomm_dev_carrier_raised().

Changes from v2:
  * Fix the style of if statements in rfcomm_dev_activate().

Changes from v1:
  * Removed the device_move() fix which is now incorporated in a new patch.

Gianluca Anzolin (4):
  rfcomm: release the port when the last user closes the tty
  rfcomm: move rfcomm_get_device() before rfcomm_dev_activate()
  rfcomm: always wait for a bt connection on open()
  rfcomm: remove rfcomm_carrier_raised()

 net/bluetooth/rfcomm/tty.c | 103 +++++++++++++++++++++++++++++----------------
 1 file changed, 66 insertions(+), 37 deletions(-)

-- 
1.8.5.2
