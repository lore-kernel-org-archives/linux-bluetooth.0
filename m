Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/2] core: Add plugin-support for Manufacturer Specific Data EIR
Date: Mon, 13 Oct 2014 11:43:41 +0000
Message-Id: <1413200623-31278-2-git-send-email-fons@spotify.com>
In-Reply-To: <1413200623-31278-1-git-send-email-fons@spotify.com>
References: <1413200623-31278-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This version adds:

* Corrections suggested by Johan on the handling of eir.h
* Parser sanity check on the size of the MSD payload.
* Minor typo correction on commit message.

Alfonso Acosta (2):
  core: Add Manufacturer Specific Data EIR field
  core: Add subscription API for Manufacturer Specific Data

 src/adapter.c | 36 ++++++++++++++++++++++++++++++++++++
 src/adapter.h | 10 ++++++++++
 src/eir.c     | 11 +++++++++++
 src/eir.h     |  8 ++++++++
 4 files changed, 65 insertions(+)

-- 
1.9.1

