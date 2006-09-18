Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060917202558.GG21347@compendium.com.ar>
References: <20060917202558.GG21347@compendium.com.ar>
Date: Mon, 18 Sep 2006 08:16:41 +0200
Message-Id: <1158560201.30486.15.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluetooth dies when trying to use 2 sco links
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Horacio,

> Attached you'll find the code for a test program that makes a call using
> the hands-free profile connected to a cell phone and when the call is
> answered it generates echo (so the person who answers the phone will
> hear himself)
> 
> Running just one instance of it with just one phone, it works great.
> When I try to run two instances, each connected to a different phone, it
> works for a few seconds and then all the SCO data stops flowing (hcidump
> shows nothing) The bluetooth dongle I'm using has a led indicating it's
> working. That led gets off permanently and the phones display an
> indication saying something like "bluebooth connection lost"
> 
> After that, trying to do an hcitool scan dies with:
> 
> Scanning ...
> Inquiry failed: Connection timed out
> 
> On http://www.compendium.net.ar/2sco.hcidump.bz2 you can find an hcidump
> of the tests.
> 
> The dongle i'm using is:
> 
> Bus 001 Device 004: ID 4851:1103
> 
> horape@nb:~$ hciconfig hci0 version
> hci0:   Type: USB
>         BD Address: 00:0E:A1:00:54:19 ACL MTU: 192:8 SCO MTU: 64:8
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x32e LMP Ver: 1.1 (0x1) LMP Subver: 0x32e
>         Manufacturer: Cambridge Silicon Radio (10)
> horape@nb:~$ hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:0E:A1:00:54:19 ACL MTU: 192:8 SCO MTU: 64:8
>         Build 814
> horape@nb:~$ hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: 00:0E:A1:00:54:19 ACL MTU: 192:8 SCO MTU: 64:8
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>                 <power control> <transparent SCO>
> 
> Kernel is:
> 
> Linux nb 2.6.17 #4 SMP PREEMPT Wed May 10 13:53:45 CEST 2006 i686 GNU/Linux
> 
> Default with KNOPPIX 5.0.1 2006-06-01
> 
> I'm working on a toshiba satellite P105-S6024.
> 
> The phones i'm using are sony ericsson z520a. The code assumes rfcomm channel 3 is
> hands free profile (line 50) and call indicator 10 is callsetup (line 67)
> 
> Is somebody able to help? Is there more info I could provide to help in the search
> for a solution?
> 
> I'm looking forward to have 7 phones connected to a PC, making calls all
> at once almost 24/7. Should I try with 7 dongles, one for each phone?
> Would that work better?

it is an idea to go with 7 phones, because the maximum number of SCO
channels per piconet is 3. There is simply no more bandwidth available.
That said, 2 SCO channels should work, but I assume our USB driver or
maybe the old CSR firmware can't really handle that smoothly.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
