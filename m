Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>, <padovan@profusion.mobi>, Marcel
 Holtmann <marcel@holtmann.org>, Waldemar Rymarkiewicz
	<waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v2 0/4] Sim Access Profile
Date: Thu, 24 Feb 2011 13:13:22 +0100
Message-ID: <1298549606-16594-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Here you are the SAP codes adjusted to previous comments and API change.

/Waldek


Waldemar Rymarkiewicz (4):
  Sim Access Profile API
  Sim Access Profile Manager
  Sim Access Profile Server
  Sim Access Profile dummy driver

 .gitignore      |    1 +
 Makefile.am     |   22 +-
 acinclude.m4    |   12 +
 doc/sap-api.txt |   34 ++
 sap/main.c      |   55 +++
 sap/manager.c   |   93 ++++
 sap/manager.h   |   22 +
 sap/sap-dummy.c |  328 +++++++++++++
 sap/sap.h       |  192 ++++++++
 sap/server.c    | 1425 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sap/server.h    |   26 +
 11 files changed, 2208 insertions(+), 2 deletions(-)
 create mode 100644 doc/sap-api.txt
 create mode 100644 sap/main.c
 create mode 100644 sap/manager.c
 create mode 100644 sap/manager.h
 create mode 100644 sap/sap-dummy.c
 create mode 100644 sap/sap.h
 create mode 100644 sap/server.c
 create mode 100644 sap/server.h
