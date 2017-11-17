Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: John Klug <ski.brimson@gmail.com>
Date: Fri, 17 Nov 2017 16:44:42 -0600
Message-ID: <CADU0Vqzwvv9Y+SHe8EL9KTGAMD3pkpw=d-2WgNX2pfr_MXUprw@mail.gmail.com>
Subject: Connection attempt timeout Android 4.4.4 to bluez5.47
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is with "trusted" enabled and I did set default-agent.  Devices
were first paired, which was initiated from the Android device.

This was initiated from Android after pairing by selecting Internet
Access (PAN):

[bluetooth]# show
Controller 00:23:A7:49:67:FB
        Name: MTCDT-PAND-JAK
        Alias: MTCDT-PAND-JAK
        Class: 0x00020000
        Powered: yes
        Discoverable: yes
        Pairable: yes
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: NAP                       (00001116-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v1D6Bp0246d052F
        Discovering: no
[bluetooth]# info BC:44:86:56:6B:95
Device BC:44:86:56:6B:95
        Name: John Conduit Klug (SGH-M919)
        Alias: John Conduit Klug (SGH-M919)
        Class: 0x005a020c
        Icon: phone
        Paired: yes
        Trusted: yes
        Blocked: no
        Connected: no
        LegacyPairing: no
        UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
        UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
        UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
        UUID: PANU                      (00001115-0000-1000-8000-00805f9b34fb)
        UUID: Handsfree Audio Gateway   (0000111f-0000-1000-8000-00805f9b34fb)
        UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
        UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        Modalias: bluetooth:v0075p0100d0200
[bluetooth]# default-agent

> HCI Event: Connect Request (0x04) plen 10                                                                                                                                  #6 [hci0] 107.758175
        Address: BC:44:86:56:6B:95 (OUI BC-44-86)
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7

                               #7 [hci0] 107.758365
        Address: BC:44:86:56:6B:95 (OUI BC-44-86)
        Role: Master (0x00)
> HCI Event: Command Status (0x0f) plen 4                                                                                                                                    #8 [hci0] 107.762336
      Accept Connection Request (0x01|0x0009) ncmd 1
        Status: Success (0x00)
> HCI Event: Role Change (0x12) plen 8                                                                                                                                       #9 [hci0] 107.924039
        Status: Success (0x00)
        Address: BC:44:86:56:6B:95 (OUI BC-44-86)
        Role: Master (0x00)
> HCI Event: Connect Complete (0x03) plen 11                                                                                                                                #10 [hci0] 113.931557
        Status: Connection Timeout (0x08)
        Handle: 0
        Address: BC:44:86:56:6B:95 (OUI BC-44-86)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
@ Connect Failed: BC:44:86:56:6B:95 (0) status 0x08
