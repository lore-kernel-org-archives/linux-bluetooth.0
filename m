Return-Path: <cyrus@holtmann.org>
Message-ID: <078501c8d02f$587b1200$0132a8c0@Raymondpc>
From: "skyflame" <skyflame@21cn.com>
To: "Sanja Kolundzija" <Sanja.Kolundzija@hermes-softlab.com>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>,
	<attaboyu@163.com>, "hong zhang" <henryzhang62@yahoo.com>
References: <03d101c8cc50$d2aa8660$0132a8c0@Raymondpc>
	<499929A843E2C541A8AD31A881A2B6A201965229@hsl-lj-mail.hermes.si>
	<060701c8cf51$f8730fd0$0132a8c0@Raymondpc>
	<499929A843E2C541A8AD31A881A2B6A2019C136C@hsl-lj-mail.hermes.si>
Date: Tue, 17 Jun 2008 12:05:12 +0800
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

Hi  sanja, attaboyu, henry

        Thanks for your help, I can do the hcitool scan now!

    It's my bad, I set the ANA_FREQ in worng way,
    At first I try bccmd -t bcsp way to set the ana_freq, And find it not 
work,
    and I use   bccmd -t bcsp -d /dev/ttyS1 psget -s 0x0 0x1fe to read the 
value
    but it says
    Can't execute command: No such device or address (6)

    So I remove it.

    And when I do the following test again , I add it back,  But ... shame , 
My chip is using 40M crystal , When I calculate the value I put 4000 in calc 
to get 0xfa0 , But it should be 40000 and thus 0x9c40

    I check my csr.psr and correct it just now it  works now.

    And I understand now, why bccmd -t bcsp -d /dev/ttyS1 psget -s 0x0 0x1fe 
got nothing at the biginning. This pskey unlike the other pskey say 0x1be , 
they have a "psrom" version value, so before you set it, you can read it out 
from "psrom" ( which can be done by -s 0x0 say "default" ) , and after you 
setting them , you can also read it out from "psram" , this pskey do not 
have default value in "psrom" ( strange ? ) and only after you successfully 
setting it , it can be read out.

    (  However, It is really strange here, without setting this value, why 
hciattach can connect the chip for the first time, while do a warmreset , it 
won't ? Is csr's chip do a self uart baudrate adjustment to match the host 
for the first time ? )

    Thanks for all of you's help on this issue!

    So My process now is :

    boot up the fs

    insmod bluetooth.ko
    insmod hci_uart.ko
    insmod l2cap.ko
    insmod rfcomm.ko

    bccmd -t bcsp -d /dev/ttyS1  psload -r csr.psr

    hciattach -s 921600 /dev/ttyS1 bcsp 921600
    hciconfig hci0 up
    hciconfig hci0 piscan
    hcitool -i hci0 scan

Thanks again

Hope I do not get further problems with those bluez daemons 8  )

Raymond


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

Which baud rate do you set in your .psr file? You should use the same
speed in hciattach command, otherwise chip will be initialized to one
speed, and hciattach will try to connect using another one.


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

Yes, I had the same behaviour, and only if I use -r with first bccmd
things worked. Reading the fault code returned FAULT_HOSTIO_INVALID_ACK
(the chip received a BCSP ACK for a message it has not sent) - based on
this I conclude that repeating bccmd messes the chips state machine
during BCHS protocol initialization.

Regards,
Sanja




-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
