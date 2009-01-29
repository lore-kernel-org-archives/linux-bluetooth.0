Return-Path: <cyrus@holtmann.org>
Message-Id: <1C7D8DD9-9B10-4185-B036-FDD8EC7CDD20@villagepublishing.com.au>
From: David Thornton <david@villagepublishing.com.au>
To: "X-PELAGE.Patrick" <patrick.pelage@partners.mbda-systems.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <7F2D9B7FC7AF6C47AA68F9CF2094BC7C0346AE3C@rpmsg03.ch.mbda.priv>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: csr_h4.c
Date: Thu, 29 Jan 2009 20:29:47 +1100
References: <7F2D9B7FC7AF6C47AA68F9CF2094BC7C0346AE3C@rpmsg03.ch.mbda.priv>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 29/01/2009, at 7:17 PM, X-PELAGE.Patrick wrote:

> Thanks!
>
> I am reading and try to udestand the csr_h4.c source file.
>
> 1- What is the "varid" argument of "csr_read" and "csr_write"
> functions? is it the HCI packet type, identified in HCI UART  
> TRANSPORT LAYER?

no it is the variable id of a pskey to be set/retrieved.

>
> 2- How to used the csr_h4.c file? that is to say, the main function,  
> if I want to send an HCI packet using H4?

you dont

> 3- What is the meaning of "uin16_t command" in "do_command" function?

send a 16 bit command? (i dont know, i would have to look it up)

> 4- What is the description and specification of the csr_read_h4()  
> input parameters? Same questions for csr_write_h4()? So if I have to  
> send a HCI frame, what I have to do with these functions, according  
> their input parameters?
>
no no no - you have this *all wrong* this source file you've looked  
at, is used for sending BCCMDs that is to say BlueCore commands to a  
Cambridge Silicon Radio BlueCore Bluetooth chip. BCCMDS are NOT HCI,  
but in fact a protocol used to setup/initialise a bluecore chip.

to send HCI packets, you barely even need Bluez, you pretty much  
write() to your chip the raw data packets...

you dont need this to send HCI commands, and definitely not if your bt  
controller is not a CSR chip

Thanks
David

> King regards
>
> Patrick
>
>> -----Message d'origine-----
>> De : Marcel Holtmann [mailto:marcel@holtmann.org]
>> Envoyé : jeudi 29 janvier 2009 09:12
>> À : X-PELAGE.Patrick
>> Objet : Re: csr_h4.c
>>
>> Hi,
>>
>>>
>>> I am reading and try to udestand the csr_h4.c source file.
>>>
>>> 1- What is the "varid" argument of "csr_read" and "csr_write"
>>> functions? is it the HCI packet type, identified in HCI
>> UART TRANSPORT
>>> LAYER?
>>> 2- How to used the csr_h4.c file? that is to say, the main
>> function,
>>> if I want to send an HCI packet using H4?
>>> 3- What is the meaning of "uin16_t command" in "do_command"
>> function?
>>
>> use linux-bluetooth@vger.kernel.org for such questions.
>>
>> Regards
>>
>> Marcel
>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

