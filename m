Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <6ae156900503060610175d3992@mail.gmail.com>
From: Adis Beglerovic <emerge.gentoo@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DBT-120 and Siemens S65
In-Reply-To: <1110117912.8302.14.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <6ae1569005030604105d08a56e@mail.gmail.com>
	 <1110111350.8302.9.camel@pegasus>
	 <6ae1569005030605485547bf58@mail.gmail.com>
	 <1110117308.8302.12.camel@pegasus>
	 <6ae15690050306060128edc405@mail.gmail.com>
	 <1110117912.8302.14.camel@pegasus>
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
Date: Sun, 6 Mar 2005 15:10:34 +0100

Was following this howto http://gentoo-wiki.com/HOWTO_The_host-to-host_Bluetooth
and stuff that was added are as following:Device Drivers  --->
  Networking Support  --->
    <*> Bluetooth subsystem support  --->
        <*> L2CAP protocol support
        <*> SCO links support
        <*> RFCOMM protocol support
            [*] RFCOMM TTY support
        <*> BNEP protocol support
            [*] Multicast filter support
            [*] Protocol filter support
              Bluetooth device drivers  --->
                <*> HCI USB driver
                    [*] SCO (voice) support
USB support  --->
   <*> Support for Host-side USB
   --- USB Host Controller Drivers
   <M> EHCI HCD (USB 2.0) support
   <M> OHCI HCD support
   <*> UHCI HCD (most Intel and VIA) support
   --- USB Device Class drivers
   <*> USB Audio support

Please tell me if this is wrong and.
You are also suggesting modules? Which one as a module ?
Can you point me to a howto that explains it ?

Thanks



On Sun, 06 Mar 2005 15:05:12 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Adis,
> 
> > Just checkign stuff that was in kernel and everything seams OK.
> > I don't use modules everything is build inn!
> > Also when I start bluetooth I get :
> >
> > /etc/init.d/bluetooth start
> >  * Starting Bluetooth...
> >  *     Starting hcid...                                                   [ ok ]
> >  *     Starting sdpd...                                                   [ ok ]
> >  *     Starting rfcomm...
> > Can't open RFCOMM control socket: Address family not supported by protoc  [ !! ]
> 
> make sure everything is compiled in correctly. Otherwise use modules.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
