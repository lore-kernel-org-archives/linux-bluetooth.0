Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAG=hFhJXr5xutpKq9Vwt4DcUui8d8Zdojt-4ccbUnnCmYGk_yg@mail.gmail.com>
References: <CAG=hFhL+OiRiwXLU5_9Yc03v8vOYhkfakp26871LU_AZdB2fmQ@mail.gmail.com>
 <CABBYNZK7t6jRaT1rDoiY=foi+5g74pTYE6KbShYx=8sv+_PW9A@mail.gmail.com>
 <CAG=hFhLGo_0kmWR0oMUP7DMEFD+5QqA5+p5AwfGhPK=-ofmT=Q@mail.gmail.com>
 <CAHFy41-2omfTux6-3VPcv0nHBZEdDu0r0ap2UTrc2z=3c_dtCg@mail.gmail.com>
 <CABBYNZ+B0sMpfg5chgz4nBgF0K9sTdWhxjkM2M9CboqiiBjuOQ@mail.gmail.com> <CAG=hFhJXr5xutpKq9Vwt4DcUui8d8Zdojt-4ccbUnnCmYGk_yg@mail.gmail.com>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Fri, 16 Sep 2016 12:02:14 +0200
Message-ID: <CAAEJBhJk2rd-4T1mc_GQ6UWB91vU_wTSPDQ6nt3+46j5KOsCoQ@mail.gmail.com>
Subject: Re: Issue: Bluez: Bluetooth Mouse Disconnects Soon After Pairing
To: Naveen Kaje <nckaje@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Naveen,

On 15 September 2016 at 20:58, Naveen Kaje <nckaje@gmail.com> wrote:
> Hi,
> Thanks for all the input so far. I found out that the disconnection is
> coming from Bluetooth SMP in Kernel. After host transmits
> SMP_CMD_PAIRING_RANDOM,
> the HID device sends:
>
> SMP_CMD_ENCRYPT_INFO
> SMP_CMD_MASTER_IDENT
> SMP_CMD_IDENT_ADDR_INFO
> SMP_CMD_IDENT_INFO

Could you get btmon traces from pairing so that we don't need to speculate?
In general slave should distribute keys only after master enabled encryption.

There is also a small chance of race between encryption event and ACL data
on USB transport... I've seen this few times on UPFs but have no idea on
how this could be solved without enhancing HCI specification

>
> messages which get filtered out in smp_sig_channel as they don't seem
> to be allowed. This resulted in smp->security_timer firing and
> disconnection.
>
> I made the following change to smp to allow these commands in SMP. I
> am not sure if this the best way to fix it. Looking for input.
>
> With this change, the mouse device pairs successfully (see
> bluetoothctl logs below)
> However, I see the following
>
> "Unable to register GATT service with handle 0x0008 for device
> F5:95:EC:6F:0F:D3"
>
> in /var/log/syslog from bluetoothd. I am not sure if this is concerning.
>
> I understand I am trying to mix and match older Kernel stack with
> newer Bluez. But the tree for my ARM64 board has divereged from
> mainline.
> Hence upgrading the kernel is not easy. (3.18.20 based Kernel and 5.41 Bluez).
>
> Thanks in advance. Logs below.
>
> ****************** Begin Kernel Change *****************************************
> @@ -1515,6 +1515,10 @@ static int smp_sig_channel(struct l2cap_chan
> *chan, struct sk_buff *skb)
>
>         case SMP_CMD_PAIRING_RANDOM:
>                 reason = smp_cmd_pairing_random(conn, skb);
> +               SMP_ALLOW_CMD(smp, SMP_CMD_ENCRYPT_INFO);
> +               SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
> +               SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_ADDR_INFO);
> +               SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_INFO);
>                 break;
>
> ****************** End Kernel Change *******************************************
>
> ******************************* /var/log/syslog begin **************************
>
> Jan  6 18:26:58 Deb-Jessie kernel: [  118.599398] Bluetooth: Frame
> Reassembly Failed
> Jan  6 18:26:58 Deb-Jessie bluetoothd[629]: Unable to register GATT
> service with handle 0x0008 for device F5:95:EC:6F:0F:D3
> Jan  6 18:27:00 Deb-Jessie kernel: [  121.224593] Bluetooth: Frame
> Reassembly Failed
> Jan  6 18:27:01 Deb-Jessie kernel: [  121.692871] Bluetooth: Frame
> Reassembly Failed
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie bluetoothd[629]: bt_uhid_send: Invalid argument (22)
> Jan  6 18:27:01 Deb-Jessie kernel: [  122.146168] input: Designer
> Mouse as /devices/virtual/misc/uhid/0005:0000:0000.0003/input/input8
> Jan  6 18:27:01 Deb-Jessie kernel: [  122.146868] hid-generic
> 0005:0000:0000.0003: input,hidraw2: BLUETOOTH HID v0.00 Mouse
> [Designer Mouse] on 44:1C:A8:6C:8F:5E
>
> ******************************* /var/log/syslog end ****************************
>
> ******************************* bluetoothctl logs ****************************
> root@Deb-Jessie:~# bluetoothctl
> [NEW] Controller 44:1C:A8:6C:8F:5E Deb-Jessie [default]
> [bluetooth]# select 44:1C:A8:6C:8F:5E
> [bluetooth]# power on
> Changing power on succeeded
> [bluetooth]# discoverable on
> Changing discoverable on succeeded
> [bluetooth]# pairable on
> Changing pairable on succeeded
> [bluetooth]# agent on
> Agent registered
> [bluetooth]# default-agent
> Default agent request successful
> [bluetooth]# scan on
> Discovery started
> [CHG] Controller 44:1C:A8:6C:8F:5E Discovering: yes
> [NEW] Device F5:95:EC:6F:0F:D3 Designer Mouse
> [bluetooth]# pair F5:95:EC:6F:0F:D3
> Attempting to pair with F5:95:EC:6F:0F:D3
> [CHG] Device F5:95:EC:6F:0F:D3 Connected: yes
> [CHG] Device F5:95:EC:6F:0F:D3 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
> [CHG] Device F5:95:EC:6F:0F:D3 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
> [CHG] Device F5:95:EC:6F:0F:D3 UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
> [CHG] Device F5:95:EC:6F:0F:D3 UUIDs: 0000180f-0000-1000-8000-00805f9b34fb
> [CHG] Device F5:95:EC:6F:0F:D3 UUIDs: 00001812-0000-1000-8000-00805f9b34fb
> [CHG] Device F5:95:EC:6F:0F:D3 ServicesResolved: yes
> [CHG] Device F5:95:EC:6F:0F:D3 Paired: yes
> [NEW] Primary Service
>         /org/bluez/hci0/dev_F5_95_EC_6F_0F_D3/service0008
>         Generic Attribute Profile
> [NEW] Primary Service
>         /org/bluez/hci0/dev_F5_95_EC_6F_0F_D3/service0009
>         Device Information
> [NEW] Characteristic
>         /org/bluez/hci0/dev_F5_95_EC_6F_0F_D3/service0009/char000a
>         Manufacturer Name String
> [NEW] Characteristic
>         /org/bluez/hci0/dev_F5_95_EC_6F_0F_D3/service0009/char000c
>         PnP ID
> [NEW] Primary Service
>         /org/bluez/hci0/dev_F5_95_EC_6F_0F_D3/service000e
>         Battery Service
> [NEW] Characteristic
>         /org/bluez/hci0/dev_F5_95_EC_6F_0F_D3/service000e/char000f
>         Battery Level
> [NEW] Descriptor
>         /org/bluez/hci0/dev_F5_95_EC_6F_0F_D3/service000e/char000f/desc0011
>         Client Characteristic Configuration
> Pairing successful
> [CHG] Device F5:95:EC:6F:0F:D3 Modalias: usb:v045Ep0805d0110
> [Designer Mouse]# info F5:95:EC:6F:0F:D3
> Device F5:95:EC:6F:0F:D3
>         Name: Designer Mouse
>         Alias: Designer Mouse
>         Appearance: 0x03c2
>         Icon: input-mouse
>         Paired: yes
>         Trusted: no
>         Blocked: no
>         Connected: yes
>         LegacyPairing: no
>         UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
>         UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
>         UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
>         UUID: Battery Service           (0000180f-0000-1000-8000-00805f9b34fb)
>         UUID: Human Interface Device    (00001812-0000-1000-8000-00805f9b34fb)
>         Modalias: usb:v045Ep0805d0110
>         RSSI: -46
>
> **************************** bluetoothctl end **********************************
> Thanks,
> Naveen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
pozdrawiam
Szymon K. Janc
