Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/2] core: Add plugin-support for Manufacturer Specific Data EIR
Date: Fri, 10 Oct 2014 15:23:44 +0000
Message-Id: <1412954626-30226-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Athough the Manufacturer Specific Data (MSD) field is not used
internally, it's useful for external plugins, e.g. iBeacon. 

For instance we are dealing with a device which, when losing its LTK
on a reset, notifies the master about the need of rebonding by broadcasting
specific content in the MSD field of ADV_IND reports.

The first patch simply adds the field and parsing support.

The second one adds a subscription mechanism for plugins so that they can
be notified about new Manufacturer Specific Data being received.

Alfonso Acosta (2):
  core: Add Manufacturer Specific Data EIR field
  core: Add subscription API for Manufacturer Specific Data

 plugins/neard.c |  1 -
 src/adapter.c   | 38 +++++++++++++++++++++++++++++++++++++-
 src/adapter.h   | 10 ++++++++++
 src/eir.c       | 11 +++++++++++
 src/eir.h       |  8 ++++++++
 5 files changed, 66 insertions(+), 2 deletions(-)

-- 
1.9.1

