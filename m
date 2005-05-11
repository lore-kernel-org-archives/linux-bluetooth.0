Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support - Initial library
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05050914312761aa57@mail.gmail.com>
References: <e1effdeb05042813004f4609a6@mail.gmail.com>
	 <1114768038.8836.42.camel@pegasus>
	 <e1effdeb05042905267bc91413@mail.gmail.com>
	 <1114778617.8836.88.camel@pegasus>
	 <e1effdeb0504291520167b9bb8@mail.gmail.com>
	 <1114819470.8836.124.camel@pegasus>
	 <e1effdeb050501141626c62c35@mail.gmail.com>
	 <1114989490.21785.80.camel@pegasus>
	 <e1effdeb05050208322febd0bf@mail.gmail.com>
	 <1115051077.21785.133.camel@pegasus>
	 <e1effdeb05050914312761aa57@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1115836030.23458.80.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 11 May 2005 20:27:10 +0200

Hi Claudio,

> According with our last discussion. I will to add DBUS service
> support in the pand. All code related to DBUS will be added 
> in a new file.
> 
> The dbus service will be enabled using the argument "--dbus".
> However if this argument is provide with other arguments like
> "--connect", "--role" or "--listen" a sharing problem will happen.
> 
> What is the behaviour that you want?
> 1. if "--dbus" was informed no other arguments will be accepted
> 2. support a shared mode, accepting other arguments.

you should do 1). The rest makes no sense, because if you start it with
--dbus you want to control everything via a D-Bus application and pand
acts like a proxy.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
