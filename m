Return-Path: <cyrus@holtmann.org>
Message-ID: <55C3D220.1040803@ubnt.com>
Date: Fri, 07 Aug 2015 00:31:12 +0300
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Notifications and CCC descriptor handling for Gatt server
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

	I have a Gatt server over D-Bus with "notify" characteristic exported and I listen to Start/StopNotify methods. But I can't get my head around the logic of Start/StopNotify methods in case of multiple Gatt clients connecting to the service (not in the same time, of course):
	1. Client A connects and enables notifications, StartNotify is called - this is fine.
	2. Client B connects and enables notifications, then StartNotify is called again - is it expected? Does it mean notifications state is per-client and external Gatt server needs to know the currently connected client and associate some state with it?
	3. Client A connects again and disables notifications, StopNotify is not called. This is strange and goes against the logic in item 2.
	4. Client B connects and disables notifications, StopNotify is called.

	So, how is it supposed to work? Maybe there is a bug somewhere?
	BlueZ 5.32 used.

BR, Andrey
