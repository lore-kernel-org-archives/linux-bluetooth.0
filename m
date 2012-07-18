Return-Path: <cyrus@holtmann.org>
From: Harald Schmitt <linux@hschmitt.de>
To: linux-bluetooth@vger.kernel.org
Cc: Harald Schmitt <linux@hschmitt.de>
Subject: [PATCH 0/2] obexd: Fix bug in irmc phonebook and prevent to reintroduce it
Date: Wed, 18 Jul 2012 16:53:06 +0200
Message-Id: <1342623188-10796-1-git-send-email-linux@hschmitt.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset fixes a bug in irmc plugin the same way as it was sent
today, but with a commit message. The second patch defines macros in
phonebook.h for the well known phonbook folders and names and replaces
those magic values.

Harald Schmitt (2):
  irmc: Fix phonebook contacts query
  phonebook: Replace magic strings for phonebook names and folders

 plugins/irmc.c              |    4 ++--
 plugins/phonebook-ebook.c   |   14 ++++++-------
 plugins/phonebook-tracker.c |   48 +++++++++++++++++++++----------------------
 plugins/phonebook.h         |   13 ++++++++++++
 4 files changed, 46 insertions(+), 33 deletions(-)

-- 
1.7.9.5

