Return-Path: <chrisspen@gmail.com>
Date: Sat, 16 Sep 2006 14:08:27 -0400
From: Chris Spencer <chrisspen@gmail.com>
Subject: Re: Celluon Laserkey Bluetooth Keyboard
In-reply-to: <1158397207.6839.1.camel@localhost>
To: bluez-devel@lists.sourceforge.net, marcel@holtmann.org
Message-id: <450C3D9B.5040506@gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <beb7688e0609150702x738ad4d8re64815d12f457a76@mail.gmail.com>
	<1158329592.5233.32.camel@localhost>  <450B3B01.2060801@gmail.com>
 <1158397207.6839.1.camel@localhost>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Chris,
> 
>>>> The last part is interesting, because the three 255s repeat for every
>>>> keypress and mouse movement made with the device.
>>> this is not a HID compatible keyboard and needs an extra driver to
>>> function properly. Please run "sdptool records --raw <bdaddr>" to
>>> retrieve the SDP records for this device.
>> Sure, here's the output:
>>
>> $ sdptool records --raw 00:0B:24:40:C7:83
>> Sequence
>>          Attribute 0x0000 - ServiceRecordHandle
>>                  UINT32 0x00010000
>>          Attribute 0x0001 - ServiceClassIDList
>>                  Sequence
>>                          UUID16 0x1101 - SerialPort
>>          Attribute 0x0004 - ProtocolDescriptorList
>>                  Sequence
>>                          Sequence
>>                                  UUID16 0x0100 - L2CAP
>>                          Sequence
>>                                  UUID16 0x0003 - RFCOMM
>>                                  UINT8 0x01
>>          Attribute 0x0100
>>                  String Serial Port
>>
>> Please let me know if you need any other information, or if there's 
>> anything I can do to help get this working.
> 
> this looks like the third of these. Please also run "hcitool inq" and
> "hcitool info ..." (as root) for this.

I may have already pasted those outputs in my original email, but here 
they are again:

[root]# hcitool inq
Inquiring ...
         00:0B:24:40:C7:83       clock offset: 0x410a    class: 0x400210
[root]# hcitool info 00:0B:24:40:C7:83
Requesting information ...
         BD Address:  00:0B:24:40:C7:83
         Device Name: CL800BT
         LMP Version: 1.1 (0x1) LMP Subversion: 0x291
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                 <3-slot packets> <5-slot packets> <encryption> <slot 
offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <RSSI> <channel quality> <SCO link> <HV2 
packets>
                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging 
scheme>
                 <power control> <transparent SCO>

Regards,
Chris
