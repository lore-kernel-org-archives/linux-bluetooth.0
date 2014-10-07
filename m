Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] Add included services discovery
Date: Tue,  7 Oct 2014 09:19:19 +0200
Message-Id: <1412666365-9562-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set implements searching of included services.
It is based on previous patches to gatt-helper.
Additionally flag primary is introduced in bt_gatt_service_t
to know type of service. It will be needed in Android
gatt part too.
Included service discovery start right after primary discovery
finish. If include service declaration was found, and it was
not found in primary discovery, it's just simply added as
secondary service.
There is TODO part: we should check if included services
have other includes too, because nested includes are
allowed SPEC. We can consider recursive calls.

Comments are welcome
Marcin

Marcin Kraglak (6):
  shared/gatt: Distinguish Primary from Secondary services
  tools/btgatt-client: Print type of service
  shared/gatt: Discover included services
  shared/gatt: Add Secondary services to service_list
  shared/gatt: Add gatt-client include service iterator
  tools/btgatt-client: Print found include services

 src/shared/gatt-client.c | 203 +++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/gatt-client.h |  18 +++++
 tools/btgatt-client.c    |  17 +++-
 3 files changed, 231 insertions(+), 7 deletions(-)

-- 
1.9.3

