Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 11 Oct 2010 16:09:14 +0300
Message-ID: <AANLkTikWCgaXMyRZcpKAsZq19-NzPD_U7YpA=_cFtFQX@mail.gmail.com>
Subject: Pull request git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following changes since commit 646f0c7e6b557c5413825ce7b04bee52bf0129e8:

  Move remote name and version requests to hciops (2010-10-10 22:44:25 +0100)

are available in the git repository at:
  git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream

Luiz Augusto von Dentz (8):
      Fix not always signalling new streams when acting as a sink
      Fix not replying an error in case of endpoint request timeout
      Add source if the device attempt to configure a stream with a local sink
      Make use of avdtp category when setting errors
      Fix blocking on setconf confirmation callback
      Fix blocking on setconf indication callback
      Fix blocking when calling endpoint on hsp/hfp connection
      Remove unused code

 audio/a2dp.c   |  239 ++++++++++++++++++++++++++++++++++++++++----------------
 audio/avdtp.c  |  117 ++++++++++++++++++----------
 audio/avdtp.h  |   19 +++--
 audio/media.c  |   54 +++++--------
 audio/sink.c   |    4 +-
 audio/source.c |    4 +-
 6 files changed, 281 insertions(+), 156 deletions(-)

-- 
Luiz Augusto von Dentz
Computer Engineer
