Return-Path: <john@metanate.com>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	John Keeping <john@metanate.com>
Subject: [PATCH 0/2] Install btattach with "make install"
Date: Wed,  2 Dec 2015 10:34:58 +0000
Message-Id: <1449052500-10755-1-git-send-email-john@metanate.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Following a discussion last week [1], it seems that btattach should be
used in preference to hciattach when possible.  This series adds a
manual page for it and updates the makefile so that btattach is
installed via the standard mechanism.

For now, btattach is still marked as experimental so it wil only be
built and installed when experimental features are enabled.

[1] http://article.gmane.org/gmane.linux.bluez.kernel/65807

John Keeping (2):
  tools/btattach: add manual page
  tools/btattach: install during "make install"

 Makefile.tools   |  8 +++++++-
 tools/btattach.1 | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 tools/btattach.1

-- 
2.6.3.462.gbe2c914
