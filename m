Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>
CC: <padovan@profusion.mobi>, Marcel Holtmann <marcel@holtmann.org>, Waldemar
 Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v3 0/5] SIM Access Profile v3
Date: Mon, 14 Mar 2011 12:16:15 +0100
Message-ID: <1300101380-10358-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Thanks for your last comments. I've fixed them and as you suggested I split the SAP server patch into 3 smaller patches.
I hope this will help with a review.

Thanks,
/Waldek


Waldemar Rymarkiewicz (5):
  Sim Access Profile Server
  Sim Access Profile connect/disconnect procedures
  Add support for SAP protocol
  Sim Access Profile dummy driver
  Sim Access Profile test scripts

 .gitignore       |    1 +
 Makefile.am      |   14 +-
 acinclude.m4     |    6 +
 sap/sap-dummy.c  |  328 +++++++++++++
 sap/sap.h        |  187 ++++++++
 sap/server.c     | 1395 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 test/sap.py      |  945 ++++++++++++++++++++++++++++++++++++
 test/test-sap.py |  140 ++++++
 8 files changed, 3006 insertions(+), 10 deletions(-)
 create mode 100644 sap/sap-dummy.c
 create mode 100644 sap/sap.h
 create mode 100644 test/sap.py
 create mode 100755 test/test-sap.py
