Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 0/4] Abort on small allocations
Date: Mon, 19 Oct 2015 22:30:54 +0200
Message-Id: <1445286658-11969-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patchset is an initial work to simplify handling of memory allocation
failes in BlueZ. The solution is simple: don't check for errors and just
abort if allocation fails.

This make error paths (which were most likely never executed) *much* simpler.

Another benefit is increased similarity of src/shared APIs to already used
Glib APIs which also abort on allocation error (unless _try variant is used).
This makes transition from Glib APIs to shared APIs easier.

Patches 1-3 are samples that show how much of the error handling code
can be removed. Those are initial patches as 'never-fail' API propagates up
(new0()->queue_new()->foo_add()) and futher error handling can be removed.

Comments are welcome.

Szymon Janc (4):
  shared: Make new0 abort on failure
  shared: Remove dead code
  android: Remove dead code
  core: Remove dead code

 android/avdtp.c               |   5 +-
 android/avdtptest.c           |   4 -
 android/bas.c                 |  55 +------
 android/bluetooth.c           |  17 ---
 android/dis.c                 |  11 --
 android/gatt.c                | 336 +++++-------------------------------------
 android/handsfree-client.c    |  14 +-
 android/handsfree.c           |   9 +-
 android/health.c              |  67 ++-------
 android/hog.c                 |   2 -
 android/scpp.c                |  22 +--
 android/tester-a2dp.c         |   7 +-
 android/tester-avrcp.c        |   7 +-
 android/tester-bluetooth.c    |   7 +-
 android/tester-gatt.c         |   7 +-
 android/tester-hdp.c          |   7 +-
 android/tester-hidhost.c      |   7 +-
 android/tester-map-client.c   |   7 +-
 android/tester-pan.c          |   7 +-
 android/tester-socket.c       |   7 +-
 src/advertising.c             |   6 -
 src/gatt-client.c             |  67 ---------
 src/gatt-database.c           | 100 -------------
 src/shared/ad.c               |  31 ----
 src/shared/att.c              |  34 +----
 src/shared/crypto.c           |   2 -
 src/shared/gap.c              |   7 -
 src/shared/gatt-client.c      |  59 --------
 src/shared/gatt-db.c          |  37 -----
 src/shared/gatt-helpers.c     |  24 ---
 src/shared/gatt-server.c      |  47 ------
 src/shared/hci-crypto.c       |   6 -
 src/shared/hci.c              |  29 ----
 src/shared/hfp.c              |  40 -----
 src/shared/io-mainloop.c      |   3 -
 src/shared/mgmt.c             |  42 ------
 src/shared/queue.c            |  12 --
 src/shared/ringbuf.c          |   3 -
 src/shared/tester.c           |   9 --
 src/shared/timeout-mainloop.c |   3 -
 src/shared/uhid.c             |   8 -
 src/shared/util.c             |  16 ++
 src/shared/util.h             |  14 +-
 43 files changed, 97 insertions(+), 1107 deletions(-)

-- 
2.5.0

