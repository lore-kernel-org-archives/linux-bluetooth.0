Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000501c562ea$b4c89240$8200a8c0@priveiqvfluhp9>
From: "Pieter De Mil" <mil@pandora.be>
To: <bluez-devel@lists.sourceforge.net>
References: <1117032099.5854.56.camel@baroque.rococosoft.com> <1117036775.30044.238.camel@pegasus> <1117102401.5854.75.camel@baroque.rococosoft.com> <1117103519.12036.35.camel@pegasus> <000801c561e0$191b3830$8300a8c0@priveiqvfluhp9> <1117104537.12036.37.camel@pegasus>
Subject: Re: [Bluez-devel] Output power
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 27 May 2005 20:34:24 +0200

Hello Marcel,

I measured the transmit power level of a Bluetooth-dongle, but it stays 0 in 
a range of 10m.
I'm sure that the link quality raises (from 212 tot 255 on a distance of 
2m), so I thought it was because the transmit power level is stronger.

Do you have experience with the transmit power level indication?

Regards,
Pieter



----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: <bluez-devel@lists.sourceforge.net>
Sent: Thursday, May 26, 2005 12:48 PM
Subject: Re: [Bluez-devel] Output power


> Hi Pieter,
>
>> Is it possible to know the output power a Bluetooth-dongle is using?
>>
>> Because the link quality of a connection raises if we go further away, I
>> wanted to know if you can read the used output power.
>
> you can read the transmit power level with hcitool.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
> online with coworkers and clients while avoiding the high cost of travel 
> and
> communications. There is no equipment to buy and you can meet as often as
> you want. Try it 
> free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
> 




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
