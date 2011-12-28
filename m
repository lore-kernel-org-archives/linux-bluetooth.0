Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Multi-Adapter GATT server (finish) 
Date: Wed, 28 Dec 2011 11:24:42 +0100
Message-Id: <1325067890-6953-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set of patches complete the multi-adapter gatt server support. They
modify the gatt server interface to provide the bluetooth adapter which
the gatt server is running. These patches can safetily be applyied on top
of the latest patches sent wich introduces the changes suggested in the
mailing list to provide the initial support for multi-adapter support.

Time and Proximity plugins still need a code refactorization to be
consistent with this new architecture.

[PATCH 1/8] attrib-server: Add blutooth adapter to
[PATCH 2/8] attrib-server: Add bluetooth adapter in attrib_db_add
[PATCH 3/8] gatt-service: Add bluetooth adapter in gatt_service_add
[PATCH 4/8] attrib-server: Add bluetooth adapter in attrib_db_update
[PATCH 5/8] attrib-server: Add bluetooth adapter in attrib_gap_set
[PATCH 6/8] attrib-server: Add bluetooth adapter in attrib_db_del
[PATCH 7/8] attrib-server: Add bluetooth adapter in
[PATCH 8/8] attrib-server: Add Gattrib in attrib_channel_detach
