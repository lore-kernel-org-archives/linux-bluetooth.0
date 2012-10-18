Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [RFC 0/6] DBus.Properties: Converting SAP, HEALTH and fix to input
Date: Thu, 18 Oct 2012 19:03:45 -0300
Message-Id: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Here is a patch set to convert SAP and HEALTH profiles to DBus.Properties. It's
only compile-tested.

Patch 0002 contains a fix to sap server. Unless I'm blind, GetProperties()
callback was doing random things using that pointer.

Patch 0001 adds the missing update to PropertiesChanged signal in INPUT profile.

Finally last patch convert HEALTH's documentation to a format similar to what
we have in other profiles.

Lucas De Marchi (6):
  input: Fix not sending PropertiesChanged signal
  sap: Fix usage of wrong struct in get_properties()
  sap: Convert to DBus.Properties
  health: Convert HealthChannel to DBus.Properties
  health: Convert HealthDevice to DBus.Properties
  doc: Update Health to BlueZ 5

 doc/health-api.txt      | 198 ++++++++++++++++++++++++------------------------
 doc/sap-api.txt         |  12 ---
 profiles/health/hdp.c   | 124 +++++++++++++++---------------
 profiles/input/device.c |  13 +---
 profiles/sap/server.c   |  61 +++++----------
 5 files changed, 184 insertions(+), 224 deletions(-)

-- 
1.7.12.3

