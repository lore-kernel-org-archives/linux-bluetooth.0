Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44F0B3D2.2060102@libero.it>
Date: Sat, 26 Aug 2006 22:49:22 +0200
From: Massimo Piccioni <dafastidio@libero.it>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44EF2AF4.8000307@over-here.org> <44F0AC32.5030405@libero.it>
	<44F0AFEC.2060707@over-here.org>
In-Reply-To: <44F0AFEC.2060707@over-here.org>
Subject: Re: [Bluez-users] Still couldn't get AmbiCom BT2000E card to work...
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

Did you setserial /dev/ttyS1 baud_base 912600 ?
Your dmesg?

I'm using kernel 2.6.16.16.



Eran wrote:
> Hi!
>
>
> First, thanks for the advice.
>
> Second, I've just tried it and got:
>
> [root@hulud /etc/bluetooth]# hciattach /dev/ttyS1 bcsp -s 912600
> BCSP initialization timed out
>
> It doesn't matter if I try it with or without special speeds... it still 
> wouldn't do.
>
>
> Any ideas?
>
>
> Massimo Piccioni wrote:
>
>   
>> Hi,
>>
>> you should use bcsp type, not ericsson.
>> Try:
>>
>> setserial /dev/ttyS1 baud_base 912600
>> hciattach /dev/ttyS1 bcsp -s 912600
>> hciattach hci0 up
>>
>> (where /dev/ttyS1 is the serial dev reported by PCMCIA subsystem)
>> It works fine with my Hamlet HCFBT2, that should be an Ambicom BT2000E 
>> clone (same PCMCIA manfid ...).
>>
>> Ciao
>> Massimo
>>
>>
>>
>> Eran wrote:
>>   
>>     
>>> Hello,
>>>
>>>
>>> I know this is a problem that's have been on this list for more than 
>>> once. However, since I gave it somre more time trying to make the card 
>>> work without success, I would really appreciate it if someone could take 
>>> a look into my description and let me know if he/she has any insights.
>>>
>>>
>>> I have an AmbiCom BT2000E card. The identification:
>>>
>>>
>>>   product info: "AmbiCom,Inc", "BT2000E", "Bluetooth PC/CF Card"
>>>   manfid: 0x022d, 0x2000
>>>
>>>
>>> Inside /etc/pcmcia/bluetooth.conf:
>>>
>>> card "AmbiCom BT2000E Bluetooth Card"
>>>   version "AmbiCom,Inc", "BT2000E"
>>>   manfid 0x022d, 0x2000
>>>   bind "serial_cs"
>>>
>>>
>>> So far, so good.
>>>
>>> hciattach /dev/ttyS1 ericsson
>>>
>>> would return with no errors, however hcid will be unable to take device 
>>> up and return a timeout.
>>>
>>> The MAC address of the device would be all 00's.
>>>
>>>
>>> I knew, from the past, that a kernel patch may help. I found it on this 
>>> list and eventually applied it from:
>>>
>>> http://www.summet.com/x31/socket.html
>>>
>>>
>>> Still, hcid timed out:
>>>
>>> Aug 25 19:55:58 hulud hcid[2954]: Sending read scan enable command 
>>> failed: Connection timed out (110)
>>> Aug 25 19:56:00 hulud hcid[2954]: Can't read address for hci0: 
>>> Connection timed out (110)
>>> Aug 25 19:56:07 hulud hcid[3108]: Can't init device hci0: Connection 
>>> timed out (110)
>>>
>>>
>>> Then I stumbled into this post to the list: 
>>> http://sourceforge.net/mailarchive/message.php?msg_id=11189831
>>>
>>> So I tried setserial /dev/ttyS1 baud_base with various values, low as 
>>> well as high, each time - trying hciattach -s <selected speed> 
>>> /dev/ttyS1 ericsson.
>>> Each and every time I had the same problem - hcid could not bring the 
>>> interface up.
>>> I've also tried appending a speed to hciattach, to no avail.
>>>
>>> I forgot to mention that I'm on a 2.6.17.11 kernel.
>>> Has this card been reported to work for anyone on a 2.6 kernel?
>>>
>>> I will appreciate any help anyone can give.
>>>
>>> Thank you all in advance,
>>> ERan
>>>
>>> -------------------------------------------------------------------------
>>> Using Tomcat but need to do more? Need to support web services, security?
>>> Get stuff done quickly with pre-integrated technology to make your job easier
>>> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
>>> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>>> _______________________________________________
>>> Bluez-users mailing list
>>> Bluez-users@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>
>>>   
>>>     
>>>       
>> -------------------------------------------------------------------------
>> Using Tomcat but need to do more? Need to support web services, security?
>> Get stuff done quickly with pre-integrated technology to make your job easier
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
> Get stuff done quickly with pre-integrated technology to make your job easier
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
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
