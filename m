Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ 00/11] Introduce LE Advertisement D-Bus API
Date: Thu, 12 Mar 2015 10:11:47 -0700
Message-Id: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Introduces and starts implementation of a LE Advertisement API.

Things that are missing still and will come soon:
 * MGMT API for modifying the LE Advertisements
 * Semantics for multiple Advertisements (currently any more than one will fail)
 * TX Power property parsing / interface

Michael Janssen (12):
  doc: Add LE Advertisement D-Bus API documentation
  core: advertising: add LEAdvertisingManager stubs
  advertising-manager: Implement RegisterAdvertisement
  tools: Python script to test Advertisement API
  advertising-manager: implement UnregisterAdvertisement
  core: add advertising-data
  advertising-manager: use advertising_data
  advertising-manager: Parse ServiceUUIDs
  advertising-manager: Parse SolicitUUIDs
  advertising-manager: Parse ManufacturerSpecificData
  advertising-manager: Parse ServiceData
  Update TODO for LE Advertising

 Makefile.am                   |   3 +
 TODO                          |  21 +-
 doc/advertising-api.txt       |  94 ++++++
 src/adapter.c                 |  19 ++
 src/advertising-manager.c     | 646 ++++++++++++++++++++++++++++++++++++++++++
 src/advertising-manager.h     |  25 ++
 src/shared/advertising-data.c | 350 +++++++++++++++++++++++
 src/shared/advertising-data.h |  69 +++++
 tools/advertisement-example   | 174 ++++++++++++
 9 files changed, 1391 insertions(+), 10 deletions(-)
 create mode 100644 doc/advertising-api.txt
 create mode 100644 src/advertising-manager.c
 create mode 100644 src/advertising-manager.h
 create mode 100644 src/shared/advertising-data.c
 create mode 100644 src/shared/advertising-data.h
 create mode 100644 tools/advertisement-example

-- 
2.2.0.rc0.207.ga3a616c

