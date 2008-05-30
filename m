Return-Path: <cyrus@holtmann.org>
Message-Id: <88186C47-7987-48D0-969F-6444968D2869@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <8F72DB7755DD6249B3C46D88BE7F5C0B03EEABCD@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 30 May 2008 08:54:39 +0200
References: <8F72DB7755DD6249B3C46D88BE7F5C0B03EEA6D5@bgsmsx411.gar.corp.intel.com>
	<C1EE57B5-6047-4C5D-9DD7-0A1E6651AD83@holtmann.org>
	<8F72DB7755DD6249B3C46D88BE7F5C0B03EEABCD@bgsmsx411.gar.corp.intel.com>
Subject: Re: [Bluez-users] Disable BlueZ profiles
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Kishore,

> Thanks for your reply....
> For IOPT testing SDP and L2CAP modules should be enough.
> My understanding is that for DUN/HFP/FAX the flow in the stack is
> something like the following:
> AT Commands--> RFCOMM-->L2CAP--> low level drivers
>
> And for the FTP and BIP profiles the flow is:
>
> OBEX--> RFCOMM-->L2CAP --> low level drivers
>
> So, in theory if RFCOMM and OBEX modules are removed from the linux
> kernel (Eg rmmod rfcomm), the DUN/HSP/FAX/FTP and BIP profiles  
> should be
> disabled.
>
> Similarly, removing bnep.ko from the kernel should disable PAN  
> profile.
> Is that a correct interpretation??
> Also, How do I use bluez-utils-3.32 to disable certain profiles?

the kernel only implements protocols and not profiles. And loading a  
module that implements a protocol doesn't mean that a profile becomes  
available. Also some protocols like OBEX, SDP and AVDTP are  
implemented in userspace.

The bluez-utils-3.32 has multiple options to handle these cases.  
Normally would not touch any of them and simply go ahead with the  
testing. They don't affect you. However if you do wanna change stuff  
look at the /etc/bluetooth/*.conf files (some of them might not be  
installed by default). So you have main.conf where you can disable  
certain plugins (plugins represent profile collections) and  
audio.conf, network.conf and input.conf. The bluez-utils source code  
contains example config for all plugins.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
