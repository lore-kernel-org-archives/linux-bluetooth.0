Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 19 Nov 2010 18:31:19 +0200
Message-ID: <AANLkTimQB+-odX2Yw+gxrdd2SBajxZ3nswtffW+L-g9_@mail.gmail.com>
Subject: Pull request git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Those changes fixes several issues when doing a Device.Disconnect
while some audio profile is still connecting. I did some cleanups to
make it easier to track references and reuse more code, and also did a
lot o testing to make sure it doesn't cause any regression for cases
where the client is using Media API or unix socket.

The following changes since commit 55685d2037d33ed29ed7365150fd14b5326690fb:

  Fix minor typo (2010-11-19 17:39:15 +0200)

are available in the git repository at:
  git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream

Luiz Augusto von Dentz (9):
      Cleanup a2dp setup code
      Cleanup a2dp_cancel code
      Fix not removing all timers when user request to disconnect audio
      Fix abort not being send when the state is idle
      Fix reference count of a2dp stream setup
      Add debug logs for state changes on sink
      Fix possible crashes when attempting to connect avdtp
      Fix not dropping avdtp session reference when cancelling stream setup
      Fix not indicating disconnected state when connecting to avdtp

 audio/a2dp.c   |  258 +++++++++++++++++++++++++------------------------------
 audio/avdtp.c  |   26 +++---
 audio/device.c |   36 ++++----
 audio/sink.c   |   13 +++
 4 files changed, 163 insertions(+), 170 deletions(-)

-- 
Luiz Augusto von Dentz
Computer Engineer
