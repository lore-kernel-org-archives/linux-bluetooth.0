Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v4 0/6] SIM Access Profile v4
Date: Tue, 15 Mar 2011 17:43:15 +0100
Message-ID: <1300207401-23438-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

See next version of sap patchset. 
I fixed a text license for both already upstreamed patches and those not yet pushed.

/Waldek


Waldemar Rymarkiewicz (6):
  Adjust sap/server.c license text to the rest of the code
  Sim Access Profile Server
  Sim Access Profile connect/disconnect procedures
  Add support for SAP protocol
  Sim Access Profile dummy driver
  Sim Access Profile test scripts

 .gitignore       |    1 +
 Makefile.am      |   14 +-
 acinclude.m4     |    6 +
 sap/sap-dummy.c  |  328 +++++++++++++
 sap/sap.h        |  186 ++++++++
 sap/server.c     | 1395 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 test/sap.py      |  944 ++++++++++++++++++++++++++++++++++++
 test/test-sap.py |  139 ++++++
 8 files changed, 3003 insertions(+), 10 deletions(-)
 create mode 100644 sap/sap-dummy.c
 create mode 100644 sap/sap.h
 create mode 100644 test/sap.py
 create mode 100755 test/test-sap.py

