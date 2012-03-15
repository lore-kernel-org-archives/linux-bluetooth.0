Return-Path: <cyrus@holtmann.org>
Message-ID: <4F61AF8B.3020300@tu-ilmenau.de>
Date: Thu, 15 Mar 2012 09:59:55 +0100
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Encrypting problem while sending data via bluetooth
References: <4F60B259.5040800@tu-ilmenau.de> <1331747344.14217.105.camel@aeonflux>
In-Reply-To: <1331747344.14217.105.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you very much, this helped me!
Now everything looks fine on the screen of the "PC2".

But now i got another problem regarding to this:
I use a third PC with the "BPA500" (it's for bluetooth sniffing).
When i use again the command

PC1: # echo "test" > /dev/rfcomm0

then the BPA500 software says:
"100% Payload/CRC Errors"
and it can't go after "start_encrypt_req" (that's the last Opcode in the 
Link Management Protocol).

That's why i still think i have an encryption problem.
But the manpage only shows me how to ENable the encryption.

So i hope somebody can help me a second time.

Regards,
Steffen


Am 14.03.2012 18:49, schrieb Marcel Holtmann:
> Hi Steffan,
>
>> At first: Sorry for my bad english, it's not my native language. So i
>> wrote my problem in german and english.
>>
>> My problem refers to bluez. I didn't got useful hits on Google, IRC
>> didnt help and the only answer i got in a forum was: "there are not many
>> people who are familiar with that". So i hope you can help me.
>>
>> My problem:
>> After installing the latest bluez, i connected two gentoo-PC's (v2.1.6)
>> via two bluetooth-dongles (BT3.0).
>> PC2:# rfcomm listen 0 1
>> PC1:# rfcomm connect 0<bluetooth-adress>  1
>> This works fine.
>>
>> But now, when i try to send some data:
>> PC2:# cat /dev/rfcomm0
>> PC1:# echo "test">  /dev/rfcomm0
>> it looks like this on the screen of PC2:
>> "^J^J^J^J^^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^test^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J^J"
> it has nothing to do with encryption. These are TTY terminal settings.
> That is why rfcomm tool has a -r (raw TTY mode) switch. And that switch
> is documented in manpage.
>
> Regards
>
> Marcel
>
>


