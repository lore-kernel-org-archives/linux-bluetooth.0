Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201336771.22866.7.camel@littletux>
References: <1201336771.22866.7.camel@littletux>
Date: Sat, 26 Jan 2008 10:01:29 +0100
Message-Id: <1201338089.22866.14.camel@littletux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HT820, capture and  eSCO
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


On sam, 2008-01-26 at 09:39 +0100, Guillaume Bedot wrote:
> Hello,
> 
> I have issues using "voice"/HSP/HFP profiles with this headset and
> latest kernels/bluez cvs.
> 
> It seems it tries to use extended SCO when it shouldn't...
> 
> hcitool info xx:xx:xx:xx:xx:xx
> Requesting information ...
> 	BD Address:  xx:xx:xx:xx:xx:xx
> 	Device Name: Motorola HT820
> 	LMP Version: 2.0 (0x3) LMP Subversion: 0xa41
> 	Manufacturer: Cambridge Silicon Radio (10)
> 	Features: 0xff 0xff 0x8b 0x78 0x18 0x18 0x00 0x80
> 		<3-slot packets> <5-slot packets> <encryption> <slot offset> 
> 		<timing accuracy> <role switch> <hold mode> <sniff mode> 
> 		<park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
> 		<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme> 
> 		<transparent SCO> <broadcast encrypt> <enhanced iscan> 
> 		<interlaced iscan> <interlaced pscan> <inquiry with RSSI> 
> 		<AFH cap. slave> <AFH class. slave> <AFH cap. master> 
> 		<AFH class. master> <extended features> 

If it can help, I noticed there are a lot of these messages in syslog :

Jan 26 07:52:05 littletux kernel: hci_scodata_packet: hci0 SCO packet
for unknown connection handle 1

And with "hifi" profile, the headset playback works although it seems to
use eSCO too :

hcitool con
Connections:
	> ACL xx:xx:xx:xx:xx:xx handle 11 state 1 lm SLAVE AUTH ENCRYPT SECURE 
	< eSCO xx:xx:xx:xx:xx:xx handle 0 state 8 lm SLAVE 

I'm not sure what the problem is anymore...

Best regards,

Guillaume B.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
