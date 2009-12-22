Return-Path: <cyrus@holtmann.org>
Message-ID: <4B30B6FF.4090300@videam.com.br>
Date: Tue, 22 Dec 2009 10:09:35 -0200
From: "Daniel T. Cobra" <dcobra@videam.com.br>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>  <4B2A4B90.1040009@videam.com.br>  <4B2BBF58.4030901@videam.com.br>  <1261173899.4041.96.camel@localhost.localdomain>  <1261176544.4b2c06e0e0eae@www.fastmail.com.br> <1261177111.4041.99.camel@localhost.localdomain> <1261185699.4b2c2aa37a9c4@www.fastmail.com.br> <4B30B555.5000202@videam.com.br>
In-Reply-To: <4B30B555.5000202@videam.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry, Thunderbird is not handling the line breaks correctly. Here goes 
the hcidump again, hopefully correctly formatted this time.


HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
1261183973.054875 > HCI Event: Connect Request (0x04) plen 10
1261183973.054911 < HCI Command: Accept Connection Request (0x01|0x0009) 
plen 7
1261183973.062868 > HCI Event: Command Status (0x0f) plen 4
1261183973.255871 > HCI Event: Role Change (0x12) plen 8
1261183973.349870 > HCI Event: Connect Complete (0x03) plen 11
1261183973.349892 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
1261183973.351861 > HCI Event: Page Scan Repetition Mode Change (0x20) 
plen 7
1261183973.351870 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0060
1261183973.351932 < ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0060 result 1 status 0
      Connection pending - No futher information available
1261183973.351937 < ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
1261183973.358863 > HCI Event: Number of Completed Packets (0x13) plen 5
1261183973.361860 > HCI Event: Number of Completed Packets (0x13) plen 5
1261183973.363865 > HCI Event: Command Status (0x0f) plen 4
1261183973.363881 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
1261183973.373864 > HCI Event: Read Remote Supported Features (0x0b) 
plen 11
1261183973.375857 > HCI Event: Command Status (0x0f) plen 4
1261183973.443867 > HCI Event: Remote Name Req Complete (0x07) plen 255
1261183977.351019 < ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0060 result 0 status 0
      Connection successful
[...]
