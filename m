Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 27 Nov 2006 11:33:53 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4569FD44.8050906@xmission.com>
Message-ID: <Pine.LNX.4.63.0611271115040.25903@redbean.intranet.gw-instruments.de>
References: <456937F3.7090107@xmission.com>
	<Pine.LNX.4.63.0611261450220.22808@redbean.intranet.gw-instruments.de>
	<4569FD44.8050906@xmission.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] bccmd and usb/uart switching
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


Hi Brad, 

>     2. Change following parameters to switch to HCI mode
>            a. PSKEY_INITIAL_BOOTMODE
>                     i. 0000 = iWRAP
>                    ii. 0001 = HCI, BCSP, 115800,8n1
>                   iii. 0003 = HCI, USB
>                   iv. 0004 = HCI, H4, 115200,8n1
>            b. PSKEY_UART_BAUDRATE                  (Suitable value if H4
> or BCSP used)
>            c. PSKEY_UART_CONFIG_H4
>                PSKEY_UART_CONFIG_BCSP              (Suitable key/value)
>            d. PSKEY_USB_XXXX                       (If USB used,
> configure necessary keys)
> ========================================
 
> did they bump all the bootmodes forward one slot?
Mmmmh, my initial reply was wrong regarding the bootmodes. I did not 
expect that somebody do not use bootmodes in sequence. 

However, from what I can see from the PS-DUMP you sent the bootmodes used 
are 0 2 3 4 (not 0 1 3 4), but 4 is used for Uart / H4 in any case. 
 
> regarding bccmd, all the read options use CSR_STORES_DEFAULT if not
> specified but writing uses CSR_STORES_PSRAM if not specified. I suppose
>  the idea is you can make changes in ram and soft reboot the chip to
> test them before making them permanent.
> 
> It was somewhat confusing that CSR_STORES_DEFAULT (0x0003) is not the
> same meaning of default when you use something like
This is the internal "default" for the bccmd tool. 
 
>  bccmd psset -s default 0x3cd 4
> 
> but rather the command is using 0 for the store. In any case, I think
> "-s default" is what you are suggesting I use.
Right. 

Because you can realy damage your device (if you don't have SPI access) 
Marcel implemented bccmd "save". You realy should know what you're doing 
when using bccmd to change ps-keys on CSR chips.  

> I don't know what belongs in PSKEY_UART_CONFIG_H4 (all I know is it's 16
> bits in key 0x1c0)
The default setting (8N1 / RTS/CTS handshake) should be fine for most 
applications. If you need something different let me know. I may break 
some NDA when posting the full description here .......

Ciao, 

Peter 

|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
