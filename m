Return-Path: <cyrus@holtmann.org>
Message-ID: <4A816300.7050906@gmail.com>
Date: Tue, 11 Aug 2009 14:24:32 +0200
From: Till Kamppeter <till.kamppeter@gmail.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: linux-bluetooth@vger.kernel.org, Tim Waugh <twaugh@redhat.com>
Subject: Re: PATCHES: Device discovery of the "bluetooth" CUPS backend does
 not work
References: <4A8080DC.2010204@gmail.com>	 <1249986829.2022.17.camel@localhost.localdomain>	 <4A8153D9.4020008@gmail.com> <1249990438.2022.23.camel@localhost.localdomain>
In-Reply-To: <1249990438.2022.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> You're modifying a file in the Ubuntu package (it's in the debian/
> sub-directory), not the one from bluez (src/bluetooth.conf in the
> sources).
>

For the Ubuntu packaging I did the change in the Ubuntu-provided version 
of the file as the Ubuntu (Debian?) package maintainer did other changes 
there. Putting my change in the original file then would have resulted 
in them being overwritten. In the upstream fix I naturally expect the 
change to be applied to src/bluetooth.conf.

>> A Bluetooth printer has to get paired with a computer before the 
>> Bluetooth CUPS backend can find it.
> 
> I know that, seeing as I wrote the discovery code in the bluetooth
> backend :)
>

OK, I mentioned that only to tell why the Bluetooth printers should be 
considered local.

>>  This makes it getting assigned to 
>> one single computer, whereas a network printer (Ethernet or WLAN) gets 
>> discovered by all computers in the network and all computers can have a 
>> working queue accessing to the same network printer. Therefore a 
>> Bluetooth printer has more the characteristics of a local printer.
> 
> Seems fair.
> 

OK.

> 
> You're right, read the patch in reverse...
>

OK.

>>> In the future, please attach the patches to your mail, and make sure
>>> they apply to the upstream sources.
>> Sorry, was my first patch submission to this project.
> 
> Could you rebase your fixes into patches ready for inclusion in the git
> tree? If you don't know git, I'll make those changes myself.
> 

Could you put them in? Then I do not need to download the git only to 
format two simple one-point-only-changed patches. Thanks.

>> Do you have a bug/feature request tracking system?
> 
> There isn't one.

As vluez seems to be a part of the kernel project, does the kernel even 
not have a bug tracking system?

    Till
