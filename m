Return-Path: <cyrus@holtmann.org>
From: Francisco Alecrim <francisco.alecrim@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>
Subject: [PATCH v2 0/2] Services through DBus and correct EIR
Date: Wed,  7 Apr 2010 11:04:21 -0400
Message-Id: <1270652663-23107-1-git-send-email-francisco.alecrim@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Second version: 
** Remove unnecessary braces. Thanks Padovan!
** Correct some lines over 80 characters

* Claudio Takahasi suggested to use a list of uuid_t instead of sdp_list_t at
adapters->services. I consider sdp_list_t easy to use regarding functions
available at sdp_lib.h.

Francisco Alecrim (2):
  Report local services(UUIDs) through DBus
  Correct UUIDs list to EIR

 doc/adapter-api.txt |    5 +++
 src/adapter.c       |   92 +++++++++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.h       |    2 +
 src/sdpd-database.c |    4 ++
 src/sdpd-service.c  |    5 ++-
 src/sdpd.h          |    3 +-
 test/list-devices   |    3 ++
 7 files changed, 109 insertions(+), 5 deletions(-)

