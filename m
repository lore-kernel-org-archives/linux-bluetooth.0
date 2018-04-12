Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Maico Timmerman <maico.timmerman@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Maico Timmerman <maico.timmerman@gmail.com>
Subject: [PATCH 0/1] History for interactive shell across sessions.
Date: Thu, 12 Apr 2018 12:34:31 +0200
Message-Id: <20180412103432.9760-1-maico.timmerman@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GNU readline has support for reading and writing from/to file. This
patch implements reading of the history on startup and writes and
truncates the file on clean up.

Maico Timmerman (1):
  Client: Added support for the history file.

 AUTHORS            |  1 +
 client/main.c      |  1 +
 src/shared/shell.c | 23 +++++++++++++++++++++++
 src/shared/shell.h |  2 ++
 4 files changed, 27 insertions(+)

--
2.17.0

