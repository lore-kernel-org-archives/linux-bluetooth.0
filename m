Return-Path: <tony@atomide.com>
Date: Wed, 23 Jun 2004 09:14:15 -0700
From: Tony Lindgren <tony@atomide.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AmbiCom BT2000C works with hciattach
Message-ID: <20040623161414.GA9129@atomide.com>
References: <20040623031119.GA20367@atomide.com> <1087976062.4209.61.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1087976062.4209.61.camel@pegasus>
Sender: <tony@atomide.com>
List-ID: <bluez-devel.lists.sourceforge.net>

* Marcel Holtmann <marcel@holtmann.org> [040623 00:34]:
> Hi Tony,
> 
> > Just FYI, there was some discussion here a while back on the 
> > AmbiCom BT2000C, which is different from the earlier BT2000 
> > models.
> > 
> > Well turns out it works fine with serial_cs + hciattach:
> > 
> > hciattach /dev/ttyS1 csr -s 57600 57600
> > or
> > hciattach /dev/ttyS1 csr -s 57600 460800
> > hciconfig hci0 up
> > hcitool scan
> > ...
> > 
> > Sorry if this was already old news :) Please CC me on any 
> > replies, I'm not subscribing.
> 
> how good these news are actually depends on what kernel you are using ;)

Using 2.6.7.

> Send me the output of "dump_cis" and I will add a line to hciattach for
> that. What is "hciconfig -a" saying?

Here you are:

# dump_cis
Socket 0:
  dev_info
    no_info
  vers_1 7.1, "AmbiCom BT2000C", "Bluetooth PC/CF Card", "", ""
  manfid 0x022d, 0x2000
  funcid serial_port
  serial_interface
    uart 16550 [space/mark/odd/even] [5/6/7/8] [1/1.5/2]
  config base 0x00f8 mask 0x000f last_index 0x03
  cftable_entry 0x01 [default]
    [rdybsy] [audio] [pwrdown]
    Vcc Vnom 3300mV Vmin 3V Vmax 3600mV Iavg 300mA
    Ipeak 300mA Idown 10mA
    io 0x02f8-0x02ff [lines=3] [8bit] [range]
    irq mask 0x86bc [level] [pulse] [shared]
  cftable_entry 0x02
    io 0x03e8-0x03ef [lines=3] [8bit] [range]
  cftable_entry 0x03
    io 0x02e8-0x02ef [lines=3] [8bit] [range]
# hciattach /dev/ttyS1 csr -s 57600 460800
CSR build ID 0x02-0x0D
# hciconfig hci0 up
# hciconfig -a
hci0:   Type: UART
        BD Address: 00:10:xx:xx:xx:xx ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:79 acl:0 sco:0 events:8 errors:0
        TX bytes:39 acl:0 sco:0 commands:8 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: 
        Link mode: SLAVE ACCEPT 
        Name: 'tony laptop (0)'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous, 
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
	Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)
