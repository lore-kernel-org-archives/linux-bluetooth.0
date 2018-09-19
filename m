Return-Path: <brian.gix@intel.com>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	inga.stotland@intel.com,
	Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 0/2] Central Net Key storage cache for multiple Nodes
Date: Wed, 19 Sep 2018 13:40:03 -0700
Message-Id: <20180919204005.19267-1-brian.gix@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The strategy for Bluetooth Mesh is to allow each application that want to use
mesh services to operate as an independant Node on one or more Mesh networks.

To enable this, at the lowest network layer, we are creating a cache of Network
Keys and associated credentials (NIDs, Privacy Keys, Encryption Keys, etc).
This will allow Network decryption to be done once per incoming packets,
without requiring each "Node" on the local device to handle them redundantly.


Brian Gix (2):
  mesh: Add centralized caching Net Key management
  mesh: Refactor friend.c and net.c for central key DB

 Makefile.mesh    |   1 +
 mesh/friend.c    | 188 +++++++++-------------
 mesh/friend.h    |   2 +-
 mesh/net.c       | 476 +++++++++++++++----------------------------------------
 mesh/net.h       |  14 +-
 mesh/net_keys.c  | 326 +++++++++++++++++++++++++++++++++++++
 mesh/net_keys.h  |  33 ++++
 mesh/provision.c |   5 +-
 8 files changed, 572 insertions(+), 473 deletions(-)
 create mode 100644 mesh/net_keys.c
 create mode 100644 mesh/net_keys.h

-- 
2.14.4
