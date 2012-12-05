Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Dec 2012 16:44:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH v3 00/15] Manager/Adapter transition to ObjectManager
Message-ID: <20121205144422.GA12085@x220>
References: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Dec 05, 2012, Mikel Astiz wrote:
> Main changes from v2 include the suggestions from Lizardo:
> - Python style improved.
> - Utility library renamed to bluezutils.py to avoid collisions in distros.
> - Recently added test-cyclingspeed also considered in the patchset.
> 
> From previous cover-letter:
> 
> This proposal completely removes org.bluez.Manager, with two main consequences:
> 1. Clients have a harder time to find adapters. Therefore, some helper
> function have been added to be used by test scripts.
> 2. The concept of "default adapter" disappears.
> 
> All test scripts have been updated here but not all of them were
> tested, so apoligies if this breaks your script (some of them are
> already broken, by the way).
> 
> Regarding the testing code written in C, they haven't been updated.
> The idea is to address these once the python part has been agreed.
> 
> Mikel Astiz (15):
>   cups: Remove unnecessary code
>   test: Add utility library for python scripts
>   test: Avoid using DefaultAdapter()
>   test: Update monitor script to ObjectManager
>   test: Update test-manager script to ObjectManager
>   test: Use ObjectManager instead of Adapters property
>   dbus: Remove org.bluez.Manager
>   test: Use ObjectManager instead of Devices property
>   test: Add helper function to find devices
>   adapter: Remove DeviceCreated/DeviceRemoved signals
>   adapter: Remove redundant Devices property
>   test: Avoid using Adapter.FindDevice()
>   adapter: Remove FindDevice method from D-Bus API
>   dbus: Rename to org.bluez.Device1
>   dbus: Rename to org.bluez.Adapter1

All patches in this set have been applied. Thanks.

Johan
