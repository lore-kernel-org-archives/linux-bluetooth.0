Return-Path: <cyrus@holtmann.org>
From: Jakub Adamek <adamek.kuba@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Adamek <adamek.kuba@gmail.com>
Subject: [RFC obexd 0/4] Rework get_next_header function
Date: Fri, 12 Aug 2011 01:43:04 +0200
Message-Id: <1313106188-30273-1-git-send-email-adamek.kuba@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
the existing code provides a mimetype driver function that allows
drivers to specify their own return headers - get_next_header.

These patches change this function and the code that uses it
to be able to:
a) specify return headers in PUT operations (currently the function
is only called for GET),
b) change criteria for signaling that all headers have been sent
to setting the header number to OBEX_HEADER_EMPTY (currently this
is done by setting the header data length to 0, which prevents us
from actually returning headers with 0 data length),
c) provide way to return 8 and 32 bit headers (current code only
supports the variable length header types).

Jakub Adamek (4):
  Call get_next_header in PUT operations
  Stop get_next_headers on OBEX_HEADER_EMPTY
  Adapt get_next_header for 1 and 4 byte headers
  Adapt PBAP to changes in get_next_header behaviour

 plugins/pbap.c  |    2 +
 src/obex-priv.h |    1 +
 src/obex.c      |  224 ++++++++++++++++++++++++++++++++++++-------------------
 src/obex.h      |    3 +
 4 files changed, 153 insertions(+), 77 deletions(-)

-- 
1.7.4.1

