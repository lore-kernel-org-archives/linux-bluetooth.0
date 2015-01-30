Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [RFC BlueZ v2 0/1] Introduce LE Advertising API
Date: Fri, 30 Jan 2015 11:53:01 -0800
Message-Id: <1422647582-12829-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm soliciting RFCs for this approach to defining the LE Advertising Data for
broadcast.  This has a number of advantages over the previous method including
flexibility, ability for multiple advertisements, specifying the advertising
type, and the address to be used for advertisement.

Using the comments on the last RFC for LE Advertising, I've incorporated it
into the ServiceManager API next to the custom service registration, and removed
the advertising data types which are not used in practice.

Michael Janssen (1):
  doc: Add LE Advertisements to Service Manager

 doc/gatt-api.txt | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 4 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

