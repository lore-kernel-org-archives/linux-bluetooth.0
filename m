Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4749FAD6.6080403@uni-koeln.de>
Date: Sun, 25 Nov 2007 23:44:38 +0100
From: Paul Wachendorf <pwachend@uni-koeln.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4745D9EE.4020101@uni-koeln.de>
In-Reply-To: <4745D9EE.4020101@uni-koeln.de>
Subject: Re: [Bluez-users] hcitool scan returns wrong bdaddr
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

Hi everyone,
after a lot of testing, I found a (really ugly) workaround for my 
problem, so I post it here, if someone gets the same wired problem someday:
The verbose mode of hcidump show the right Mac while a 'hcitool scan' on 
an other console:

# hcidump -V
HCI sniffer - Bluetooth packet analyzer ver 1.39
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
 > HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:12:EE:58:72:1C mode 1 clkoffset 0x5c3f class 0x5a0204
 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 02:01:00:12:EE:58 mode 0 clkoffset 0x0000 (valid)
 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x04 bdaddr 02:01:00:12:EE:58 name ''

    Error: Page Timeout

the name request fails of course with a annoying timeout.  So I make the 
scan with python and without name checking (of course you can use 
hcitool inq too):

import bluetooth
bluetooth.discover_devices(lookup_names = False)

# hcidump -V
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 250
 > HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:12:EE:58:72:1C mode 1 clkoffset 0x5c44 class 0x5a0204
 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00

then I parse the output of hcidump, and get my Macs.

So on I noticed that a part of the "wrong" MACs are like the original ones:

          00:12:EE:58:72:1C            right one in output of hcidump 
02:01:00:12:EE:58                      wrong one returned by 
python-bluez or hcitool scan/inq

          00:10:C6:81:48:19
02:02:00:10:C6:81

If someone understand the problem here, please give me a hint and help 
my to get rid of hcidump parsing.
Thanks,

Paul


Paul Wachendorf schrieb:
> Hi,
> I have a strange Problem with hcitool on a ARM CPU based embedded 
> system.  I have installed a debian system (tried woody, etch and lenny) 
> and tried the bluez-utils from the distribution and self compiled ones. 
> The bluetooth device works fine, but when I run a 'hcitool scan' to 
> discover the bdaddr of remote devices  it always returns wrong MACs:
> # hcitool scan
> Scanning ...
>         02:01:00:12:EE:58       n/a
>         02:02:00:10:C6:81       n/a
>
> on my normal i386 PC running ubuntu linux, using the same bluetooth 
> device the output is:
> $ hcitool scan
> Scanning ...
>         00:10:C6:81:48:19       NAME-FB399BACD9
>         00:12:EE:58:72:1C       V630i
>
> back again on the ARM box I can successfully l2ping  00:12:EE:58:72:1C 
> and an # hcitool name 00:12:EE:58:72:1C
> returns "V630i" as suspected , so on I can use ussp-push to send Files 
> to my V630i. So the whole bluetooth subsystem seems to work fine, except 
> of the discovering of remote MACs.
>
> Does anybody has am idea why this wrong MACs are returned?
> Thanks for your help,
>
> Paul
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
