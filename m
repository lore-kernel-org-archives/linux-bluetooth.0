Return-Path: <cyrus@holtmann.org>
From: Andrew Bourhill <andrew.bourhill@eagleeye.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: BCM20702A0 tx timeouts
Date: Mon, 21 Jul 2014 07:51:50 +0000
Message-ID: <1405929105913.56566@eagleeye.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


BCM20702A0 seems very unstable, bringing up the interface with hciconfig hci0 up can result in timeouts .

occasional ACL packet errors etc.

once interface is up, after a succesfull xfer, restarting a LE advert can also result in timeouts, device also sometimes misses events.
