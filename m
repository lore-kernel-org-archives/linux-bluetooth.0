Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/8] Implement Notification / Indication TS Tests
Date: Tue, 10 Feb 2015 12:16:25 -0800
Message-Id: <1423599385-36295-10-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
References: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements the four defined tests around the Notification and Indication 
functionality in the unit tests.  Also includes some fixes to discovery when
no handles could be found (services with no handles).

Also adds some functionality to the unit testing, to support when there is no
action required by the client and/or the server in a test, and checks for
post data transmission.

