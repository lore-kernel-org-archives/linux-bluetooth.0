Return-Path: <cyrus@holtmann.org>
From: Natanael Copa <natanael.copa@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH v2 0/3] Various fixes for building bluez with musl libc
Date: Wed, 22 Jan 2014 13:50:17 +0000
Message-Id: <1390398620-1916-1-git-send-email-ncopa@alpinelinux.org>
In-Reply-To: <CABBYNZLmpK51xe80XxAwT7rBRkUGsZNhcmMWSnHSyuY--meu_w@mail.gmail.com>
References: <CABBYNZLmpK51xe80XxAwT7rBRkUGsZNhcmMWSnHSyuY--meu_w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes since v1:
- Add the compile errors in commit message
- Build unit testing with log support

Natanael Copa (3):
  various header include fixes for building with musl libc
  bnep: avoid use of caddr_t
  unit: prevent use of glibc's error(3)

 Makefile.am             | 1 +
 profiles/network/bnep.c | 4 ++--
 src/textfile.h          | 2 ++
 tools/csr_usb.c         | 1 +
 tools/hid2hci.c         | 1 +
 unit/test-sdp.c         | 9 +++------
 6 files changed, 10 insertions(+), 8 deletions(-)

-- 
1.8.5.3

