Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 00/18] neard plugin
Date: Fri, 21 Sep 2012 14:36:17 +0200
Message-ID: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes since previous version:
- handle empty randomizer in mgmt_add_remote_oob_data as suggested by Johan
- rebased against latest changes related to D-Bus connection
- remove not needed static pending call pointer

Szymon Janc (18):
  Add initial neard plugin implementation
  eir: Add support for parsing SSP hash and randomizer
  eir: Store class in struct eir_data as uint32_t
  eir: Add eir_parse_oob function
  oob: Allow to register pairing complete callback
  Handle missing randomizer in mgmt_add_remote_oob_data
  neard: Implement PushOOB function
  eir: Add support creating EIR with hash and randomizer fields
  eir: Add support for creating EIR with CoD field
  eir: Rename eir_create to eir_create_oob
  eir: Remove support for creating EIR with tx_power fields
  eir: Return number of bytes written by eir_create_oob
  eir: Remove struct uuid_info
  eir: Add support for creating proper OOB EIR
  adapter: Add btd_adapter_get_services function
  adapter: Rename btd_adapter_get_class to btd_adapter_read_class
  adapter: Add btd_adapter_get_class function
  neard: Implement RequestOOB function

 Makefile.am         |   11 +-
 acinclude.m4        |   19 +-
 bootstrap-configure |    3 +-
 plugins/dbusoob.c   |   14 +-
 plugins/neard.c     |  527 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.c       |   23 ++-
 src/adapter.h       |    5 +-
 src/eir.c           |  155 ++++++++++++---
 src/eir.h           |   21 +-
 src/event.c         |   11 +-
 src/event.h         |    2 +-
 src/mgmt.c          |    9 +-
 src/oob.c           |   22 ++-
 src/oob.h           |   15 +-
 14 files changed, 750 insertions(+), 87 deletions(-)
 create mode 100644 plugins/neard.c

-- 
1.7.9.5

