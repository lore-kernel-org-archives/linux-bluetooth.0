Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <413D69B6.3070107@c-lab.de>
From: Johannes <lintner@c-lab.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] general question on the procedure of BlueZ
References: <413B18F9.6010101@nue.et-inf.uni-siegen.de>	 <1094459425.5145.19.camel@notepaq>	 <413C24C6.1030102@nue.et-inf.uni-siegen.de> <1094462275.5145.22.camel@notepaq> <413C3E38.5040801@c-lab.de> <413C4835.2010203@c-lab.de>
In-Reply-To: <413C4835.2010203@c-lab.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 07 Sep 2004 09:56:38 +0200

Hi,

can you give me a short checklist, which modules I have to start, that 
the communication will have success? Perhaps I have forgotten something.
when I do lsmod, I see the following (relevant) entries:

l2cap                  28416  2
hci_usb                16000  2
bluetooth              52100  6 l2cap,hci_usb
ehci_hcd               32644  0
uhci_hcd               33680  0
usbcore               115040  5 hci_usb,ehci_hcd,uhci_hcd

Do I need more to use  the BT Serial Port Profile on serverside with no 
problems?

Thanks Johannes



Johannes wrote:

> Hi again,
>
> I forgot to say, that the sdp-deamon says "Segmentation fault", when I 
> cancel it, to start an new version of my proxy.
> Hopefully it helps.
>
> Greets Johannes
>
>
> Johannes wrote:
>
>> Hi all,
>>
>> I would have a question on the general procedure, how BlueZ works.
>>
>> My problem is, that the video-file, I will send from Server to mobile 
>> phone, is corrupt. At most, there were transmitted only 9216byte 
>> instead the origin 12913byte. When I let the server sleep for (e.g.)  
>> 60sec. after the video-file (over an OutputStream and 
>> OutputStream.close()) is sent  and before the connection is closed to 
>> the phone, it works. But this is not really a good implementation.
>>
>> So, how does the BlueZ-Stack works. Does it has an puffer, smaller 
>> than 13kbyte or how is the connecton-closing realized? Will be the 
>> connection closed, if such an methode will be called, no matter, 
>> whether there are data in the puffer?
>>
>> Greets Johannes
>>
>>
>> -------------------------------------------------------
>> This SF.Net email is sponsored by BEA Weblogic Workshop
>> FREE Java Enterprise J2EE developer tools!
>> Get your free copy of BEA WebLogic Workshop 8.1 today.
>> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>
>
>



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
