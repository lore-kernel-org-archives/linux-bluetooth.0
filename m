Return-Path: <skronenberger@web.de>
Date: Fri, 13 Aug 2004 21:27:42 +0200
From: Sigrid Kronenberger <skronenberger@web.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] AVM BlueFritz with Linux Kernel 2.6.3-15mdk
Message-Id: <20040813212742.404662f2@localhost>
In-Reply-To: <1092424207.4501.27.camel@pegasus>
References: <20040811231204.18574a27@localhost>
	<1092262417.4564.259.camel@pegasus>
	<20040812194818.7d3d1ce6@localhost>
	<1092334021.28711.169.camel@pegasus>
	<20040812203428.0bd25290@localhost>
	<1092336801.28711.172.camel@pegasus>
	<20040813210346.6c40aed3@localhost>
	<1092424207.4501.27.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: skronenberger@web.de
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, 13 Aug 2004 21:10:07 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

Hi Marcel, 

> 
> > Now, I have updated to 2.6.8-0.rc2.2mdk (sorry, but I'm not used in
> > compiling my own kernel, so I prefer rpm-packages, is easier... ;))
> 
> this depends on if we get this working without any trouble. Otherwise
> you must compile a vanilla kernel, because I don't know what patches
> they included.

OK, I'll try it. If it's not working I'm going to download the vanilla
kernel. 

> 
> But the firmware request still fails. Where do you put your
> bfubase.frm file? Is hotplug installed and do you have a
> firmware.agent script under/etc/hotplug.

I've copied the bfubase.frm file to /usr/lib/hotplug/firmware 
And, yes, I have the firmware.agent scrip under /etc/hotplug.

> 
> > Should I change the firmware again? Do you know which version of the
> > AVM-firmware have problems with the kernel? The first version I've
> > tested, was 3-18-39, after that, I've changed to 3-17-53. 
> 
> Use the older one, because I don't know if this kernel includes my
> workaround.

The firmware request fails with the old and the new file. It makes no
difference. :(

 
Regards

Sigrid
