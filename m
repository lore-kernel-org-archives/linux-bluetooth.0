Return-Path: <cyrus@holtmann.org>
Message-ID: <06df01c8d01a$725bb900$0132a8c0@Raymondpc>
From: "skyflame" <skyflame@21cn.com>
To: "Sanja Kolundzija" <Sanja.Kolundzija@hermes-softlab.com>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>,
	<attaboyu@163.com>, "hong zhang" <henryzhang62@yahoo.com>
References: <03d101c8cc50$d2aa8660$0132a8c0@Raymondpc>
	<499929A843E2C541A8AD31A881A2B6A201965229@hsl-lj-mail.hermes.si>
	<060701c8cf51$f8730fd0$0132a8c0@Raymondpc>
	<499929A843E2C541A8AD31A881A2B6A2019C136C@hsl-lj-mail.hermes.si>
Date: Tue, 17 Jun 2008 09:34:49 +0800
MIME-Version: 1.0
Subject: Re: [Bluez-devel] How to run up CSR chip without eeprom with BLUEZ ?
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



Hi Sanja

> If  I using -r in the bccmd:
>
> ~ # bccmd -t bcsp -d /dev/ttyS1 psload -r csr.psr
> Loading PSKEY_ANA_FREQ ... done
> Loading PSKEY_UART_BAUDRATE ... done
> Loading PSKEY_UART_SEQ_WINSIZE ... done
> Loading PSKEY_BDADDR ... done
> Loading PSKEY_PCM_CONFIG32 ... done
> Loading PSKEY_PCM_FORMAT ... done
> Loading PSKEY_HOSTIO_MAP_SCO_PCM ... done
> Loading PSKEY_HOSTIO_MAP_SCO_CODEC ... done
> Loading PSKEY_CODEC_PIO ... done
> Loading PSKEY_ANA_FTRIM ... done
> ~ #
> ~ # hciattach -s 921600 /dev/ttyS1 bcsp 921600
> BCSP initialization timed out

> Which baud rate do you set in your .psr file? You should use the same
> speed in hciattach command, otherwise chip will be initialized to one
> speed, and hciattach will try to connect using another one.

I did set it to 0xebf for 921600:
this is my psr file , actually I wirte this psr file according to the value 
I used in CSR bchs stack's boot_strap , these setting in bchs's stack can 
make the chip working normally :

// PSKEY_ANA_FREQ
&01fe = 0FA0

// PSKEY_UART_BAUD_RATE
&01be = 0EBF


// PSKEY_UART_SEQ_WINSIZE
&0407 = 0006

// BDADDR
&0001 = 1122 3344 5566 7788

// PCM_CONFIG32
&01b3 = 0080 0906

// PCM_FORMAT
&01b6 = 0060

// MAP_SCO_PCM
&01ab = 0001

// MAP_SCO_CODEC
&01b0 = 0000

// CODEC_PIO
&01b9 = 000b

// ANA_FTRIM
&01f6 = 0025

> I try to use following cmd to see whether the cmd is write in to the
chip,
> but :
>
> ~ # bccmd -t bcsp -d /dev/ttyS1 psget -s 0x0 0x1be
> UART Baud rate: 0x0000 (0)
> ~ #
> ~ # bccmd -t bcsp -d /dev/ttyS1 psset -s 0x0 0x1be 0x0ebf
> ~ #
> ~ # bccmd -t bcsp -d /dev/ttyS1 psget -s 0x0 0x1be
> UART Baud rate: 0x0000 (0)
>
> seems chip just reset it self between two bccmd with bcsp protocol,
and lost
> everything write to it.

> Yes, I had the same behaviour, and only if I use -r with first bccmd
> things worked. Reading the fault code returned FAULT_HOSTIO_INVALID_ACK
> (the chip received a BCSP ACK for a message it has not sent) - based on
> this I conclude that repeating bccmd messes the chips state machine
> during BCHS protocol initialization.

Thanks god, I finally find something that work the same way as you 8 ) 
though this is also not so promising...
I had plan to modify the bccmd to set the pskey and read the pskey at one 
time, to see what make the bccmd not working for second time. Maybe it help 
to understand the stack behavior.

Thanks.

Raymond


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
