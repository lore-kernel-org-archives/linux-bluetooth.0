Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] uinput and modules.conf
References: <200403160905.27291.cijoml@volny.cz> <200403161337.13936.cijoml@volny.cz> <1079442594.3307.73.camel@pegasus>
In-Reply-To: <1079442594.3307.73.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403161418.11554.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 16 Mar 2004 14:18:11 +0100

Dne =FAt 16. b=F8ezna 2004 14:09 jste napsal(a):
> Hi Michal,
>
> > Hmm I have it and module is not autoloaded  :(
> >
> > crw-r--r--    1 root     root      10, 223 led 11 23:22 /dev/input/uinp=
ut
>
> do you use a 2.6 kernel?

2.4.25-mh2

>
> > I runs /opt/bluetooth/sbin/bthid -d in script, daemon starts but not au=
to
> > accepts my mouse which wants reconnect. Blue Led blinks on microsoft BT
> > dongle, but I have to call bthid -c and then mouse is connected.
> > How to instruct your bthid, Marcel, to auto accept my devices?
>
> Do you have special settings in hcid.conf?

not exactly:

=2D----
# HCId options
options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        security auto;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # PIN helper
        pin_helper /bin/bluepin;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        #name "BlueZ (%d)";
        name "Linux (%h)";

        # Local device class
        class 0x10c;
        #class 0x100100;

        # Default packet type
        pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy
        #   accept - always accept incoming connections
        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections
        #
        #lm accept,master;
        #
        lm accept,master;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        #
        #lp hold,sniff;
        #
        lp hold,sniff,park,rswitch;

        # Authentication and Encryption
        auth disable;
        encrypt disable;
=2D---


>
> > Second problem is follows:
> > My keyboard doesn't work:
> > Mar 16 13:30:06 notas bthid[740]: Connected: Microsoft Bluetooth keyboa=
rd
> > (045e:007b)
> > Mar 16 13:30:06 notas bthid[740]: Vendor HID usage 0xff00fe01 value 0x1
> > Mar 16 13:30:06 notas bthid[740]: adequate battery
> > Mar 16 13:30:06 notas bthid[740]: Vendor HID usage 0xff00fe03 value 0x0
> > Mar 16 13:30:06 notas bthid[740]: Vendor HID usage 0xff00fe04 value 0x0
> > Mar 16 13:30:06 notas bthid[740]: Unknown HID usage (0xff00fe04 + 0)
> >
> > At first time it worked, then I switched off computer and wanted started
> > it again, but then bthid writes this into syslog.
> > I write on keyboard, but no reply is sent into console :(
>
> The usage errors can be ignored, because they are vendor specific.

OK, but it doesn't work :)

>
> > hcidump but shows data when I writes on keyboard:
> > notas:/home/cijoml# hcidump
> > HCIDump - HCI packet analyzer ver 1.7
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> >
> > > ACL data: handle 0x0029 flags 0x02 dlen 14
> >
> >     L2CAP(d): cid 0x41 len 10 [psm 0]
> >
> > > HCI Event: Mode Change(0x14) plen 6
> > > HCI Event: Mode Change(0x14) plen 6
> > > ACL data: handle 0x0029 flags 0x02 dlen 14
> >
> >     L2CAP(d): cid 0x41 len 10 [psm 0]
> >
> > > ACL data: handle 0x0029 flags 0x02 dlen 14
> >
> >     L2CAP(d): cid 0x41 len 10 [psm 0]
>
> So there is a connection and it looks like the HID parser is also
> working, but no input events are generated. Do you forget to load or
> compile in some extra modules like keybdev for 2.4.

I have all of them
keybdev                 2148   0  (unused)
uinput                    1996   2
hostap_cs              45288   0  (unused)
hostap                 74888   0  [hostap_cs]
nsc-ircc               10588   1  (autoclean)
irlan                  23388   0  (unused)
irtty                   6528   0  (unused)
ircomm-tty             21760   0  (unused)
ircomm                  8396   0  [ircomm-tty]
irda                   98012   0  [nsc-ircc irlan irtty ircomm-tty ircomm]
ide-cd                 33412   1  (autoclean)
cdrom                  30912   0  (autoclean) [ide-cd]
rfcomm                 35360   4  (autoclean)
l2cap                  18608  13  [rfcomm]
hci_usb                 8536   1
bluez                  35844   3  [rfcomm l2cap hci_usb]
slamr                 246308   2  (autoclean)
i810_audio             24860   1  (autoclean)
ac97_codec             13108   0  (autoclean) [i810_audio]
8139too                13864   1  (autoclean)
mii                     2464   0  (autoclean) [8139too]
nls_iso8859-2           3324   1  (autoclean)
ntfs                   56096   1  (autoclean)
mousedev                4372   2  (autoclean)
hid                    16424   0  (unused)
input                   3360   0  [keybdev fake mousedev hid]
rtc                     6856   0  (autoclean)


>
> Regards
>
> Marcel

I tried Peter's bthid and it works perfectly...???

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
