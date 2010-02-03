Return-Path: <cyrus@holtmann.org>
Message-ID: <4B6961A4.5040503@videam.com.br>
Date: Wed, 03 Feb 2010 09:44:36 -0200
From: "Daniel T. Cobra" <dcobra@videam.com.br>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>	<4B2A4B90.1040009@videam.com.br>	<4B2BBF58.4030901@videam.com.br>	<1261173899.4041.96.camel@localhost.localdomain>	<1261176544.4b2c06e0e0eae@www.fastmail.com.br>	<1261177111.4041.99.camel@localhost.localdomain>	<20091223164841.7070e75d@strolchi.home.s3e.de>	<4B325905.6090103@videam.com.br>	<20091229160135.12d85fe6@strolchi.home.s3e.de>	<4B423816.4060405@videam.com.br> <20100105115152.506eb191@strolchi.home.s3e.de>
In-Reply-To: <20100105115152.506eb191@strolchi.home.s3e.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For me, this is going to be a shot in the dark, not being familiar with 
the Bluetooth protocol, but could one of you developers please say if 
any of what follows makes sense?

Comparing the hci dumps from my mouse's reconnection and Stefan's, I am 
suspicious of the first line below:

[...]                        
2010-01-08 00:15:03.136170 < ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2010-01-08 00:15:03.144090 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2010-01-08 00:15:03.144103 < HCI Command: Remote Name Request 
(0x01|0x0019) plen 10
    bdaddr 00:16:38:E2:A5:57 mode 2 clkoffset 0x0000
2010-01-08 00:15:03.146089 > HCI Event: Number of Completed Packets 
(0x13) plen 5           
    handle 42 packets 2
2010-01-08 00:15:03.149092 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11       
    status 0x00 handle 42
    Features: 0xbc 0x02 0x04 0x28 0x08 0x08 0x00 0x00
2010-01-08 00:15:03.155089 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2010-01-08 00:15:03.227093 > HCI Event: Remote Name Req Complete (0x07) 
plen 255
    status 0x00 bdaddr 00:16:38:E2:A5:57 name 'Targus Bluetooth Media 
Mouse for Notebook'
2010-01-08 00:15:07.135253 < ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0042 result 0 status 0
      Connection successful
[...]

In Stefan's hci dump we have:

[...]
2010-01-05 11:36:51.517876 < ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2010-01-05 11:36:51.525808 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0004
        Bi-directional QoS
2010-01-05 11:36:51.525853 < ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0042 result 0 status 0
      Connection successful
[...]

What is happening here? Is bluez making a request to read the device's 
extended features and Stefan's mouse replies while mine doesn't (and the 
4 sec delay I experience is bluez waiting for the reply until it times out)?

If it helps, here's the output of "hcitool info" for my mouse:

Requesting information ...
        BD Address:  00:16:38:A2:C5:56
        Device Name: Targus Bluetooth Media Mouse for Notebook
        LMP Version: 1.1 (0x1) LMP Subversion: 0x100
        Manufacturer: Broadcom Corporation (15)
        Features: 0xbc 0x02 0x04 0x28 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <sniff mode> <RSSI> <power control> <enhanced iscan>
                <interlaced pscan> <AFH cap. slave> <AFH cap. master>

So, am I going in the right direction or am I totally off the mark? I'd 
really appreciate some comment from you guys who know how this works.

Regards,

Daniel

