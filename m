Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 00/13] Included service discovery
Date: Wed,  8 Oct 2014 10:31:37 +0200
Message-Id: <1412757110-3509-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In this version after primary service discovery,
secondary services are discovered. Next included
services are resolved. With this approach we
don't have recursively search for included service,
like it was TODO in previous proposal.
There is also small coding style fix suggested by Arman.
Comments are welcome

BR
Marcin

Marcin Kraglak (13):
  shared/gatt: Add discover_secondary_services()
  shared/gatt: Add initial implementation of discover_included_services
  shared/gatt: Discover included services 128 bit UUIDS
  shared/gatt: Add extra check in characteristic iterator
  shared/gatt: Add included service iterator
  shared/gatt: Remove not needed function parameter
  shared/gatt: Add function bt_gatt_result_included_count()
  shared/gatt: Distinguish Primary from Secondary services
  tools/btgatt-client: Print type of service
  shared/gatt: Discover secondary services
  shared/gatt: Discover included services
  shared/gatt: Add gatt-client include service iterator
  tools/btgatt-client: Print found include services

 src/shared/gatt-client.c  | 249 +++++++++++++++++++++++++--
 src/shared/gatt-client.h  |  18 ++
 src/shared/gatt-helpers.c | 418 +++++++++++++++++++++++++++++++++++++++++++---
 src/shared/gatt-helpers.h |  10 +-
 tools/btgatt-client.c     |  17 +-
 5 files changed, 678 insertions(+), 34 deletions(-)

-- 
1.9.3

