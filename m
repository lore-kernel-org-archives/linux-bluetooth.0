Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 0/2] Add support for AES-CMAC-128
Date: Tue, 13 May 2014 12:44:26 +0200
Message-Id: <1399977868-31937-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series adds support for AES-CMAC-128 as defined in NIST Special
Publication 800-38B (http://csrc.nist.gov/publications/PubsSPs.html)

It also adds unit tests.

To consider: If it should be included into crypto.c instead of new file.

I put it into new file as there is need to keep some special data for the
aes-cmac session i.e. sub keys and sign_counter.

Lukasz Rymanowski (2):
  shared/aes-cmac: Add support for AES-CMAC-128
  unit: Add test case for AES-CMAC-128

 Makefile.am           |   8 +-
 src/shared/aes-cmac.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/aes-cmac.h |  38 ++++++
 unit/test-aes-cmac.c  | 169 ++++++++++++++++++++++++
 4 files changed, 560 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/aes-cmac.c
 create mode 100644 src/shared/aes-cmac.h
 create mode 100644 unit/test-aes-cmac.c

-- 
1.8.4

