Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 0/2] shared/gatt-db: Add attribute database dump
Date: Fri, 30 May 2014 10:40:11 +0200
Message-Id: <1401439213-16384-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to dump attributes database content for debug purposes and PTS tests
needs.

Android API does not provide attribute handle information that is needes to
pass some PTS test cases. To avoid adding more and more logs to the daemon
databse, database dump is provided. This will simplify executing writes and
reads on some specific handles, which are requested by PTS and previously
required calling multiple API functions in haltest only to find proper attribute
to write to, or read from.

This dumps db in the following format:

[ att database dump start ]
attr_hnd: 00001, uuid: 2800, perm: 0000000, val_len: 00002, attr_value: 00 18                                            ..
attr_hnd: 00002, uuid: 2803, perm: 0000000, val_len: 00005, attr_value: 02 03 00 00 2a                                   ....*
attr_hnd: 00003, uuid: 2a00, perm: 0000001, val_len: 00000, attr_value: <read_cb>
.
.
.
attr_hnd: 00024, uuid: 2803, perm: 0000000, val_len: 00005, attr_value: 20 19 00 05 2a                                    ...*
attr_hnd: 00025, uuid: 2a05, perm: 0000001, val_len: 00000, attr_value:
attr_hnd: 00026, uuid: 2902, perm: 0000001, val_len: 00000, attr_value: <write_cb>
[ att database dump end ]

Regards,

Jakub Tyszkowski (2):
  shared/gatt-db: Add databse dump
  android/gatt: Add test command for database dump

 android/gatt.c       |  4 ++++
 android/hal-msg.h    |  1 +
 src/shared/gatt-db.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  2 ++
 4 files changed, 54 insertions(+)

--
1.9.3

