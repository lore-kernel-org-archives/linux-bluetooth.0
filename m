Return-Path: <cyrus@holtmann.org>
From: Zygo Blaxell <zygo.blaxell@xandros.com>
To: linux-bluetooth@vger.kernel.org
Subject: A funny thing happened while comparing bluez-4.40.tar.gz with git tag 4.40...
Date: Thu,  4 Jun 2009 16:05:37 -0400
Message-Id: <1244145939-32456-1-git-send-email-zygo.blaxell@xandros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


There are a number of files in the git tree which do not appear in the
distributed tar.gz files.  Most of them seem to be obsolete, with the
exception of test/test-network.  hcid.conf is especially confusing
for users.

 audio/module-bluetooth-sink.c |   39 -------
 doc/node-api.txt              |   28 -----
 src/hcid.conf                 |   57 ----------
 src/hcid.conf.5               |  227 -----------------------------------------
 test/Makefile.am              |    2 +-
 5 files changed, 1 insertions(+), 352 deletions(-)
