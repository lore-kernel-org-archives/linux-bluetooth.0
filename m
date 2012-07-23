Return-Path: <cyrus@holtmann.org>
Message-ID: <500CE1BE.2080107@globaledgesoft.com>
Date: Mon, 23 Jul 2012 11:01:42 +0530
From: Ajay KV <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: Andre Guedes <andre.guedes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: BLE - multiple connections
References: <5008F67F.5030604@globaledgesoft.com> <CACJA=fUW4a-B-1SGQmPbh+J5YKJ9bVEFbz8ZUezPOD3w0Hmsxw@mail.gmail.com>
In-Reply-To: <CACJA=fUW4a-B-1SGQmPbh+J5YKJ9bVEFbz8ZUezPOD3w0Hmsxw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
       So that means at  a time i can not able to establish  two LE  
active connections.   One more  task i wanna   try is  to send L2cap  
data packets through L2cap signalling channel (cid 0x05) . But as per my 
knowledge kernel has designed it to work only on cid 0x05



Andre Guedes wrote:
> Hi Ajay,
>
> On Fri, Jul 20, 2012 at 3:11 AM, Ajay KV <ajay.kv@globaledgesoft.com> wrote:
>   
>> Hi all,
>>
>> Since im new to bluetooth low energy technology , i need some guidance from
>> you . Following are the issues that im searching for a solution
>>
>>
>> 1 : Is it possible to establish mutiple LE connection at a time . Im using
>> fedora 13 , linux 2.6.39 version with 4.0 LE supported dongles
>>
>> 2: now im not concentrating on user profiles like GATT and ATT . i wanted to
>> do it using HCI and L2cap connections
>>     
>
> You are able to establish one LE connection at a time. If you have
> more than one device you want to connect to, you can use whitelist.
> Add the devices to whitelist and issue the LE connection command. As
> soon as one of the devices starts advertising, the connection will be
> established.
>
> You can use hcitool to add devices to whitelist and issue LE connection command.
>
> BR,
>
> Andre
>
>   

