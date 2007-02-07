Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45CA29F7.6070607@gmail.com>
Date: Wed, 07 Feb 2007 11:35:19 -0800
From: Xamindar <junkxamindar@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45CA05A6.5000808@gmail.com>	<20070207102742.gs40wgg8coc4048w@www.webmail4.com>	<45CA1BE6.5040907@pracucci.com>
	<45CA257C.9020904@gmail.com>
	<5b9417770702071127t4dcc7835h2e860b7992e2bb0c@mail.gmail.com>
In-Reply-To: <5b9417770702071127t4dcc7835h2e860b7992e2bb0c@mail.gmail.com>
Subject: Re: [Bluez-users] Is this list dead? Here is my problem...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

John H. wrote:
> First off, are you sure that's the DUN channel?
>   
Well, it looks like it according to the following I think.  But I hope I
am wrong ;)

[code]white-rabbit xamindar # sdptool browse 00:12:56:5A:92:59
Browsing 00:12:56:5A:92:59 ...
Service Name: OBEX Object Push
Service RecHandle: 0x10000
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: OBEX File Transfer
Service RecHandle: 0x10001
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 7
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

Service Name: LG Sync SPP
Service RecHandle: 0x10002
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 16
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Serial Port" (0x1101)
    Version: 0x0100

Service Name: AV Audio Source
Service RecHandle: 0x10003
Service Class ID List:
  "Audio Source" (0x110a)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 25
  "AVDTP" (0x0019)
    uint16: 0x100
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Advanced Audio" (0x110d)
    Version: 0x0100

Service Name: AV Remote Control Target
Service RecHandle: 0x10004
Service Class ID List:
  "AV Remote Target" (0x110c)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x100
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0100

Service Name: Audio Gateway
Service RecHandle: 0x10005
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: Audio Gateway
Service RecHandle: 0x10006
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 4
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0101

Service Name: QC Dial-up Networking
Service RecHandle: 0x10007
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 8
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

white-rabbit xamindar #
[/code]
>
> On 2/7/07, Xamindar <junkxamindar@gmail.com> wrote:
>   
>> Thanks for the replies.  I guess I'll go ahead and ask my question here
>> and then go try the irc channel as well.  On Freenode right?
>>
>> I am trying to get dail up working between my phone and gentoo linux via
>> bluetooth.  I have so far been unsuccessful.
>> I can scan and see my phone but my phone is not able at this time to see
>> my laptop on a scan.
>>
>> [code]
>> white-rabbit xamindar # hciconfig
>> hci0:   Type: USB
>>         BD Address: 00:16:CF:D7:AE:62 ACL MTU: 1017:8 SCO MTU: 64:0
>>         UP RUNNING PSCAN
>>         RX bytes:405 acl:0 sco:0 events:18 errors:0
>>         TX bytes:320 acl:0 sco:0 commands:18 errors:0
>>
>> white-rabbit xamindar # hcitool scan
>> Scanning ...
>>         00:17:5C:00:68:5F       Sidekick
>>         00:12:56:5A:92:59       Jared`s LG CU500
>> white-rabbit xamindar #
>> [/code]
>>
>>
>> I have rfcomm.conf set up to bind to my phone's MAC on channel 8.  I
>> found out that channel 8 is the "QC Dial-up Networking" service on my
>> phone by running "sdptool browse 00:12:56:5a:92:59".
>>
>> [code]
>> white-rabbit xamindar # cat /etc/bluetooth/rfcomm.conf
>> rfcomm0 {
>>         bind yes;
>>         device 00:12:56:5a:92:59;
>>         channel 8;
>>         comment "Jared`s LG CU500";
>> }
>> white-rabbit xamindar # rfcomm
>> rfcomm0: 00:12:56:5A:92:59 channel 8 clean
>> [/code]
>>
>> At this point everything looks good but for some reason I am unable to
>> get any actual communication to work.  I get the following error when
>> testing the rfcomm connection:
>>
>> white-rabbit xamindar # rfcomm connect 0
>> Can't create RFCOMM TTY: Address already in use
>>
>> I seem to not be able to send files to my phone either so it seems that
>> bluetooth on my laptop is completely broken.  I have set up this same
>> thing on a friend's ubuntu installation and got it working in about 15
>> minutes.  I don't get it.
>>
>> Thanks for any help and pointers on this guys.
>>
>>
>> -------------------------------------------------------------------------
>> Using Tomcat but need to do more? Need to support web services, security?
>> Get stuff done quickly with pre-integrated technology to make your job easier.
>> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
>> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>     
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier.
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
