Return-Path: <till@harbaum.org>
From: Till Harbaum <till@harbaum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] Fighting with SCO
Date: Thu, 26 Aug 2004 22:29:26 +0200
Cc: Till Harbaum <harbaum@beecon.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200408261852.56641.harbaum@beecon.de> <200408262000.07077.till@harbaum.org> <1093548184.2581.48.camel@pegasus>
In-Reply-To: <1093548184.2581.48.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408262229.26435.till@harbaum.org>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On Thursday 26 August 2004 21:23, Marcel Holtmann wrote:
> do you played with the PS key settings, because the default for the Acer
> was sending SCO traffic over the PCM interface. Use the revision command
> to check where the SCO traffic is routed through.
No, i didn't. The factory settings of my BT-600 are:
phobos:/home/harbaum # hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:02:72:B1:59:03 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI

But so says the DBT-120 dongle i did not have success with:
hci0:   Type: USB
        BD Address: 00:0D:88:C0:3C:E4 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 15.3
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI

I tried this command at work with the microsoft dongle, but the i only got 
16.1 as the hci version and then the program hanged. The kernel log showed 
some hci timeouts.

> Send me the output of "hcitool info ...".
phobos:/home/harbaum # hcitool info 00:06:C5:03:C8:7E
Requesting information ...
        BD Address:  00:06:C5:03:C8:7E
        Device Name: BlueTrek G2
        LMP Version: 1.1 (0x1) LMP Subversion: 0x42c
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0f 0x00 0x00 0x00 0x00 0x00

                <encryption>
                <slot offset>
                <timing accuracy>
                <role switch>
                <hold mode>
                <sniff mode>
                <park state>
                <RSSI>
                <channel quality>
                <SCO link>
                <HV2 packets>
                <HV3 packets>
                <u-law log>
                <A-law log>
                <CVSD>
                <paging scheme>
                <power control>
                <transparent SCO>

Ciao,
  Till

-- 
Dr.Ing. Till Harbaum, till@harbaum.org
