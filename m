Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v3 0/8] Autopair plugin
Date: Tue, 23 Apr 2013 11:03:59 -0700
Message-Id: <1366740247-368-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Verified and applied this patchset to HEAD with the syntax checks.
Some little checks and typos fixed. There is only one warning about
CamelCase with GSList * (ignored).

Sorry for the inconvenience.
Alex.

Alex Deymo (8):
  core: Convert the pincode callback to an interable list.
  plugins: Extend the pin code callback with the call number
  core: Add support for retrying a bonding
  core: retry bonding attempt until the iterator reaches the end.
  core: Add device_get_class to the public interface.
  autopair: Add the autopair plugin.
  core: Expose the last bonding attempt timeout on retry
  autopair: Try a fixed pincode for keyboards rejecting random codes

 Makefile.plugins   |   3 +
 plugins/autopair.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/wiimote.c  |   7 ++-
 src/adapter.c      | 167 +++++++++++++++++++++++++++++++++++++++++++++--------
 src/adapter.h      |  10 +++-
 src/device.c       | 132 +++++++++++++++++++++++++++++++++++++++++-
 src/device.h       |   7 +++
 7 files changed, 464 insertions(+), 27 deletions(-)
 create mode 100644 plugins/autopair.c

-- 
1.8.2.1
