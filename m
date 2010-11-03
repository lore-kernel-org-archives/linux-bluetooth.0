Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <suraj@atheros.com>, Johan Hedberg <johan.hedberg@gmail.com>,
	<joakim.xj.ceder@stericsson.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 0/4] Sim Access Profile
Date: Wed, 3 Nov 2010 14:34:27 +0100
Message-ID: <1288791271-13857-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I fixed some issues raised by  Johan.
I will send patches in seperate emails.

@Johan: If there is no more comments could you consider to push it upstream?

Regards,
/Waldek


Waldemar Rymarkiewicz (4):
  Sim Access Profile API
  Sim Access Profile Manager
  Sim Access Profile Server
  Sim Access Profile dummy driver

 .gitignore      |    1 +
 Makefile.am     |   21 +-
 acinclude.m4    |   12 +
 doc/sap-api.txt |   57 ++
 sap/main.c      |   54 ++
 sap/manager.c   |   94 ++++
 sap/manager.h   |   21 +
 sap/sap-dummy.c |  304 +++++++++++
 sap/sap.h       |  187 +++++++
 sap/server.c    | 1514 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sap/server.h    |   25 +
 11 files changed, 2288 insertions(+), 2 deletions(-)
 create mode 100644 doc/sap-api.txt
 create mode 100644 sap/main.c
 create mode 100644 sap/manager.c
 create mode 100644 sap/manager.h
 create mode 100644 sap/sap-dummy.c
 create mode 100644 sap/sap.h
 create mode 100644 sap/server.c
 create mode 100644 sap/server.h

