Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 22 Sep 2010 16:45:15 +0300
Message-ID: <AANLkTikKc3E3wPkkP3U+mbZUa6UyqCAeRoPhEhwY0AAb@mail.gmail.com>
Subject: Pull request: git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following changes since commit cca89b3d5c78c29065a88ce099dea36137bea225:

  Release 4.72 (2010-09-22 19:48:34 +0900)

are available in the git repository at:
  git://gitorious.org/~vudentz/bluez/vudentzs-clone.git for-upstream

Luiz Augusto von Dentz (5):
      Fix registering local endpoints when Socket interface is disabled
      Remove ReadLock and WriteLock from MediaTransport properties
      Replace use of term 'Renderer' with 'Owner'
      Make MediaEndpoint.SetConfiguration to take all transport properties
      Make MediaEndpoint.ClearConfiguration to take transport path

 audio/a2dp.c      |   13 ++++++++++++-
 audio/media.c     |   22 ++++++++++++++--------
 audio/transport.c |   43 ++++++++++++++++++++++---------------------
 audio/transport.h |    2 ++
 doc/media-api.txt |    6 +++---
 5 files changed, 53 insertions(+), 33 deletions(-)

-- 
Luiz Augusto von Dentz
Computer Engineer
