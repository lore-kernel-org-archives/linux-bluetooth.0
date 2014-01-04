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
Subject: [PATCH 0/2] Regression fixes for rfcomm/tty.c
Date: Sat,  4 Jan 2014 17:30:36 +0100
Message-Id: <1388853038-6917-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

The following two patches fix a couple of regressions introduced with
the rfcomm tty_port conversion.

The first patch restores the expected behaviour of the rfcomm port when
it's created with the flag RFCOMM_RELEASE_ONHUP.

The second patch fixes a bug that affect userspace (ModemManager) when
the port is created with the flag RFCOMM_REUSE_DLC.

Gianluca Anzolin (2):
  rfcomm: release the port when the last user closes the tty
  rfcomm: move the device under its parent if already connected

 net/bluetooth/rfcomm/tty.c | 68 ++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

-- 
1.8.5.2
