Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/10 v2] Bluetooth: Fix more mgmt parameter checks
Date: Sun, 20 Jan 2013 14:27:12 +0200
Message-Id: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's an updated patch set based on feedback from Marcel for the first
one.

This one still needs my patch (acked by Marcel)

"Bluetooth: Fix Class of Device indication when powering off"

and Szymons patch (acked by me)

"Bluetooth: Fix pair device command reply if adapter is powered off"

to be applied first to bluetooth-next.git. At least I've got those two
in my local tree before this set, so no guarantees that there wont be
conflicts if they are not applied first.

Johan

