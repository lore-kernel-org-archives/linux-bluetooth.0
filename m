Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [RFC BlueZ v2 00/13] Add experimental org.bluez.Service1
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1371020815-22330-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Sun, 16 Jun 2013 13:50:51 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Message-Id: <83E493B1-AE4F-4EE1-8111-4CD2AA71B9AD@holtmann.org>
References: <1371020815-22330-1-git-send-email-mikel.astiz.oss@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

> Beyond the desktop use-cases, some users (e.g. GENIVI) are interested in having profile-specific information and control interfaces exposed in D-Bus. Such APIs did exist in BlueZ 4 but were dropped for BlueZ 5 in favor of simpler API simplicity. This service-specific interfaces had a fairly low priority for BlueZ 5 and therefore the discussion was postponed.
> 
> This patchset proposes org.bluez.Service1 as an attempt to cover these needs. As compared to the former Device.ConnectProfile()/DisconnectProfile(), the approach has the following advantages:
> - Multiple instances of the same UUID can be exposed.

how is this going to help anyone. I you do not know what your service object is, what are you planning to do with it.

> - The state of each service can be exposed, without hackish lists like Device.ConnectedProfiles.

Again, here I want to see clear example on why you want all these states. Everybody takes about wanting all the crazy interim states and then never ever uses any of them.

> - It's ObjectManager-centric.
> - The design should scale better if new properties are required in the future (supported features, service handle, etc.)

I don't think this actually will scale that nicely. There are limited set of common properties for all these profiles. I am really curious to see how this is going to be used and how it would improve things for applications.

My initial take is still that just calling a general Device1.Connect or requesting a connect to a UUID is useful. Everything else is pretty much application specific anyway.

You can always add profile specific interfaces. Like we do with Network1. Why are you saying your approach is more object manager centric.

Regards

Marcel

