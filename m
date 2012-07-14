Return-Path: <cyrus@holtmann.org>
Date: Sat, 14 Jul 2012 17:54:34 +0200
From: folkert <folkert@vanheusden.com>
To: linux-bluetooth@vger.kernel.org
Subject: tcp/ip over bt
Message-ID: <20120714155433.GF17345@belle.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Am trying to setup my pc as a bluetooth enabled internet sharer.
Followed the howto, loaded the module and invoked:
	pand --listen --role NAP
tried
	pand --listen --role GN
as well (did not forget to stop the first process).
The funny thing now is, that no network device appears (checked in
/proc/net/dev ) so it does not work.
Kernel is 3.4.0
bluez tooling:
ii  bluez                                 4.99-2 Bluetooth tools and daemons
ii  bluez-alsa:amd64                      4.99-2 Bluetooth ALSA support
ii  bluez-compat                          4.99-2 BlueZ 3.x compatibility binaries
ii  bluez-cups                            4.99-2 Bluetooth printer driver for CUPS
ii  bluez-gstreamer                       4.99-2 Bluetooth GStreamer support
ii  bluez-utils                           4.99-2 Transitional package

Any ideas?


Folkert van Heusden

-- 
To MultiTail einai ena polymorfiko ergaleio gia ta logfiles kai tin
eksodo twn entolwn. Prosferei: filtrarisma, xrwmatismo, sygxwneysi,
diaforetikes provoles. http://www.vanheusden.com/multitail/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
