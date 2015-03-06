Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/7] shared/gatt-client: Add support for prepare/execute write
Date: Fri,  6 Mar 2015 14:10:38 +0100
Message-Id: <1425647445-19722-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is v2 of previous [PATCH 1/2] shared/gatt-client: Add write prepare and execute

v2 handles comments from Luiz plus some clean ups.

Main change is that gatt client can start reliable session by calling write prepare
with id == 0. In return gatt client will get session id which should be used in
following write prepare and execute write.

This set also makes sure that on bt_gatt_client_cancel, reliable session will be
correctly terminated.

Last patch adds means to test this with btgatt-client

Lukasz Rymanowski (7):
  tools/btgatt-client: Minor fix of menu alignment
  shared/gatt-client: Add helper to cancel long write request
  shared/gatt-client: Make usage of cancel_long_write_cb
  shared/gatt-client: Add write prepare and execute
  shared/gatt-client: Add coexistence of long write and prepare write
  shared/gatt-client: Support cancel of prepare write
  tools/btgatt-client: Add prepare and execute write

 src/shared/gatt-client.c | 350 ++++++++++++++++++++++++++++++++++++++++++-----
 src/shared/gatt-client.h |  13 ++
 tools/btgatt-client.c    | 211 +++++++++++++++++++++++++++-
 3 files changed, 540 insertions(+), 34 deletions(-)

-- 
1.8.4

