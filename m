Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 23 Nov 2016 16:40:13 -0500
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Subject: d-bus or management api for beacon stuff
Message-ID: <20161123214013.GZ35881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I was trying to write some code to continuously scan the bluetooth field
for bluetooth devices sending advertising packets (ie beacon-mode).

These devices would come and go so I wanted to avoid the cache.

I noticed the D-Bus interface doesn't quite allow me to do this (as it
caches the devices and I can't monitor the RSSI field).  But I think the
bluetooth management interface does. Is that the correct approach?

Cheers,
Don

