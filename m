Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't read local name on hci0. Connection timed
	out(110)
From: Marcel Holtmann <marcel@holtmann.org>
To: filipe_abrantes <filipe_abrantes@netcabo.pt>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <5CD2BD8F1F23A943BAEBE96AB20C24980549DD5C@VS1.hdi.tvcabo>
References: <5CD2BD8F1F23A943BAEBE96AB20C24980549DD5C@VS1.hdi.tvcabo>
Content-Type: text/plain
Message-Id: <1080854213.2774.18.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 01 Apr 2004 23:16:53 +0200

Hi Filipe,

> i'm sorry to be posting this again, ive posting this around but havent got any feedback yet, and as im kind of desperate with this, i would really appreciate your help even if it is to say that it isn't possible...
> 
> so:
> 
> #modprobe hci_uart
> #hciattach /dev/tts/1 any 921600
> 
> # hciconfig -a
> hci0:   Type: UART
>         BD Address: 08:00:17:1F:C5:E4 ACL MTU: 339:4  SCO MTU: 60:9
>         UP RUNNING PSCAN ISCAN AUTH
>         RX bytes:98 acl:0 sco:0 events:10 errors:0
>         TX bytes:315 acl:0 sco:0 commands:14 errors:0
>         Features: 0xff 0x3b 0x05 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
> Can't read local name on hci0. Connection timed out(110)
> 
> 
> also hcitool scan gives timeout as well as pand connections so i cant bring up the bnep interface...
> 
> im using an ipaq h5500, using kernel 2.4.19-rmk6-pxa1-hh30 
> 
> anyone has a clue of what could be wrong ??

the folks from HP don't uses CSR chips anymore and I think that this can
be the problem. I don't own a iPAQ of the 5000 generation, so you should
ask the Handheld guys if they got any improvements. For me this looks
like an UART problem on the iPAQ side.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
