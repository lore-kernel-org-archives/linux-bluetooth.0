Return-Path: <ohadbc@gmail.com>
Message-ID: <4f436aae0701181523y55ad36bdu9645c786a252c04e@mail.gmail.com>
Date: Fri, 19 Jan 2007 01:23:13 +0200
From: "Choi Sonim" <choisonim@gmail.com>
Sender: ohadbc@gmail.com
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
        marcel@holtmann.org
Subject: Re: [Bluez-devel] /sys/devices/platform/bluetooth
In-Reply-To: <1169108019.6853.1.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4f436aae0701172208l7ac85a75tc592fa15d1b57f8@mail.gmail.com>
	 <1169108019.6853.1.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Hi,

On 1/18/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
>
> > Where is the code that does the platform registration to this device :
> > /sys/devices/platform/bluetooth
>
> you find it in net/bluetooth/hci_sysfs.c in the kernel source code.

What is the purpose of the bluetooth platform device (and bus and class..) ?

I guess that bluetooth devices would prefer to register themselves as children
of their true bus (like USB or PCI or even serial) so when the system goes
to suspend, their suspend function will be called before their father's
(the true hardware bus of our bluetooth device).

Am I right ?

thanks you,
choi.

>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
