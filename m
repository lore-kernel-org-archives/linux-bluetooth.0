Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH BlueZ 0/1] Fix iop with iOS after BlueZ upgrade
Date: Thu, 19 Jul 2018 16:44:08 +0200
Message-Id: <20180719144409.32563-1-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

A bit more information about included patch which fixes problem we
enocuntered with one of our customers.

There are devices using BlueZ 5.49 which does not persist CCC state of
Service Changed for bonded peers. These devices will be now upgrade to
new sw version which has a bit different GATT database and is based on
more recent BlueZ version with mentioned change.

What happens after upgrade is that each bonded device has its Service
Changed CCC state read as "0" since this information was not persisted
by previous BlueZ version. After connection, database change will not
be indicated to peer and thus peer can use cached database which yields
really weird results. This especially applies to iOS devices as there
is no way to force them to refresh cache other than unbond and bond
again which is a bad user experience.

As per Core spec (wrt Service Changed):
	"This Characteristic Value shall be configured to be indicated,
	 using the Client Characteristic Configuration descriptor by a
	 client."
So I think it is safe to assume that if device is bonded, it also
configured Service Changed CCC for indications - this is what included
patch does. After database change is indicated on 1st connection after
upgrade, iOS will rediscover our database and will write CCC again so
this information is persisted properly.


Andrzej Kaczmarek (1):
  device: Fix loading devices without Service Changed CCC

 src/device.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.18.0

