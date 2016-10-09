Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Gladden <steve@michiganbroadband.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 9 Oct 2016 12:11:08 -0400
Subject: How can you set Transmit power level in Bluetooth LE mode for an LE
 beacon?
Message-ID: <FEFD25773376F6448FE2884F5C1FA527F5E8622404@X2.michiganbb.local>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 
My name is Steve and I am located in Ann Arbor Michigan USA.  

I am new  bluetooth LE and lately am obsessed with Bluetooth LE beacons and trying them out.   

I have read article after article and page after page about how people have setup up beacons with USB BT 4.0 interfaces 
as well as serial bluetooth boards.  

I am currently experimenting with a beacon running on a Raspberry Pi-B and using an external USB Bluetooth 4.0 class 1 dongle.  

My frustration is that I have not been able to find any useful information in how to change the Transmitter power level when in 
LE mode.   

The dongle appears to be working at default level below zero dbm. 

The whole point of building your own beacon this way is to be able to customize it and setting the power level is an important key item
that should be easily accessible yet I find that NOBODY ever even mentions it let alone do they explain or provide a way to set the power.  
 

Every text that I have found that details beacon setups from command line never bother to mention setting beacon TX power.   

All the pages I have found seem to copy each other and repeat the same information over & over 
But never get around to even mentioning or discussing setting the power output level of the blutooth dongle.  

sudo hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 1A 1A FF 4C 00 02 15 [ 92 77 83 0A B2 EB 49 0F A1 DD 7F E3 8C 49 2E DE ] [ 00 00 ] [ 00 00 ] C5 00

The byte just left of the last one is the "reported" TX level that you are transmitting at.  
Which means you're supposed to know (or guess?) what dbm level you are actually transmitting at and set it here to display to the world what your transmitter level is set to so they can range (guess or estimate distance from TX).  
This value does not influence or reflect actual transmit power.   

Please help!!   

Could use any pointers.   

I'm a hardware guy as well so not very experienced in software/programming but I'm willing to try anything to get control of this.  

Been at this for over a week and have some working beacons but no control of transmit power level.  

Am using Trendnet USB dongles which appear to use a Cambridge Chip.  But I'm not exactly sure which chip.  


:~# lsusb
Bus 001 Device 007: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)


root@raspberrypi:~# hciconfig hci0
hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:15:83:EA:0A:B9  ACL MTU: 310:10  SCO MTU: 64:8
        UP RUNNING
        RX bytes:780 acl:0 sco:0 events:50 errors:0
        TX bytes:1110 acl:0 sco:0 commands:50 errors:0














