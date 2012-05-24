Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v1 0/3] Prefer PAN over DUN
Date: Thu, 24 May 2012 12:00:15 +0200
Message-Id: <1337853618-7261-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

as discussed on #bluez I have added a configuration switch for
this. 

cheers,
daniel

Daniel Wagner (3):
  main: Add IngoreDUN configuration switch
  serial: Add DUN_GW_UUID
  device: Ignore DUN if PAN is present

 serial/common.h |   24 ++++++++++++++++++++++++
 src/device.c    |   20 ++++++++++++++++++++
 src/hcid.h      |    1 +
 src/main.c      |    9 +++++++++
 src/main.conf   |    5 +++++
 5 files changed, 59 insertions(+)
 create mode 100644 serial/common.h

-- 
1.7.10.130.g36e6c

