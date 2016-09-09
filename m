Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1473451216.28342.4.camel@deako.com>
Subject: Option to disable filtering of duplicate LE ADV
From: Brennan Ashton <brn@deako.com>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 09 Sep 2016 13:00:16 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Right now in all of the le_scan functions filter_dup is set to
LE_SCAN_FILTER_DUP_ENABLE.  This is not always desired with beacons as
the content may change.  I can force this by sending the HCI commands
to enable scanning without this filter, but then the mgmt api (and
DBUS) cannot be used for scanning.

I was wondering if people had thoughts on making this configurable?

--Brennan
