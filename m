Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org,
	marcel@holtmann.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH 0/6] The Autopair strikes back
Date: Wed, 20 Mar 2013 21:10:02 -0700
Message-Id: <1363839008-8405-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!
This is a rework of the autopair.c plugin we had at some point in BlueZ 4.

The goal of this patch set is to make the pairing process easier for 
devices that have a fixed and dumb pincode (like 0000 or 1234) or that
accept any pincode as long as the same pincode is entered on the device
(keyboards/combos). The goal is:
 * Don't ask the user (i.e. the agent) a question if we know the right answer.
This makes the user happier. =)

The covered constraints and scenarios are:
1. If the device has a well known pincode we should pair to it without
   asking the agent for a pin code (no RequestPincode call). Comon case are 
   mice and other devices with very limited input.
2. If the device accepts any pincode (as long as it is also entered in the
   device), we should provide the agent a random pincode (calling
   DisplayPincode) avoiding the unnecessary step of asking the agent for a
   [random] pincode (with RequestPincode). Comon case are keyboards/combos.
3. Don't return a failed error because we failed to guess the pincode. Retry
   instead until is not our fault (i.e., the device is out of range, the
   agent provided a wrong code, etc)
4. If the device accepts only a fixed pincode (and we don't know it) we
   should ask the agent for the pincode and be able to pair with the device.
   Read this as: don't break any compatibility.

The implemented logic is:
For each new org.bluez.Device1.Pair call that ends in a pin request (not SSP)
we *iterate* the list of pincode callbacks from plugins trying every callback
until it returns 0 (no pincode). For each pincode in this iteration, we try
to use it for the pin request. If it fails with an auth_failed, then we try
again with the next one until we reach the end of the list.
When we reach the end of the list, we try again but this time asking the
agent, thus following the current normal course (i.e. failing if there isn't
an agent registered, etc).

I'm open to hear your comments and look forward to have this patch set in.
If you find a problem or a device that doesn't work with this patch, please
let me know.
Thanks!

Alex Deymo (6):
  core: Convert the pincode callback to an interable list.
  plugins: Extend the pin code callback with the call number
  core: Add support for retrying a bonding
  core: retry bonding attempt until the iterator reachs the end.
  core: Add device_get_class to the public interface.
  autopair: Add the autopair plugin.

 Makefile.plugins   |   3 ++
 plugins/autopair.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/wiimote.c  |   7 ++-
 src/adapter.c      | 125 +++++++++++++++++++++++++++++++++++++--------
 src/adapter.h      |  10 +++-
 src/device.c       |  82 ++++++++++++++++++++++++++++--
 src/device.h       |   5 ++
 7 files changed, 350 insertions(+), 27 deletions(-)
 create mode 100644 plugins/autopair.c

-- 
1.8.1.3
