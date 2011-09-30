Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/4] MediaPlayer agent registration
Date: Fri, 30 Sep 2011 16:10:39 +0300
Message-Id: <1317388243-26240-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Current interface using device object has some limitation as it was not
designed to track clients e.g. test-media-player disconnects after
using it, making it almost impossible to handle multiple clients
properly.

Another problem is that by using the device object it increase the
complexity of the clients since they have to discover the device object
to use it and check if it has AVRCP uuid to be able to use MediaPlayer
interface.

So this changes move the MediaPlayer to the clients, so they register
themselves using Media.RegisterPlayer and creates a more clear
separation between AVRCP Player and a system MediaPlayer.

Luiz Augusto von Dentz (4):
  AVRCP: move MediaPlayer to adapter object
  Add simple-player test script
  Remove MediaPlayer interface from control-api.txt
  Remove test-media-player

 audio/avrcp.c          |  824 +++++++++---------------------------------------
 audio/avrcp.h          |   67 ++++-
 audio/device.c         |    3 -
 audio/device.h         |    2 -
 audio/manager.c        |    7 -
 audio/media.c          |  800 ++++++++++++++++++++++++++++++++++++++++++++++
 doc/control-api.txt    |   47 ---
 doc/media-api.txt      |  163 ++++++++++
 test/simple-player     |   56 ++++
 test/test-media-player |  108 -------
 10 files changed, 1237 insertions(+), 840 deletions(-)
 create mode 100755 test/simple-player
 delete mode 100755 test/test-media-player

-- 
1.7.6.2

