Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 0/7] Sim Access Client Implementation
Date: Thu,  4 Aug 2011 16:39:27 -0300
Message-Id: <1312486774-20350-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

I'm working to have the SAP Client working in BlueZ + oFono.  This is BlueZ
side implementation, it uses an Agent scheme to talk with oFono. The API is the
same as HandsFreeGateway.
The plugin goal is just create a 'gateway' between oFono and the remote device,
all SAP specific data is handled by oFono.
This is most Claudio's code that I rebased and did some fixing.

Claudio Takahasi (7):
  sap: initial SIM access client support
  sap: add SAP client agent
  sap: add Connected signal on SimAccess client interface
  sap: handle agent exit case
  sap: disconnect RFCOMM when Disconnect gets called
  sap: send file descriptor to the registered agent
  doc: add SimAccess client API

 Makefile.am           |    1 +
 doc/simaccess-api.txt |   90 ++++++++++
 sap/client.c          |  464 +++++++++++++++++++++++++++++++++++++++++++++++++
 sap/client.h          |   29 +++
 sap/manager.c         |   76 ++++++++-
 sap/sap.h             |    2 +
 sap/server.c          |    1 -
 7 files changed, 656 insertions(+), 7 deletions(-)
 create mode 100644 doc/simaccess-api.txt
 create mode 100644 sap/client.c
 create mode 100644 sap/client.h

-- 
1.7.6

