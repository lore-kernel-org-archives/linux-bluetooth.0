Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v2 0/8] Autopair plugin, with some extensions.
Date: Fri, 12 Apr 2013 16:28:30 -0700
Message-Id: <1365809318-17775-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set includes a few changes mentioned in the mailing list
and a new functionality for dumb keyboards (last 2 commits).

"count" changed to "attempt". I agree that "attempt" is a better name.
With this change, attempt is now started at 1, so the first attempt of
a given plugin will be called with attempt==1. This also changes the
variable type to an unsinged version since it is not supposed to store
a negative number.

Added a timer to measure the pairing duration of the last attempt. This
is a great information to the autopair plugin to identify the cause of a
pairing failure. If a keyboard rejects the provided pincode in very short
time (less than 500ms) it means that the provided random pincode wasn't
the right code and is likelly that any random pincode will be rejected.
It turns out that those keyboards have a fixed pincode of "0000".

Please take another look.
Thanks,
Alex.

Alex Deymo (8):
  core: Convert the pincode callback to an interable list.
  plugins: Extend the pin code callback with the call number
  core: Add support for retrying a bonding
  core: retry bonding attempt until the iterator reachs the end.
  core: Add device_get_class to the public interface.
  autopair: Add the autopair plugin.
  core: Expose the last bonding attempt timeout on retry
  autopair: Try a fixed pincode for keyboards rejecting random codes

 Makefile.plugins   |   3 +
 plugins/autopair.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/wiimote.c  |   7 ++-
 src/adapter.c      | 163 ++++++++++++++++++++++++++++++++++++++++++++--------
 src/adapter.h      |  10 +++-
 src/device.c       | 134 ++++++++++++++++++++++++++++++++++++++++++-
 src/device.h       |   7 +++
 7 files changed, 462 insertions(+), 27 deletions(-)
 create mode 100644 plugins/autopair.c

-- 
1.8.1.3

