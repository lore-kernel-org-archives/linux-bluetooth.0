Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43D2A400.4030709@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problems when inserting snd_bt_sco module in the
 kernel
References: <20060121191202.51632.qmail@web32010.mail.mud.yahoo.com>
In-Reply-To: <20060121191202.51632.qmail@web32010.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 21 Jan 2006 14:13:36 -0700

Dani

You need to build the snd_hwdep kernel module. iirc, it's something like:

make -C /usr/src/linux CONFIG_SND_HWDEP=m modules modules_install

you will also need to get a csr dongle unless you're helping with the
broadcom workaround.

brad

> I have a Fedora Core 3 box with kernel 2.6.12-1.1372. I have a Logitech
> bluetooth headset and for my Linux box a USB dongle with a bluetooth
> chipset from Broadcom Corp.
> 
> The bluetooth dongle is working fine and I can see my Logitech headset
> with hcitool scan. I have compiled the btsco driver in order to use the
> headset, but the problem comes when I try to insert the snd_bt_sco in
> the kernel, by doing:
> -----------------------------------------------------------------------------------------------------------------
> #modprobe snd_bt_sco
> FATAL: Error inserting snd_bt_sco
> (/lib/modules/2.6.12-1.1372_FC3/extra/snd-bt-sco.ko): Unknown symbol in
> module, or unknown parameter (see dmesg)
> -----------------------------------------------------------------------------------------------------------------
> This is the output from dmesg:
> -----------------------------------------------------------------------------------------------------------------
> snd_bt_sco: disagrees about version of symbol snd_pcm_new
> snd_bt_sco: Unknown symbol snd_pcm_new
> snd_bt_sco: disagrees about version of symbol snd_pcm_lib_ioctl
> snd_bt_sco: Unknown symbol snd_pcm_lib_ioctl
> snd_bt_sco: disagrees about version of symbol snd_hwdep_new
> snd_bt_sco: Unknown symbol snd_hwdep_new
> snd_bt_sco: disagrees about version of symbol snd_pcm_set_ops
> snd_bt_sco: Unknown symbol snd_pcm_set_ops
> snd_bt_sco: disagrees about version of symbol snd_pcm_period_elapsed
> snd_bt_sco: Unknown symbol snd_pcm_period_elapsed
> snd_bt_sco: disagrees about version of symbol snd_pcm_new
> snd_bt_sco: Unknown symbol snd_pcm_new
> snd_bt_sco: disagrees about version of symbol snd_pcm_lib_ioctl
> snd_bt_sco: Unknown symbol snd_pcm_lib_ioctl
> snd_bt_sco: disagrees about version of symbol snd_hwdep_new
> snd_bt_sco: Un known symbol snd_hwdep_new
> snd_bt_sco: disagrees about version of symbol snd_pcm_set_ops
> snd_bt_sco: Unknown symbol snd_pcm_set_ops
> snd_bt_sco: disagrees about version of symbol snd_pcm_period_elapsed
> snd_bt_sco: Unknown symbol snd_pcm_period_elapsed
> -----------------------------------------------------------------------------------------------------------------
> More output information that can be useful:
> -----------------------------------------------------------------------------------------------------------------
> #hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:80:5A:40:9E:72 ACL MTU: 377:10  SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:1114 acl:6 sco:0 events:48 errors:0
>         TX bytes:485 acl:6 sco:0 commands:23 errors:0
>         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'dani-laptop-0'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
>         Manufacturer: Broadcom Corporation (15)
> -------------------------------------------------------------------------------------------------------------
> #hciconfig hci0 revision
> hci0:    Type: USB
>         BD Address: 00:80:5A:40:9E:72 ACL MTU: 377:10  SCO MTU: 16:0
>         Firmware 0.3.009
> -------------------------------------------------------------------------------------------------------------
> #hcitool info 00:0D:44:0C:11:4A (headset's address)
> Requesting information ...
>         BD Address:  00:0D:44:0C:11:4A
>         Device Name: Logitech HS01-V16
>         LMP Version: 1.2 (0x2) LMP Subversion: 0x611
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
>                 <encryption> <slot offset> <timing accuracy> < ;role switch>
>                 <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
>                 <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
>                 <paging scheme> <power control> <transparent SCO>
>                 <AFH cap. slave> <AFH cap. master>
> -------------------------------------------------------------------------------------------------------------------
> # btsco -v
> btsco v0.4c
> Error: control open (hw:2): No such file or directory
> Error: Can't find device. Bail
> ---------------------------------------------------------------------------------------------------------------------
> 
> Any idea about what is wrong ? Maybe my USB dongle does not work with
> the btsco driver ?
> 
> Thanks in advance
> 
> Dani Camps
> 
> 
> ------------------------------------------------------------------------
> Yahoo! Photos
> Got holiday prints? See all the ways
> <http://us.rd.yahoo.com/mail_us/taglines/holidayprints/*http://pa.yahoo.com/*http://us.rd.yahoo.com/mail_us/taglines/photos/evt=38089/*http://pg.photos.yahoo.com/ph//print_splash>
> to get quality prints in your hands ASAP.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
