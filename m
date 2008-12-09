Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth node manager causes up to ~3.25s delay in
 freezing tasks.
From: Marcel Holtmann <marcel@holtmann.org>
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-bluetooth@vger.kernel.org,
	linux-pm <linux-pm@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1228809311.6681.12.camel@nigel-laptop>
References: <1228809311.6681.12.camel@nigel-laptop>
Content-Type: text/plain
Date: Tue, 09 Dec 2008 12:24:03 +0100
Message-Id: <1228821843.19553.3.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nigel,

> The bluetooth nodemanager function "nodemgr_host_thread" contains a loop
> that calls try_to_freeze near the top of the loop, but then delays for
> up to 3.25 seconds (plus time to do work) before getting back to the top
> of the loop. When starting a cycle post-boot, this doesn't seem to bite,
> but it is causing a noticeable delay at boot time, when freezing
> processes prior to starting to read the image.

I don't wanna disappoint you, but IEEE1394 is actually Firewire and not
Bluetooth :)

Regards

Marcel


