Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BlueZ error in cc,cc,dc sequence
References: <200404162339.01392.cijoml@volny.cz> <1082159344.4489.1.camel@pegasus>
In-Reply-To: <1082159344.4489.1.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404170937.46434.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 17 Apr 2004 09:37:46 +0200

There is another problem which I in mistake found.

I tried connect to my mobile phone via cc
then I moved console, remembered it and called cc second time.
It told me, that connection is created - which is right.
Then I wanted disconnect later, but I got message that there isn't any 
connection, which is bad, coz devices are connected.

when calling cc/dc/cc/dc/cc/dc it works like a charm
but cc/cc/dc makes problems - can't disconnect

Michal

Dne so 17. dubna 2004 01:49 jste napsal(a):
> Hi Michal,
>
> > notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
> > notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
> > Can't create connection: Input/output error
>
> you can't have to ACL links to the same remote device.
>
> > notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
> > Can't create connection: Input/output error
> > notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
> > Can't create connection: Input/output error
> > notas:/etc/hotplug# hcitool dc 00:0A:D9:FC:EC:51
> > Not connected.
> > notas:/etc/hotplug# hcitool dc 00:0A:D9:FC:EC:51
> > Not connected.
> > notas:/etc/hotplug# hcitool cc 00:0A:D9:FC:EC:51
> > Can't create connection: Input/output error
> > notas:/etc/hotplug# hcitool dc 00:0A:D9:FC:EC:51
> > Not connected.
> >
> > But device is connected
>
> Check with "hcitool con" every time, because this is what the kernel
> sees and "hcitool dc" only sends the raw HCI_Disconnect command.
>
> Regards
>
> Marcel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
