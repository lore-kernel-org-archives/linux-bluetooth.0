Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH 00/11] gdbus: Better D-Bus introspection
Date: Wed, 23 May 2012 10:19:57 -0300
Message-Id: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Introspection patches to neard

Henrique Dante de Almeida (4):
  Constify GDBus method tables
  Constify GDBus signal tables
  Convert GDBus methods and signals to use macro helpers
  Do not set signature and reply in GDBus tables

Lucas De Marchi (7):
  gdbus: add argument info to methods and signals
  gdbus: add and use helpers for table declarations
  gdbus: use GDBusArgInfo to generate introspection
  gdbus: loop over args to check message signature
  gdbus: remove signature and reply from tables
  gdbus: add Deprecated annotation in introspection
  gdbus: add Method.NoReply annotation in introspection

 gdbus/gdbus.h  |   47 +++++++++++++++++++-
 gdbus/object.c |  132 +++++++++++++++++++++++++++-----------------------------
 src/adapter.c  |   23 ++++++----
 src/device.c   |   19 +++++---
 src/manager.c  |   19 +++++---
 src/ndef.c     |    6 ++-
 src/tag.c      |   18 +++++---
 7 files changed, 163 insertions(+), 101 deletions(-)

-- 
1.7.9.5

