Return-Path: <cyrus@holtmann.org>
Message-ID: <48C685F1.9040905@suse.de>
Date: Tue, 09 Sep 2008 16:19:29 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Packaging question
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm packaging bluez-4.4 right now and just wanted to gather opinions about the
package naming (it might be good if distributions could agree on consistent
naming of packages).

So how is everybody going to name the packages? The "old" ones for bluez-3.x
were easy:

- either bluez-libs or libbluetooth2 for the libs
- bluez-utils for the hcid and hciconfig and related stuff
- bluez-audio for the audio stuff (packaged separately because of
  the dependencies
- bluez-cups for the cups backend

>From a first glance, I'd just keep the package-naming as is, but since it is a
major version update anyway, if we want to change it, now might be a good time
 ;-)

Opinions, anyone?

-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
