Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v5 0/8] Autopair
Date: Wed,  8 May 2013 17:37:54 -0700
Message-Id: <1368059882-9986-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again!
Changes from the v4 are:
* uint32_t --> unsigned int for the "attempt" argument. I think that
restrict that value to unsigned given that -1 is never used for
attempt is a good practice.
* "pincb_iter" --> "btd_adapter_pin_cb_iter". The "pin_cb" instead
of "pincb" is to match the btd_adapter_pin_cb_t callback type
already used in the code.
* Added a bool pincode_requested member to btd_adapter (see patch 4/8)
to signal if the device requested a pincode during the bonding attempt.
This is basically to fix the case were we keep retrying the bonding
and the device keeps sending an authentication error without consuming
a pin code from the pincode callback list. This ensures that either a
pincode was consumed from the list before retrying. Together with the
fact that the pin codes provided by the callback list is a finite list,
this ensures the retry mechanism will finish.

Please consider this version for bluez. We are actively testing this
patchset in our last chromiumos release and I don't have any bug reported
regarding this feature. Thanks!
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
 plugins/autopair.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/wiimote.c  |   7 ++-
 src/adapter.c      | 175 ++++++++++++++++++++++++++++++++++++++++++++++-------
 src/adapter.h      |  11 +++-
 src/device.c       | 135 +++++++++++++++++++++++++++++++++++++++++
 src/device.h       |   7 +++
 7 files changed, 478 insertions(+), 25 deletions(-)
 create mode 100644 plugins/autopair.c

-- 
1.8.2.1
