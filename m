Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 19 Jan 2011 14:15:40 +0200
Message-ID: <AANLkTikmELbxWrZkTe_9UcK0q01cwJoQsmFkMzppsEtV@mail.gmail.com>
Subject: Pull request git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following changes since commit effe770cd43cf53fa5842291941dbfc82beab645:

  Use -DG_DISABLE_DEPRECATED compiler define (2011-01-18 14:56:31 +0100)

are available in the git repository at:
  git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream

Luiz Augusto von Dentz (7):
      Fix use of deprecated glib on audio plugin
      Fix use of deprecated glib on input plugin
      Fix use of deprecated glib on network plugin
      Fix use of deprecated glib on serial plugin
      Fix use of deprecated glib on hciops plugin
      Fix use of deprecated glib on core
      Fix use of deprecated glib on tests

 audio/avdtp.c        |   10 ++-
 audio/gstavdtpsink.c |  162 +++++++++++++++++++++++++-------------------------
 audio/headset.c      |   13 +++--
 audio/unix.c         |    2 +-
 input/device.c       |   12 +++-
 input/fakehid.c      |   10 ++-
 network/connection.c |   14 ++--
 plugins/hciops.c     |   24 ++++---
 serial/proxy.c       |   40 ++++++------
 src/rfkill.c         |   11 ++--
 src/storage.c        |    2 +-
 test/hciemu.c        |   15 +++--
 12 files changed, 168 insertions(+), 147 deletions(-)

-- 
Luiz Augusto von Dentz
Computer Engineer
