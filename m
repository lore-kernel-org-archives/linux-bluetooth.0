Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 0/2] core: Add plugin-support for Manufacturer Specific Data EIR
Date: Tue, 14 Oct 2014 12:46:03 +0000
Message-Id: <1413290765-20398-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v4:

* Support for multiple MSD fields in the same EIR data block.
* Moved parsing to a separate function: eir_parse_msd()

v3:

* Corrections suggested by Johan on the handling of eir.h
* Parser sanity check on the size of the MSD payload.
* Minor typo correction on commit message.


Alfonso Acosta (2):
  core: Add Manufacturer Specific Data EIR field
  core: Add subscription API for Manufacturer Specific Data

 src/adapter.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h | 10 ++++++++++
 src/eir.c     | 22 ++++++++++++++++++++++
 src/eir.h     |  8 ++++++++
 4 files changed, 84 insertions(+)

-- 
1.9.1

