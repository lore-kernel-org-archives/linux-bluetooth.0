Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Understanding BlueZ source code
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041202130115.19341.qmail@web53207.mail.yahoo.com>
References: <20041202130115.19341.qmail@web53207.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1101993005.7350.2.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 02 Dec 2004 14:10:05 +0100

Hi Filipa,

> I need to analyze the Bluetooth code so I could
> identify the most computer intensive functions. As
> BlueZ is a well tested stack I decided to profile it.
>  
> For that, I need the .c files and not only the .o
> files, so I cannot use the patches to include BlueZ in
> the kernel. I decided to use the old bluez-kernel-2.3
> package. I know that it is not the latest version, but
> I think it is the only way for me to access the .c
> files, am I right?

you are kidding me, right?

> Another question is that I only need the bluetooth
> stack and the drivers. That is included on the 
> bluez-kernel package or I also have to use
> bluez-utils and bluez-lib? 

You need the Bluetooth subsystem in the Linux kernel, the HCI drivers,
the Bluetooth library and the tools. However it actually depends on what
part you wanna profile. Bluetooth is not a small piece of software.

> And finally, if someone could give a link to the
> description of the code so I could understand the
> BlueZ stack, that would be great! The best I could
> find was Linux Unwired, but they describe more how to
> install and work with BlueZ, not really how BlueZ is
> done.

Use the source, Luke ;)

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
