Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: peter@hurleysoftware.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jslaby@suse.cz,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v4 0/6] rfcomm: Implement rfcomm as a proper tty_port
Date: Fri, 26 Jul 2013 19:18:52 +0200
Message-Id: <1374859138-19467-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset addresses an issue with the rfcomm tty driver in the
current stable kernels that manifests itself as a sudden lockup of the
whole machine or as a OOPS if we are lucky enough (I wasn't).

Triggering the problem is very easy:

1) establish a bluetooth connection with a bluetooth host
2) open the tty it provides with some program
3) turn off the bluetooth host or take it out of range

After a timeout the machine freezes.

Another way to trigger these lockups is to simply release the rfcomm
tty.

This happens because the underlying tty_struct objects and tty_port
objects are freed while being used: the code doesn't take references
properly.

The following patches address the problem by implementing a proper
tty_port driver for rfcomm.

There are still some issues left: one relevant to flow control (which is
also missing in the current code) and another relevant to a corner case
in rfcomm_dev_state_change() that I intend to fix with a future patch.
They are commented with a FIXME.

Thank you,
Gianluca

Gianluca Anzolin (6):
  rfcomm: Take proper tty_struct references
  rfcomm: Remove the device from the list in the destructor
  rfcomm: Move the tty initialization and cleanup out of open/close
  rfcomm: Implement .activate, .shutdown and .carrier_raised methods
  rfcomm: Fix the reference counting of tty_port
  rfcomm: Purge the dlc->tx_queue to avoid circular dependency

 net/bluetooth/rfcomm/tty.c | 263 +++++++++++++++++++++------------------------
 1 file changed, 122 insertions(+), 141 deletions(-)

-- 
1.8.3.4
