Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCHv2 BlueZ 0/2] configure.ac fixes
Date: Sun, 10 Feb 2013 22:20:49 +0100
Message-Id: <1360531251-18371-1-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1359906411-12624-1-git-send-email-ospite@studenti.unina.it>
References: <1359906411-12624-1-git-send-email-ospite@studenti.unina.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Patch 1 fixes --with-* options, it should be OK as Marcel
acknowledged.

Patch 2 is more for the sake of regularity with USB_CFLAGS and
USB_LIBS, it's not strictly necessary.

Thanks,
   Antonio

Antonio Ospite (2):
  configure.ac: call AC_SUBST unconditionally with --with-* options
  Call AC_SUBST(*_CFLAGS) and AC_SUBST(*_LIBS) only when needed

 configure.ac |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
