Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 BlueZ 0/4] Support for GATT Find Included
Date: Mon, 24 Sep 2012 19:33:35 -0300
Message-Id: <1348526019-28402-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes from v2:
 - Rebased against latest git tree;

Changes from v1:
 - Fixed problems found during PTS tests;

 - Added a reference count for requests that are running in "parallel"
   (if a included service has a 128 bit UUID, it needs to make an
   aditional request to resolve this included service);

--

Jefferson Delfes (1):
  gatttool: Add "included" command

Vinicius Costa Gomes (3):
  gatt: Add support for find included services
  core: Add support for included services
  attrib: Remove opcode parameter from g_attrib_send()

 attrib/client.c                    |   3 +-
 attrib/gatt.c                      | 242 ++++++++++++++++++++++++++++++++-----
 attrib/gatt.h                      |   9 ++
 attrib/gattrib.c                   |   9 +-
 attrib/gattrib.h                   |   6 +-
 attrib/gatttool.c                  |   2 +-
 attrib/interactive.c               |  62 +++++++++-
 profiles/gatt/gas.c                |   2 +-
 profiles/thermometer/thermometer.c |   3 +-
 src/attrib-server.c                |   3 +-
 src/device.c                       | 109 +++++++++++++++--
 11 files changed, 394 insertions(+), 56 deletions(-)

-- 
1.7.12.1

