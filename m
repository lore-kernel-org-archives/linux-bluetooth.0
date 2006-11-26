Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4569FD44.8050906@xmission.com>
Date: Sun, 26 Nov 2006 13:47:00 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <456937F3.7090107@xmission.com>
	<Pine.LNX.4.63.0611261450220.22808@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.63.0611261450220.22808@redbean.intranet.gw-instruments.de>
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

Peter

> Be carefull with this module when you want to change configuration !!! 
> 
> They use different "bootmodes" (boot configurations) to switch between 
> different operation modes. If you change anything this will only be 
> changed for the mode you are currently in. 
> 
> According to what I can see from your PS dump the default bootmode (3) 
> configures the module for UART/H4. However, when the module is currently 
> in USB mode either the default bootmode isn't 3 or it must have been 
> rebootet from the VM (wich again is strange because bootmode 3 disables 
> the VM). 

Maybe it's because the bluegiga has their own firmware as a boot option
(this is a bc4-ext). I found the text below in a recent rev of their
data sheet.

========================================
10.3 Switching to HCI firmware
New WRAP THOR firmware builds are called unified firmware (firmware
versions 18.2 and
later). This means the firmware contains both iWRAP firmware and RFCOMM
and HCI
stacks. The selection which part is active is done with PS-keys and
there is no need to
reflash the actual firmware as with older versions of iWRAP.
Switching can be done easily using PSTool software.
    1. Connect the WRAP THOR module as instructed in chapter 8.1.
    2. Change following parameters to switch to HCI mode
           a. PSKEY_INITIAL_BOOTMODE
                    i. 0000 = iWRAP
                   ii. 0001 = HCI, BCSP, 115800,8n1
                  iii. 0003 = HCI, USB
                  iv. 0004 = HCI, H4, 115200,8n1
           b. PSKEY_UART_BAUDRATE                  (Suitable value if H4
or BCSP used)
           c. PSKEY_UART_CONFIG_H4
               PSKEY_UART_CONFIG_BCSP              (Suitable key/value)
           d. PSKEY_USB_XXXX                       (If USB used,
configure necessary keys)
========================================

> If you realy want to play with this module only change the bootmode 
> (0x3CD) to 3. This will set up anything to boot for UARt / H4. And to make 
> the change permanent you need to use the default store (see source for 
> bccmd, I never can remember the command options). 

did they bump all the bootmodes forward one slot?

regarding bccmd, all the read options use CSR_STORES_DEFAULT if not
specified but writing uses CSR_STORES_PSRAM if not specified. I suppose
 the idea is you can make changes in ram and soft reboot the chip to
test them before making them permanent.

It was somewhat confusing that CSR_STORES_DEFAULT (0x0003) is not the
same meaning of default when you use something like

 bccmd psset -s default 0x3cd 4

but rather the command is using 0 for the store. In any case, I think
"-s default" is what you are suggesting I use.

I don't know what belongs in PSKEY_UART_CONFIG_H4 (all I know is it's 16
bits in key 0x1c0)

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
