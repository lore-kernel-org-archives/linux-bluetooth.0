Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] first udev rules for running hid2hci
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4900DBD0.3040108@dell.com>
References: <4900DBD0.3040108@dell.com>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 22:58:12 +0200
Message-Id: <1224795492.9386.198.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> Attached is a patch that adds another set of udev rules that will run
> hid2hci, at least for the Dell BT adapters.  Other adapters can get
> added in too, but I think some more attributes will be needed for them. 
> I'm doing this as a separate set of udev rules than the PCMCIA rules so
> that these can be installed by default whereas the PCMCIA ones are
> normally placed in a different binary package for distros.

I like to have this all in one and that the PCMCIA ones are in a
different binary package is a distro problem. They don't have to be
since we don't have the dependency of pcmcia-cs anymore. That is ancient
2.4 stuff.

If you are doing this, then also please modify hid2hci so it can take a
parameter to select the device you run it for. Currently it would switch
all of them. Even if you trigger it for only one.

And I was actually more thinking to convert hid2hci into a bluetoothd
plugin so the core daemon has control over it. Think about it.

Regards

Marcel


