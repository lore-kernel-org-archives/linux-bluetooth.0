Return-Path: <lintner@c-lab.de>
Message-ID: <41345906.6070306@c-lab.de>
Date: Tue, 31 Aug 2004 12:55:02 +0200
From: Johannes <lintner@c-lab.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with InputStream and OutputStream
References: <1324.1093866265@www49.gmx.net>	 <1093867195.5620.16.camel@pegasus>  <41331EBB.9000606@gmx.de>	 <1093869614.5620.24.camel@pegasus>  <41342BF8.2040703@c-lab.de> <1093947830.5620.114.camel@pegasus>
In-Reply-To: <1093947830.5620.114.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

HI,


Marcel Holtmann wrote:

>Hi Johannes,
>
>  
>
>>the BTMidServ runs on the Linux side as the server.
>>    
>>
>
>I thought you use some C code for the server. I am not a Java expert and
>actually I don't have fun reading Java source code.
>
>  
>
>>    gotland:~# hcitool info 00:02:72:80:B1:6F
>>    Device is not available or not connected.
>>    
>>
>
>You must fill in the BD_ADDR of your phone.
>  
>
thx, sure, the manual says remote device. my fault:
    gotland:~# hcitool info 00:01:E3:29:38:D8
    Requesting information ...
        BD Address:  00:01:E3:29:38:D8
        Device Name: Siemens SX1
        LMP Version: 1.1 (0x1) LMP Subversion: 0x55b
        Manufacturer: Infineon Technologies AG (9)
        Features: 0xef 0xfa 0x19 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <role switch> <hold mode> <sniff mode> <RSSI> <SCO link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                <transparent SCO>


>Regards
>
>Marcel
>

I have got an success. I let sleep() the connection for 2.5seconds, and 
I got nearly the complete string, only the last character was empty. I 
will try to hold the connection a little longer open.  Then I will tell you.

THX   John!
