Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org,
	ville.tervo@nokia.com,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Subject: [RFC] Bluetooth: MTU for LE links
Date: Mon, 11 Apr 2011 20:12:37 -0400
Message-Id: <1302567158-18617-1-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <anderson.briglia@openbossa.org>
References: <anderson.briglia@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch is about MTU configuration for LE links. The current implementation
is wrong since the MTU value is not being negotiated.
Comments will be appreciated.

This patch is part of LE/SMP patches available here [1]

Regards,

Anderson Briglia

[1] git://gitorious.org/bluetooth-next/for-upstream.git
