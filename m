Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <56233.80.165.155.106.1167300847.squirrel@webmail10.pair.com>
In-Reply-To: <544bb7070612272338m3f130e00p22ee2f1b7f67d3cb@mail.gmail.com>
References: <544bb7070612272338m3f130e00p22ee2f1b7f67d3cb@mail.gmail.com>
Date: Thu, 28 Dec 2006 11:14:07 +0100 (CET)
From: "Osted Software Development" <info@osted.dk>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] bdaddr for CSR chipset - porting dificulties
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


> I'm hoping there's someone on here with experience with the CSR
> chipset.  This doesn't relate to BlueZ exactly, but I'm working from
> BlueZ code so I figure someone here might have a clue what I'm doing
> wrong.
>
> I've been working on porting bluez's bdaddr utility to mac, and I
> think I'm making pretty good progress.  After digging around the
> internals of IOBluetooth.framework, I've managed to, I think,
> replicate the behavior of bdaddr's csr_write_bd_addr and
> csr_reset_device.
>
> The reset appears to be working, however the write address command is
> producing a response packet with a status of 0x0009, not 0x0000 as
> csr_write_bd_addr seems to check for.  here's the low-level HCI
> transaction dump:
>
> HCIc: 00 fc 19 c2 02 00 0c 00 11 47 03 70 00 00 01 00
>       04 00 00 00 cb 00 00 16 1b 00 7e ad
> HCIe:  ff 19 c2 01 00 0c 00 11 47 03 70 09 00 01 00 04
>       00 00 00 cb 00 00 16 1b 00 7e ad
>
> as far as I can tell, the command sent matches exactly what
> csr_write_bd_addr would have sent with transient=false and addr =
> 00-16-cb-1b-7e-ad.  Anyone see what I'm doing wrong?  Or even any clue
> what status 0x0009 is?


Status 0x0009 = PERMISSION_DENIED

I dont think you can change the bd_addr in the CSR chipset
via UART/USB HCI commmands, only via SPI.
Normally you only want to set the bd_addr during production.

-Susanne


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
