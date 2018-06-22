Return-Path: <johan.hedberg@gmail.com>
From: Inga Stotland <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/2] Directory re-org for meshctl tool
Date: Thu, 21 Jun 2018 23:31:58 -0700
Message-Id: <20180622063200.7394-1-inga.stotland@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This set of patches moves mechctl tool code from under bluez/mesh
into tools directory.

mesh directory will be re-established with the implementation of mesh
daemon.

Inga Stotland (2):
  tools: Move meshctl tool under tools directory
  tools: Move meshctl sources under tools/mesh directory

 Makefile.tools                       | 48 ++++++++++++++++++------------------
 {mesh => tools/mesh}/README          |  0
 {mesh => tools/mesh}/agent.c         |  4 +--
 {mesh => tools/mesh}/agent.h         |  0
 {mesh => tools/mesh}/config-client.c | 14 +++++------
 {mesh => tools/mesh}/config-model.h  |  0
 {mesh => tools/mesh}/config-server.c | 14 +++++------
 {mesh => tools/mesh}/crypto.c        |  4 +--
 {mesh => tools/mesh}/crypto.h        |  0
 {mesh => tools/mesh}/gatt.c          | 10 ++++----
 {mesh => tools/mesh}/gatt.h          |  0
 {mesh => tools/mesh}/keys.h          |  0
 {mesh => tools/mesh}/local_node.json |  0
 {mesh => tools/mesh}/mesh-net.h      |  0
 {mesh => tools/mesh}/net.c           | 16 ++++++------
 {mesh => tools/mesh}/net.h           |  0
 {mesh => tools/mesh}/node.c          | 16 ++++++------
 {mesh => tools/mesh}/node.h          |  0
 {mesh => tools/mesh}/onoff-model.c   | 14 +++++------
 {mesh => tools/mesh}/onoff-model.h   |  0
 {mesh => tools/mesh}/prov-db.c       | 14 +++++------
 {mesh => tools/mesh}/prov-db.h       |  0
 {mesh => tools/mesh}/prov.c          | 16 ++++++------
 {mesh => tools/mesh}/prov.h          |  0
 {mesh => tools/mesh}/prov_db.json    |  0
 {mesh => tools/mesh}/util.c          |  6 ++---
 {mesh => tools/mesh}/util.h          |  0
 mesh/main.c => tools/meshctl.c       |  0
 28 files changed, 88 insertions(+), 88 deletions(-)
 rename {mesh => tools/mesh}/README (100%)
 rename {mesh => tools/mesh}/agent.c (98%)
 rename {mesh => tools/mesh}/agent.h (100%)
 rename {mesh => tools/mesh}/config-client.c (99%)
 rename {mesh => tools/mesh}/config-model.h (100%)
 rename {mesh => tools/mesh}/config-server.c (94%)
 rename {mesh => tools/mesh}/crypto.c (99%)
 rename {mesh => tools/mesh}/crypto.h (100%)
 rename {mesh => tools/mesh}/gatt.c (98%)
 rename {mesh => tools/mesh}/gatt.h (100%)
 rename {mesh => tools/mesh}/keys.h (100%)
 rename {mesh => tools/mesh}/local_node.json (100%)
 rename {mesh => tools/mesh}/mesh-net.h (100%)
 rename {mesh => tools/mesh}/net.c (99%)
 rename {mesh => tools/mesh}/net.h (100%)
 rename {mesh => tools/mesh}/node.c (98%)
 rename {mesh => tools/mesh}/node.h (100%)
 rename {mesh => tools/mesh}/onoff-model.c (96%)
 rename {mesh => tools/mesh}/onoff-model.h (100%)
 rename {mesh => tools/mesh}/prov-db.c (99%)
 rename {mesh => tools/mesh}/prov-db.h (100%)
 rename {mesh => tools/mesh}/prov.c (98%)
 rename {mesh => tools/mesh}/prov.h (100%)
 rename {mesh => tools/mesh}/prov_db.json (100%)
 rename {mesh => tools/mesh}/util.c (98%)
 rename {mesh => tools/mesh}/util.h (100%)
 rename mesh/main.c => tools/meshctl.c (100%)

-- 
2.14.4

