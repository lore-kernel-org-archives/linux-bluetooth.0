Return-Path: <cyrus@holtmann.org>
From: lkslawek@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Message Access Profile plugin
Date: Wed,  2 Mar 2011 10:36:50 +0100
Message-Id: <1299058614-8904-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These are the first ones of upcoming series of patches implementing Message
Access Profile (server role) in obexd. 

The work is more than less complete (~4k lines now), but as advised by Johan,
I'm cutting the whole thing into smaller pieces before sending this here.

Regards,
Slawomir Bochenski

 .gitignore               |    1 +
 Makefile.am              |   10 ++-
 configure.ac             |   12 ++
 plugins/mas.c            |  338 ++++++++++++++++++++++++++++++++++++++++++++++
 plugins/messages-dummy.c |   28 ++++
 plugins/messages.h       |   37 +++++
 src/main.c               |   11 ++-
 src/obex.h               |    1 +
 8 files changed, 435 insertions(+), 3 deletions(-)
