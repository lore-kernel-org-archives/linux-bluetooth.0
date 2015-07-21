Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ v1 00/15] Introducing Soletta peripheral node-type
Date: Tue, 21 Jul 2015 20:16:33 -0300
Message-Id: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Sorry for the delay, Soletta is now using kbuild as a build system,
the format of the configuration files changed and a few other changes,
so it was needed some time for the dust to settle.

Changes from the RFC:
 - Added a README;
 - Added a sample Makefile for building an binary implementing the
   behaviour expressed in the .fbp file;


Cheers,

Vinicius Costa Gomes (15):
  build: Add configure-time checks for soletta
  shared: Add a mainloop implementation using soletta
  peripheral/gatt: Fix usage of mainloop_ functions
  peripheral/gatt: Add a way to external services to register services
  peripheral/gap: Fix missing includes
  peripheral/gap: Init the gatt_server
  peripheral: Disable support for static random addresses
  peripheral/gap: Set the discoverable flag in the advertising
  peripheral/gatt: Use LOW security level
  soletta/heartrate: Add a node-type for the Heartrate profile
  .gitignore: Ignore soletta generated files
  build: Add heartrate soletta node type to the build system
  soletta: Add a sample flow using the heartrate node
  peripheral: Add a README for the Soletta support
  peripheral: Add a Makefile for building a binary using soletta

 .gitignore                                |   5 +
 Makefile.am                               |   8 +-
 Makefile.tools                            |  20 ++
 configure.ac                              |  38 ++++
 peripheral/gap.c                          |  12 +-
 peripheral/gatt.c                         | 124 +++++++++---
 peripheral/gatt.h                         |   6 +
 peripheral/soletta/Makefile               |  22 +++
 peripheral/soletta/README                 | 140 +++++++++++++
 peripheral/soletta/heartrate-genspec.json |  31 +++
 peripheral/soletta/heartrate.c            | 270 +++++++++++++++++++++++++
 peripheral/soletta/heartrate.fbp          |   1 +
 peripheral/soletta/sol-flow.json          |   8 +
 src/shared/io-soletta.c                   | 317 ++++++++++++++++++++++++++++++
 src/shared/timeout-soletta.c              | 111 +++++++++++
 15 files changed, 1078 insertions(+), 35 deletions(-)
 create mode 100644 peripheral/soletta/Makefile
 create mode 100644 peripheral/soletta/README
 create mode 100644 peripheral/soletta/heartrate-genspec.json
 create mode 100644 peripheral/soletta/heartrate.c
 create mode 100644 peripheral/soletta/heartrate.fbp
 create mode 100644 peripheral/soletta/sol-flow.json
 create mode 100644 src/shared/io-soletta.c
 create mode 100644 src/shared/timeout-soletta.c

--
2.4.6
