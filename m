Return-Path: <dv_mlist@verizon.net>
Subject: Re: [Bluez-users] Config for Socket CF card
From: digger vermont <dv_mlist@verizon.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1074597777.7088.2.camel@pegasus>
References: <1074566227.3670.24.camel@myrna>
	 <1074597777.7088.2.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074697933.3020.19.camel@myrna>
Mime-Version: 1.0
Date: Wed, 21 Jan 2004 10:12:13 -0500
List-ID: <bluez-users.lists.sourceforge.net>

Hello Marcel,

On Tue, 2004-01-20 at 06:22, Marcel Holtmann wrote: 
> Hi Digger,
... 
> > Here's the card I have:
> > 
> > --
> > product info: "Socket", "CF+ Personal Network Card Rev 2.5"
> >   manfid: 0x0104, 0x0096
> >   function: 2 (serial)
> > --
> > 
> > I believe that means I have the infamous revision G.
> 
> this is correct ;)
> 
> > My laptop is a powerbook G4.  The kernel is 2.6.1-ben1 using devfs.
... 
> > 
> > --
> > device "hci_uart"
> >   class "bluetooth" module "hci_uart"
> >  
> > card "Socket Bluetooth Card"
> >   version "Socket", "CF+ Personal Network Card Rev 2.5"
> >   manfid 0x0104, 0x0096
> >   bind "hci_uart"
> > 
> > include port 0x100-0x4ff, port 0x800-0x8ff, port 0xc00-0xcff
> > include memory 0x80080000-0x8008ffff
> > --
> > 
> > When I insert the card this is what I get in the log:
> 
> And the above config is wrong. You have to bind your card with the
> serial_cs driver, because it is a serial PCMCIA card.

Ahh, then I'm back to square one.  Before I added the configuration to
config.opts  cardmgr was  trying to start serial_cs and I was getting
the error:

Jan 19 16:14:50 [cardmgr] + WARNING: Error inserting 8250
(/lib/modules/2.6.1-ben1/kernel/drivers/serial/8250.ko): Device or
resource busy

I didn't understand it was because the internal serial ports were using
ttyS0 and ttyS1. With the ports disabled the card is now starting. 

Should cardmgr, serial_cs.ko, or 8250.ko been able to see that the ports
were already used?  (The powerbook uses pmaczilog.ko) If not where can
that be configured.  Also, a config definition for the card doesn't seem
to be needed.  Should I put one in config.opts?

Forward to step two.

> After that you can use "hciattach <dev> socket" to init the Bluetooth
> chip on this card.

running "hciattach /dev/tts/0 socket" I get:

BCSP initialization timed out

I built and tried a 2.4.24 kernel and the command works fine.   I would
prefer to stay with the 2.6 kernel.  I there anything I can try? If its
of any help there's lofiles, etc below.

Thanks for getting me this far,

digger

logfile for insertion:

Jan 21 09:53:55 [cardmgr] initializing socket 0
Jan 21 09:53:55 [cardmgr] socket 0: Serial or Modem
Jan 21 09:53:55 [cardmgr] product info: "Socket", "CF+ Personal Network
Card Rev 2.5"
Jan 21 09:53:55 [cardmgr] manfid: 0x0104, 0x0096  function: 2 (serial)
Jan 21 09:53:55 [cardmgr] executing: 'modprobe serial_cs'
Jan 21 09:53:55 [kernel] Serial: 8250/16550 driver $Revision: 1.90 $ 8
ports, IRQ sharing disabled
Jan 21 09:53:55 [kernel] IN from bad port 3f9 at e30fa030
Jan 21 09:53:55 [kernel] IN from bad port 3f9 at e30fa030
Jan 21 09:53:55 [kernel] IN from bad port 2f9 at e30fa030
Jan 21 09:53:55 [kernel] IN from bad port 2f9 at e30fa030
Jan 21 09:53:55 [kernel] IN from bad port 2f9 at e30fa030
Jan 21 09:53:55 [kernel] IN from bad port 3e9 at e30fa030
Jan 21 09:53:55 [kernel] IN from bad port 3e9 at e30fa030
Jan 21 09:53:55 [kernel] IN from bad port 3e9 at e30fa030
Jan 21 09:53:55 [kernel] IN from bad port 2e9 at e30fa030
Jan 21 09:53:55 [kernel] IN from bad port 2e9 at e30fa030
Jan 21 09:53:55 [kernel] IN from bad port 2e9 at e30fa030
Jan 21 09:53:56 [kernel] bus pcmcia: add driver serial_cs
Jan 21 09:53:56 [kernel] t yS0 at I/O 0x3f8 (irq = 58) is a 16C950/954
Jan 21 09:53:56 [cardmgr] executing: './serial start ttyS0'
Jan 21 09:53:56 [cardmgr] + Default modem setup

logfile for taking out card.
Does this mean anything?

Jan 21 10:00:00 [kernel] Trying to free nonexistent resource
<000003f8-000003ff>
Jan 21 10:00:00 [cardmgr] shutting down socket 0
Jan 21 10:00:00 [cardmgr] executing: './serial stop ttyS0'


from kernel config for 2.6.1-benh

#
# Bluetooth support
#
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
# CONFIG_BT_RFCOMM_TTY is not set
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
                                                                                                                                                             
#
# Bluetooth device drivers
#
# CONFIG_BT_HCIUSB is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_BCSP_TXCRC=y
# CONFIG_BT_HCIDTL1 is not set
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIBTUART=m
CONFIG_BT_HCIVHCI=m

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
                                                                                                                                                             
#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_SERIAL_PMACZILOG=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256


myrna% cat /proc/interrupts

:          0   OpenPIC   Edge      PMac Output
  2:          0   OpenPIC   Edge      PMac Input
 19:      44934   OpenPIC   Level     ide0
 20:         34   OpenPIC   Level     ide1
 25:     467081   OpenPIC   Level     VIA-PMU
 26:        964   OpenPIC   Level     keywest i2c
 27:          9   OpenPIC   Level     ohci_hcd
 28:          9   OpenPIC   Level     ohci_hcd
 42:          0   OpenPIC   Level     keywest i2c
 47:      33836   OpenPIC   Level     GPIO1/ADB
 48:     150696   OpenPIC   Level     radeon@PCI:0:16:0
 57:      71879   OpenPIC   Level     Airport
 58:        300   OpenPIC   Level     yenta
 61:          0   OpenPIC   Edge      Tumbler Headphone Detection
BAD:         14

myrna% cat /proc/ioports

00000000-007fffff : /pci@f2000000
  00001000-00008fff : PCI CardBus #02
  00009000-000090ff : PCI CardBus #02
00802000-01001fff : /pci@f0000000
  00802400-008024ff : 0000:00:10.0
ff7fe000-ffffdfff : /pci@f4000000

myrna% cat /proc/iomem

80000000-afffffff : /pci@f2000000
  80000000-8007ffff : 0001:01:17.0
    80000000-8007ffff : 0.80000000:mac-io
      80000050-8000007f : 0.00000050:gpio
      80008000-800080ff : 0.00010000:i2s
        80008000-800080ff : i2s-a- Tx DMA
      80008100-800081ff : 0.00010000:i2s
        80008100-800081ff : i2s-a- Rx DMA
      80008200-800082ff : 0.00010000:i2s
      80008300-800083ff : 0.00010000:i2s
      80008a00-80008aff : 0.0001f000:ata-4
        80008a00-80008aff : ide-pmac (dma)
      80008b00-80008bff : 0.00020000:ata-3
        80008b00-80008bff : ide-pmac (dma)
      80008c00-80008cff : 0.00021000:ata-3
        80008c00-80008cff : ide-pmac (dma)
      80010000-80010fff : 0.00010000:i2s
        80010000-80010fff : i2s-a
      80013000-80013000 : 0.00013000:ch-b
      80013010-80013010 : 0.00013000:ch-b
      80013020-80013020 : 0.00013020:ch-a
      80013030-80013030 : 0.00013020:ch-a
      80013040-80013040 : 0.00013000:ch-b
      80013050-80013050 : 0.00013020:ch-a
      80015000-80015fff : 0.00015000:timer
      80016000-80017fff : 0.00016000:via-pmu
        80016000-80017fff : via-pmu
      80018000-80018fff : 0.00018000:i2c
      8001a000-8001a0ff : 0.00030000:radio
      8001f000-8001ffff : 0.0001f000:ata-4
        8001f000-8001ffff : ide-pmac (ports)
      80020000-80020fff : 0.00020000:ata-3
        80020000-80020fff : ide-pmac (ports)
      80021000-80021fff : 0.00021000:ata-3
      80030000-800300ff : 0.00030000:radio
        80030000-800300ff : airport
      80040000-8007ffff : 0.00040000:interrup
        80040000-8007ffff : interrupt-controller
  80080000-80080fff : card services
  90000000-9fffffff : PCI CardBus #02
  a0000000-a0000fff : 0001:01:1a.0
    a0000000-a0000fff : yenta_socket
  a0001000-a0001fff : 0001:01:19.0
    a0001000-a0001fff : ohci_hcd
  a0002000-a0002fff : 0001:01:18.0
    a0002000-a0002fff : ohci_hcd
b0000000-bfffffff : /pci@f0000000
  b0000000-b000ffff : 0000:00:10.0
    b0000000-b000ffff : radeonfb
  b8000000-bfffffff : 0000:00:10.0
    b8000000-bfffffff : radeonfb
f1000000-f1ffffff : /pci@f0000000
  f1000000-f101ffff : 0000:00:10.0
f3000000-f3ffffff : /pci@f2000000
  f3000000-f31fffff : PCI CardBus #02
f5000000-f5ffffff : /pci@f4000000
  f5000000-f5000fff : 0002:06:0e.0
  f5200000-f53fffff : 0002:06:0f.0
f8000000-f8ffffff : uni-n
