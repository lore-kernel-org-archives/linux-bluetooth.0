Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v4 0/8] Autopair
Date: Fri, 26 Apr 2013 13:05:33 -0700
Message-Id: <1367006741-28907-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
All the comments made by Johan are addressed now. Removed the introduced
GLib dependency and replaced it with clock_gettime(). Removed the
bonding_req.capability field and compute it using the agent field.

Best regards,
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
 plugins/autopair.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/wiimote.c  |   7 ++-
 src/adapter.c      | 163 ++++++++++++++++++++++++++++++++++++++++++++--------
 src/adapter.h      |  10 +++-
 src/device.c       | 135 +++++++++++++++++++++++++++++++++++++++++++
 src/device.h       |   7 +++
 7 files changed, 465 insertions(+), 25 deletions(-)
 create mode 100644 plugins/autopair.c

-- 
1.8.2.1
