Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [RFC BlueZ v3 0/1] Introduce LE Advertising Data API
Date: Tue, 17 Feb 2015 14:36:58 -0800
Message-Id: <1424212619-10062-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This third apparoach to LE Advertisements, splits the API into a separate
manager which will be easier to implement and maintain separately.  This
approach focuses on being able to add objects representing data to a specific
controller specifying just the properties which are meant to be in the Data.

This update incorporates the feedback from the last two proposed APIs.  I've
switched the address from being in the path to be a simple flag for whether the
random address should be used in the packet, and being more specific about
what will happen when something goes wrong.

Michael Janssen (1):
  doc: Add LE Advertisement Manager

 doc/advertising-api.txt | 113 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 doc/advertising-api.txt

-- 
2.2.0.rc0.207.ga3a616c

