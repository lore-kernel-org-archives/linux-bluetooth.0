Return-Path: <cyrus@holtmann.org>
Message-ID: <492EFCDC.1050504@kaa.org.ua>
Date: Thu, 27 Nov 2008 22:02:36 +0200
From: Oleg Kravchenko <oleg@kaa.org.ua>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: BCM2045B2
References: <49200DE9.4080606@kaa.org.ua> <FE93A0F6-15DB-4F0D-BF59-B719C497E4F3@holtmann.org>
In-Reply-To: <FE93A0F6-15DB-4F0D-BF59-B719C497E4F3@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann написав(ла):
> Hi Oleg,
>
>> Asus P535 details on http://www.kaa.org.ua/asus-p535/hardware.html
>> Bluetooth chip BCM2045B2 connected to the pxa internal usb host.
>>
>> I think this chip need firmware, because it is can only search
>> How I can upload firmware to the this chip?
>
> no, the chip needs a HCI Reset call. Load btusb with reset=1. And send
> the output of /proc/bus/usb/devices for this dongle.
>
> Regards
>
> Marcel
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
I am load modprobe btusb reset=1

Content of /proc/bus/usb/devices:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
B:  Alloc= 22/900 us ( 2%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0001 Rev= 2.06
S:  Manufacturer=Linux 2.6.27 ohci_hcd
S:  Product=PXA27x OHCI
S:  SerialNumber=pxa27x
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=2045 Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM2045A
S:  SerialNumber=000000000000
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

When I try establish bnep connection:
localhost ~ # ifconfig bnep0 10.9.0.2
SIOCSIFFLAGS: Cannot assign requested address

So when I enable bluetooth in Windows Mobile
localhost ~ # ifconfig bnep0 10.9.0.2
work's fine :)

This is a Windows bluetooth log:
15:16:55:512 RadioInitPreLoad Start
15:16:55:553 Using USB, no PreLoad code
15:16:55:579 RadioInitPreLoad End
15:16:56:351 RadioInitPostLoad Start
15:16:56:365 BRCM_PostLoad TOP
15:16:56:385 Send_HCI_Read_BDaddr was successful
15:16:56:399 BRCM2045CFG2RAMmain(USB) TOP
15:16:56:412 Sending HCI_DOWNLOAD_MINIDRIVER
15:16:57:946 Writing config binary image through HCI_WRITE_RAM commands
15:16:57:971 Loaded config data file
\Windows\BCM2045B2_002.002.011.0131.0001.hcd, length=9459 bytes
15:16:57:985 Using USB, and using an external .hcd config file
15:16:57:000     target_ram_addr = 0x00:08:5c:70
15:16:57:014     launch_ram_addr = 0x00:08:8b:d8
15:16:57:039 HCIVSWriteRAM(addr=0x70:0x5c:0x08:0x00, nbytes=139)
15:16:57:067 HCIVSWriteRAM(addr=0xf7:0x5c:0x08:0x00, nbytes=255)
15:16:57:106 HCIVSWriteRAM(addr=0xf2:0x5d:0x08:0x00, nbytes=255)
15:16:57:136 HCIVSWriteRAM(addr=0xed:0x5e:0x08:0x00, nbytes=255)
15:16:57:165 HCIVSWriteRAM(addr=0xe8:0x5f:0x08:0x00, nbytes=255)
15:16:57:195 HCIVSWriteRAM(addr=0xe3:0x60:0x08:0x00, nbytes=255)
15:16:57:226 HCIVSWriteRAM(addr=0xde:0x61:0x08:0x00, nbytes=255)
15:16:57:257 HCIVSWriteRAM(addr=0xd9:0x62:0x08:0x00, nbytes=255)
15:16:57:287 HCIVSWriteRAM(addr=0xd4:0x63:0x08:0x00, nbytes=255)
15:16:57:317 HCIVSWriteRAM(addr=0xcf:0x64:0x08:0x00, nbytes=255)
15:16:57:347 HCIVSWriteRAM(addr=0xca:0x65:0x08:0x00, nbytes=255)
15:16:57:377 HCIVSWriteRAM(addr=0xc5:0x66:0x08:0x00, nbytes=255)
15:16:57:429 HCIVSWriteRAM(addr=0xc0:0x67:0x08:0x00, nbytes=255)
15:16:57:459 HCIVSWriteRAM(addr=0xbb:0x68:0x08:0x00, nbytes=255)
15:16:57:489 HCIVSWriteRAM(addr=0xb6:0x69:0x08:0x00, nbytes=255)
15:16:57:553 HCIVSWriteRAM(addr=0xb1:0x6a:0x08:0x00, nbytes=255)
15:16:57:654 HCIVSWriteRAM(addr=0xac:0x6b:0x08:0x00, nbytes=255)
15:16:57:729 HCIVSWriteRAM(addr=0xa7:0x6c:0x08:0x00, nbytes=255)
15:16:58:767 HCIVSWriteRAM(addr=0xa2:0x6d:0x08:0x00, nbytes=255)
15:16:58:890 HCIVSWriteRAM(addr=0x9d:0x6e:0x08:0x00, nbytes=255)
15:16:58:973 HCIVSWriteRAM(addr=0x98:0x6f:0x08:0x00, nbytes=255)
15:16:58:208 HCIVSWriteRAM(addr=0x93:0x70:0x08:0x00, nbytes=255)
15:16:58:384 HCIVSWriteRAM(addr=0x8e:0x71:0x08:0x00, nbytes=255)
15:16:58:607 HCIVSWriteRAM(addr=0x89:0x72:0x08:0x00, nbytes=255)
15:16:58:737 HCIVSWriteRAM(addr=0x84:0x73:0x08:0x00, nbytes=255)
15:16:59:972 HCIVSWriteRAM(addr=0x7f:0x74:0x08:0x00, nbytes=255)
15:16:59:025 HCIVSWriteRAM(addr=0x7a:0x75:0x08:0x00, nbytes=255)
15:16:59:126 HCIVSWriteRAM(addr=0x75:0x76:0x08:0x00, nbytes=255)
15:16:59:155 HCIVSWriteRAM(addr=0x70:0x77:0x08:0x00, nbytes=255)
15:16:59:372 HCIVSWriteRAM(addr=0x6b:0x78:0x08:0x00, nbytes=255)
15:16:59:447 HCIVSWriteRAM(addr=0x66:0x79:0x08:0x00, nbytes=255)
15:16:59:590 HCIVSWriteRAM(addr=0x61:0x7a:0x08:0x00, nbytes=255)
15:16:59:621 HCIVSWriteRAM(addr=0x5c:0x7b:0x08:0x00, nbytes=255)
15:16:59:670 HCIVSWriteRAM(addr=0x57:0x7c:0x08:0x00, nbytes=255)
15:16:59:711 HCIVSWriteRAM(addr=0x52:0x7d:0x08:0x00, nbytes=255)
15:16:59:752 HCIVSWriteRAM(addr=0x4d:0x7e:0x08:0x00, nbytes=255)
15:17:00:807 HCIVSWriteRAM(addr=0x48:0x7f:0x08:0x00, nbytes=222)
15:17:00:930 HCIVSWriteRAM(addr=0xd8:0x8b:0x08:0x00, nbytes=52)
15:17:00:949 HCI_WRITE_RAM commands done
15:17:00:964 Sending HCI_LAUNCH_RAM command
15:17:00:984 HCI_LAUNCH_RAM was successful
15:17:00:499 BRCM2045CFG2RAMmain() END, config data downloaded successfully
15:17:00:519 Send_HCI_Read_BDaddr was successful
15:17:00:534 Read BDAddr [00:1a:92:ab:e3:31] from the registry
15:17:00:554 Send_Broadcom_Write_BD_ADDR was successful
15:17:00:574 Send_HCI_Read_BDaddr was successful
15:17:00:599 HCIWriteChannelClassificationMode : bResult=1
15:17:00:614 HCIVSSetSleepModeParam() Mode=USB with
HOST_WAKE,HostIdleThreshold=10, HCIdleThreshold=10, BT_WAKE active HIGH,
HOST_WAKE active HIGH
15:17:00:628     USB AutoSleepOnSuspend=1, USB Resume Timeout = 3
15:17:00:650 HCIVSSetSleepModeParam(mode=5, timeout=3000ms): bResult=1
15:17:00:665 BRCM_PostLoad : RadioInitConfigureAudio set, configuring
2045 audio
15:17:00:686 HCIVSWriteSCOPCMIntParameters(0,2,0,0,0) : bResult=1
15:17:00:705 HCIVSWritePCMDataFormatParameters(0,0,2,3,1) : bResult=1
15:17:00:721 HCIVSWriteSCOTimeSlot(SCO Time Slot=0)
15:17:00:741 HCIVSWriteSCOTimeSlot : bResult=1
15:17:00:754 BRCM_PostLoad : RadioInitEnableCoexistence set, configuring
2045 BT/WLAN coexistence
15:17:01:774 HCIVSWriteCollaborationMode(1,1,0xcb7fbdb0,10) : bResult=1
15:17:01:787 BRCM_PostLoad END
15:17:01:801 RadioInitPostLoad End
