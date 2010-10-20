Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>, <suraj@atheros.com>, Johan Hedberg
	<johan.hedberg@gmail.com>, <joakim.xj.ceder@stericsson.com>,
	<arunkr.singh@stericsson.com>, Waldemar Rymarkiewicz
	<waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 0/1] Add Sim Access plugin
Date: Wed, 20 Oct 2010 09:55:07 +0200
Message-ID: <1287561308-18611-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
Sorry, I sent on to wrong list, so agian ...

Here you are the SAP plugin modified to reflect the audio/telephony design. 
Could anyone interested in do a review and put any comments.

Regards,
/Waldek


Waldemar Rymarkiewicz (1):
  Add Sim Access Plugin

 .gitignore      |    1 +
 Makefile.am     |   25 +-
 acinclude.m4    |   14 +
 doc/sap-api.txt |   57 ++
 sap/main.c      |   54 ++
 sap/manager.c   |   94 ++++
 sap/manager.h   |   21 +
 sap/sap-dummy.c |  306 +++++++++++
 sap/sap-ste.c   | 1265 ++++++++++++++++++++++++++++++++++++++++++++++
 sap/sap.h       |  187 +++++++
 sap/server.c    | 1516 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sap/server.h    |   23 +
 12 files changed, 3559 insertions(+), 4 deletions(-)
 create mode 100644 doc/sap-api.txt
 create mode 100644 sap/main.c
 create mode 100644 sap/manager.c
 create mode 100644 sap/manager.h
 create mode 100644 sap/sap-dummy.c
 create mode 100644 sap/sap-ste.c
 create mode 100644 sap/sap.h
 create mode 100644 sap/server.c
 create mode 100644 sap/server.h
