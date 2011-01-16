Return-Path: <cyrus@holtmann.org>
From: Oleg Kravchenko <oleg@kaa.org.ua>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: BCM2045B2
Date: Mon, 17 Jan 2011 00:51:21 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <49200DE9.4080606@kaa.org.ua> <FE93A0F6-15DB-4F0D-BF59-B719C497E4F3@holtmann.org> <492EFCDC.1050504@kaa.org.ua>
In-Reply-To: <492EFCDC.1050504@kaa.org.ua>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201101170051.22009.oleg@kaa.org.ua>
List-ID: <linux-bluetooth.vger.kernel.org>

Any idea?

=D1=87=D0=B5=D1=82=D0=B2=D0=B5=D1=80 27 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=
=BF=D0=B0=D0=B4 2008 22:02:36 Oleg Kravchenko =D0=B2=D0=B8 =D0=BD=D0=B0=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BB=D0=B8:
> Marcel Holtmann =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=D0=BB=D0=B0):
> > Hi Oleg,
> >=20
> >> Asus P535 details on http://www.kaa.org.ua/asus-p535/hardware.html
> >> Bluetooth chip BCM2045B2 connected to the pxa internal usb host.
> >>=20
> >> I think this chip need firmware, because it is can only search
> >> How I can upload firmware to the this chip?
> >=20
> > no, the chip needs a HCI Reset call. Load btusb with reset=3D1. And send
> > the output of /proc/bus/usb/devices for this dongle.
> >=20
> > Regards
> >=20
> > Marcel
>=20
> I am load modprobe btusb reset=3D1
>=20
> Content of /proc/bus/usb/devices:
>=20
> T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 3
> B:  Alloc=3D 22/900 us ( 2%), #Int=3D  1, #Iso=3D  0
> D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D1d6b ProdID=3D0001 Rev=3D 2.06
> S:  Manufacturer=3DLinux 2.6.27 ohci_hcd
> S:  Product=3DPXA27x OHCI
> S:  SerialNumber=3Dpxa27x
> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
>=20
> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12  M=
xCh=3D 0
> D:  Ver=3D 2.00 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D0a5c ProdID=3D2045 Rev=3D 1.12
> S:  Manufacturer=3DBroadcom Corp
> S:  Product=3DBCM2045A
> S:  SerialNumber=3D000000000000
> C:* #Ifs=3D 4 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3D(none)
> E:  Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
> E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms
> I:* If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D00 Driver=
=3D(none)
>=20
> When I try establish bnep connection:
> localhost ~ # ifconfig bnep0 10.9.0.2
> SIOCSIFFLAGS: Cannot assign requested address
>=20
> So when I enable bluetooth in Windows Mobile
> localhost ~ # ifconfig bnep0 10.9.0.2
> work's fine :)
>=20
> This is a Windows bluetooth log:
> 15:16:55:512 RadioInitPreLoad Start
> 15:16:55:553 Using USB, no PreLoad code
> 15:16:55:579 RadioInitPreLoad End
> 15:16:56:351 RadioInitPostLoad Start
> 15:16:56:365 BRCM_PostLoad TOP
> 15:16:56:385 Send_HCI_Read_BDaddr was successful
> 15:16:56:399 BRCM2045CFG2RAMmain(USB) TOP
> 15:16:56:412 Sending HCI_DOWNLOAD_MINIDRIVER
> 15:16:57:946 Writing config binary image through HCI_WRITE_RAM commands
> 15:16:57:971 Loaded config data file
> \Windows\BCM2045B2_002.002.011.0131.0001.hcd, length=3D9459 bytes
> 15:16:57:985 Using USB, and using an external .hcd config file
> 15:16:57:000     target_ram_addr =3D 0x00:08:5c:70
> 15:16:57:014     launch_ram_addr =3D 0x00:08:8b:d8
> 15:16:57:039 HCIVSWriteRAM(addr=3D0x70:0x5c:0x08:0x00, nbytes=3D139)
> 15:16:57:067 HCIVSWriteRAM(addr=3D0xf7:0x5c:0x08:0x00, nbytes=3D255)
> 15:16:57:106 HCIVSWriteRAM(addr=3D0xf2:0x5d:0x08:0x00, nbytes=3D255)
> 15:16:57:136 HCIVSWriteRAM(addr=3D0xed:0x5e:0x08:0x00, nbytes=3D255)
> 15:16:57:165 HCIVSWriteRAM(addr=3D0xe8:0x5f:0x08:0x00, nbytes=3D255)
> 15:16:57:195 HCIVSWriteRAM(addr=3D0xe3:0x60:0x08:0x00, nbytes=3D255)
> 15:16:57:226 HCIVSWriteRAM(addr=3D0xde:0x61:0x08:0x00, nbytes=3D255)
> 15:16:57:257 HCIVSWriteRAM(addr=3D0xd9:0x62:0x08:0x00, nbytes=3D255)
> 15:16:57:287 HCIVSWriteRAM(addr=3D0xd4:0x63:0x08:0x00, nbytes=3D255)
> 15:16:57:317 HCIVSWriteRAM(addr=3D0xcf:0x64:0x08:0x00, nbytes=3D255)
> 15:16:57:347 HCIVSWriteRAM(addr=3D0xca:0x65:0x08:0x00, nbytes=3D255)
> 15:16:57:377 HCIVSWriteRAM(addr=3D0xc5:0x66:0x08:0x00, nbytes=3D255)
> 15:16:57:429 HCIVSWriteRAM(addr=3D0xc0:0x67:0x08:0x00, nbytes=3D255)
> 15:16:57:459 HCIVSWriteRAM(addr=3D0xbb:0x68:0x08:0x00, nbytes=3D255)
> 15:16:57:489 HCIVSWriteRAM(addr=3D0xb6:0x69:0x08:0x00, nbytes=3D255)
> 15:16:57:553 HCIVSWriteRAM(addr=3D0xb1:0x6a:0x08:0x00, nbytes=3D255)
> 15:16:57:654 HCIVSWriteRAM(addr=3D0xac:0x6b:0x08:0x00, nbytes=3D255)
> 15:16:57:729 HCIVSWriteRAM(addr=3D0xa7:0x6c:0x08:0x00, nbytes=3D255)
> 15:16:58:767 HCIVSWriteRAM(addr=3D0xa2:0x6d:0x08:0x00, nbytes=3D255)
> 15:16:58:890 HCIVSWriteRAM(addr=3D0x9d:0x6e:0x08:0x00, nbytes=3D255)
> 15:16:58:973 HCIVSWriteRAM(addr=3D0x98:0x6f:0x08:0x00, nbytes=3D255)
> 15:16:58:208 HCIVSWriteRAM(addr=3D0x93:0x70:0x08:0x00, nbytes=3D255)
> 15:16:58:384 HCIVSWriteRAM(addr=3D0x8e:0x71:0x08:0x00, nbytes=3D255)
> 15:16:58:607 HCIVSWriteRAM(addr=3D0x89:0x72:0x08:0x00, nbytes=3D255)
> 15:16:58:737 HCIVSWriteRAM(addr=3D0x84:0x73:0x08:0x00, nbytes=3D255)
> 15:16:59:972 HCIVSWriteRAM(addr=3D0x7f:0x74:0x08:0x00, nbytes=3D255)
> 15:16:59:025 HCIVSWriteRAM(addr=3D0x7a:0x75:0x08:0x00, nbytes=3D255)
> 15:16:59:126 HCIVSWriteRAM(addr=3D0x75:0x76:0x08:0x00, nbytes=3D255)
> 15:16:59:155 HCIVSWriteRAM(addr=3D0x70:0x77:0x08:0x00, nbytes=3D255)
> 15:16:59:372 HCIVSWriteRAM(addr=3D0x6b:0x78:0x08:0x00, nbytes=3D255)
> 15:16:59:447 HCIVSWriteRAM(addr=3D0x66:0x79:0x08:0x00, nbytes=3D255)
> 15:16:59:590 HCIVSWriteRAM(addr=3D0x61:0x7a:0x08:0x00, nbytes=3D255)
> 15:16:59:621 HCIVSWriteRAM(addr=3D0x5c:0x7b:0x08:0x00, nbytes=3D255)
> 15:16:59:670 HCIVSWriteRAM(addr=3D0x57:0x7c:0x08:0x00, nbytes=3D255)
> 15:16:59:711 HCIVSWriteRAM(addr=3D0x52:0x7d:0x08:0x00, nbytes=3D255)
> 15:16:59:752 HCIVSWriteRAM(addr=3D0x4d:0x7e:0x08:0x00, nbytes=3D255)
> 15:17:00:807 HCIVSWriteRAM(addr=3D0x48:0x7f:0x08:0x00, nbytes=3D222)
> 15:17:00:930 HCIVSWriteRAM(addr=3D0xd8:0x8b:0x08:0x00, nbytes=3D52)
> 15:17:00:949 HCI_WRITE_RAM commands done
> 15:17:00:964 Sending HCI_LAUNCH_RAM command
> 15:17:00:984 HCI_LAUNCH_RAM was successful
> 15:17:00:499 BRCM2045CFG2RAMmain() END, config data downloaded successful=
ly
> 15:17:00:519 Send_HCI_Read_BDaddr was successful
> 15:17:00:534 Read BDAddr [00:1a:92:ab:e3:31] from the registry
> 15:17:00:554 Send_Broadcom_Write_BD_ADDR was successful
> 15:17:00:574 Send_HCI_Read_BDaddr was successful
> 15:17:00:599 HCIWriteChannelClassificationMode : bResult=3D1
> 15:17:00:614 HCIVSSetSleepModeParam() Mode=3DUSB with
> HOST_WAKE,HostIdleThreshold=3D10, HCIdleThreshold=3D10, BT_WAKE active HI=
GH,
> HOST_WAKE active HIGH
> 15:17:00:628     USB AutoSleepOnSuspend=3D1, USB Resume Timeout =3D 3
> 15:17:00:650 HCIVSSetSleepModeParam(mode=3D5, timeout=3D3000ms): bResult=
=3D1
> 15:17:00:665 BRCM_PostLoad : RadioInitConfigureAudio set, configuring
> 2045 audio
> 15:17:00:686 HCIVSWriteSCOPCMIntParameters(0,2,0,0,0) : bResult=3D1
> 15:17:00:705 HCIVSWritePCMDataFormatParameters(0,0,2,3,1) : bResult=3D1
> 15:17:00:721 HCIVSWriteSCOTimeSlot(SCO Time Slot=3D0)
> 15:17:00:741 HCIVSWriteSCOTimeSlot : bResult=3D1
> 15:17:00:754 BRCM_PostLoad : RadioInitEnableCoexistence set, configuring
> 2045 BT/WLAN coexistence
> 15:17:01:774 HCIVSWriteCollaborationMode(1,1,0xcb7fbdb0,10) : bResult=3D1
> 15:17:01:787 BRCM_PostLoad END
> 15:17:01:801 RadioInitPostLoad End
