Return-Path: <cyrus@holtmann.org>
Message-ID: <060701c8cf51$f8730fd0$0132a8c0@Raymondpc>
From: "skyflame" <skyflame@21cn.com>
To: "Sanja Kolundzija" <Sanja.Kolundzija@hermes-softlab.com>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>,
	<attaboyu@163.com>, "hong zhang" <henryzhang62@yahoo.com>
References: <03d101c8cc50$d2aa8660$0132a8c0@Raymondpc>
	<499929A843E2C541A8AD31A881A2B6A201965229@hsl-lj-mail.hermes.si>
Date: Mon, 16 Jun 2008 09:40:33 +0800
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

    Thanks for your instruction !!
    I found it behavior on my board a little different from you :

If  I using -r in the bccmd:

~ # bccmd -t bcsp -d /dev/ttyS1 psload -r csr.psr
Loading PSKEY_ANA_FREQ ... done
Loading PSKEY_UART_BAUDRATE ... done
Loading PSKEY_UART_SEQ_WINSIZE ... done
Loading PSKEY_BDADDR ... done
Loading PSKEY_PCM_CONFIG32 ... done
Loading PSKEY_PCM_FORMAT ... done
Loading PSKEY_HOSTIO_MAP_SCO_PCM ... done
Loading PSKEY_HOSTIO_MAP_SCO_CODEC ... done
Loading PSKEY_CODEC_PIO ... done
Loading PSKEY_ANA_FTRIM ... done
~ #
~ # hciattach -s 921600 /dev/ttyS1 bcsp 921600
BCSP initialization timed out

It won't work,
If I don't do reset at the same cmd, but instead do it seperately:

~ # bccmd -t bcsp -d /dev/ttyS1 psload csr.psr
Loading PSKEY_ANA_FREQ ... done
Loading PSKEY_UART_BAUDRATE ... done
Loading PSKEY_UART_SEQ_WINSIZE ... done
Loading PSKEY_BDADDR ... done
Loading PSKEY_PCM_CONFIG32 ... done
Loading PSKEY_PCM_FORMAT ... done
Loading PSKEY_HOSTIO_MAP_SCO_PCM ... done
Loading PSKEY_HOSTIO_MAP_SCO_CODEC ... done
Loading PSKEY_CODEC_PIO ... done
Loading PSKEY_ANA_FTRIM ... done
~ #
~ # bccmd -t bcsp -d /dev/ttyS1 warmreset
~ #
~ # hciattach -s 921600 /dev/ttyS1 bcsp 921600
~ #
~ # hciconfig hci0 up
~ #

Seems it can connect to the chip, but still, pskey don't set right , I can 
read it out and see it's still the reset value ......

~ # bccmd psget -s 0x0 0x01be
UART Baud rate: 0x0000 (0)

I try to use following cmd to see whether the cmd is write in to the chip, 
but :

~ # bccmd -t bcsp -d /dev/ttyS1 psget -s 0x0 0x1be
UART Baud rate: 0x0000 (0)
~ #
~ # bccmd -t bcsp -d /dev/ttyS1 psset -s 0x0 0x1be 0x0ebf
~ #
~ # bccmd -t bcsp -d /dev/ttyS1 psget -s 0x0 0x1be
UART Baud rate: 0x0000 (0)

seems chip just reset it self between two bccmd with bcsp protocol, and lost 
everything write to it.

But if I set up the pskey use hci protocol after hciconfig up, it's ok. but 
reset lost the connection:

~ # hciattach -s 38400 /dev/ttyS1 bcsp
~ #
~ # hciconfig hci0 up
~ #
~ # bccmd psget -s 0x0 0x1be
UART Baud rate: 0x0000 (0)
~ #
~ # bccmd psset -s 0x0 0x1be 0x01d8
~ #
~ # bccmd psget -s 0x0 0x1be
UART Baud rate: 0x01d8 (472)

~ # bccmd warmreset
~ # ~ # bcsp_recv: Error in BCSP hdr checksum

Sigh ... Do you have any idea what might be wrong for my operation ?

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
