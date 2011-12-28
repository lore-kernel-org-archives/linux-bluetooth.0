Return-Path: <cyrus@holtmann.org>
From: yegorslists@googlemail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: Fix out-of-source build breakage
Date: Wed, 28 Dec 2011 10:53:35 +0100
Message-Id: <1325066017-2384-1-git-send-email-yegorslists@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

These patches fix out-of-source build breakage. The first one fixes
link creation and the second one adds tools to includ folder list.

The patches were tested for both in-source and out-of-source scenarios.

Following patch was included in this patch set and can be ignored:
[PATCH] fix lib header linking for out-of-source build

Yegor
