Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3059.200.183.93.81.1092317623.squirrel@webmail.ic.unicamp.br>
In-Reply-To: <1092298735.28711.3.camel@pegasus>
References: <1025.200.207.51.132.1092265776.squirrel@webmail.ic.unicamp.br>
    <1092298735.28711.3.camel@pegasus>
Subject: Re: [Bluez-users] Problems with bcsp ...
From: ra002890@ic.unicamp.br
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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
Date: Thu, 12 Aug 2004 10:33:43 -0300 (BRT)

Hi, again...

    I have a new question? Bluez utils and libs 2.9 works with kernel
modules from kernel 2.4.24 ?!? If no, how can I patch my kernel?!?
When I tryed it, I killed my kernel and nothing get works again...
    When I was talking about destroying my ftp application, that means,
ftp stops working and card is reseted, but all the system crash and I
have to restart my computer...

    Thanks in advance....


> Hi,
>
>>   I'm trying to make a ftp connection trought my embedded linux device
>> running bluez and my desktop running bluez too, but I receive these
>> messages that destroy my ftp aplication!
>
> what do you mean with destroy my ftp application. Is it still working
> and the Bluetooth connection is still present? Or do you get annoying
> messages from the kernel in the console?
>
>>  Somebody could help me?  The
>> messages are:
>>
>> bcsp_recv: Error in BCSP hdr checksum
>> bcsp_recv: Out-of-order packet arrived, got 0 expected 7
>>
>> ftp> bcsp_recv: Error in BCSP hdr checksum
>> bcsp_recv: Out-of-order packet arrived, got 5 expected 4
>> bcsp_recv: Error in BCSP hdr checksum
>> bcsp_recv: Out-of-order packet arrived, got 5 expected 4
>> bcsp_recv: Out-of-order packet arrived, got 6 expected 4
>> bcsp_recv: Error in BCSP hdr checksum
>> bcsp_recv: Out-of-order packet arrived, got 5 expected 4
>> bcsp_recv: Out-of-order packet arrived, got 6 expected 4
>> bcsp_recv: Error in BCSP hdr checksum
>> bcsp_recv: Out-of-order packet arrived, got 5 expected 4
>> bcsp_recv: Error in BCSP hdr checksum
>> bcsp_recv: Out-of-order packet arrived, got 5 expected 4
>> bcsp_recv: Out-of-order packet arrived, got 7 expected 4
>> bcsp_recv: Error in BCSP hdr checksum
>> bcsp_recv: Out-of-order packet arrived, got 5 expected 4
>> bcsp_recv: Checksum failed: computed 86fc received 0a6b
>> bcsp_recv: Out-of-order packet arrived, got 7 expected 6
>> bcsp_recv: Out-of-order packet arrived, got 0 expected 6
>> bcsp_recv: Out-of-order packet arrived, got 1 expected 6
>
> Actually these messages are only debug messages, but if you got so much
> you should check why they appear.
>
>> How could I strip this messages from bluez if they are only for
>> debugging?
>> Thanks a lot for other doubts that you have solved for me!
>
> Go into the kernel source and replace some BT_ERR with BT_DBG.
>
> Regards
>
> Marcel
>
>





-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
