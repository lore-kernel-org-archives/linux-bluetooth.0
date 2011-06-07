Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: Various GET functionality fixes (obsoletes: Renewed new missed calls handling)
Date: Tue,  7 Jun 2011 15:09:57 +0200
Message-Id: <1307452201-11057-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These make the previous patch set I've sent obsolete.

Fist two patches are a clean-up of some code doing nothing.

Third patch is for proper (that is, the one required for PBAP and MAP)
headers order. Here solution for sending application parameters header
first is done inside obex_write_stream() (as suggested by Luiz), making
it work automatically (no changes to pbap coded needed).

The last patch offers a fix for a cases when read woken by
obex_object_set_io_flags() would not deliver enough data to fill OBEX
MTU, in which case asynchronous functionality was broken.

