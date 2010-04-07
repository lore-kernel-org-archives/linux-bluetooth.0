Return-Path: <cyrus@holtmann.org>
From: Francisco Alecrim <francisco.alecrim@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>
Subject: [PATCH v3 0/2] Services through DBus and correct EIR
Date: Wed,  7 Apr 2010 12:25:48 -0400
Message-Id: <1270657550-28767-1-git-send-email-francisco.alecrim@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Third version:
** Indent change at adapter_emit_uuids_updated
** Use g_strfreev instead of loop to free **uuids.

Francisco Alecrim (2):
  Report local services(UUIDs) through DBus
  Correct UUIDs list to EIR

 doc/adapter-api.txt |    5 +++
 src/adapter.c       |   87 +++++++++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.h       |    2 +
 src/sdpd-database.c |    4 ++
 src/sdpd-service.c  |    5 ++-
 src/sdpd.h          |    3 +-
 test/list-devices   |    3 ++
 7 files changed, 104 insertions(+), 5 deletions(-)

