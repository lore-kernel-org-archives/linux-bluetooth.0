Return-Path: <cyrus@holtmann.org>
Message-ID: <502E56DF.3020103@globaledgesoft.com>
Date: Fri, 17 Aug 2012 10:36:15 -0400
From: Ajay KV <ajay.kv@globaledgesoft.com>
MIME-Version: 1.0
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: BLE - multiple connections
References: <5008F67F.5030604@globaledgesoft.com> <CACJA=fUW4a-B-1SGQmPbh+J5YKJ9bVEFbz8ZUezPOD3w0Hmsxw@mail.gmail.com>
In-Reply-To: <CACJA=fUW4a-B-1SGQmPbh+J5YKJ9bVEFbz8ZUezPOD3w0Hmsxw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hi ,
         I am facing some more issues regarding BLE multiple connection 
, which is mentioned below . please  show me the right direction , since 
i got stucked

1:  suppose device A  and B is in connected state (B as initiator  and 
A  as advertising mode)  , so obviously role change happens and A 
switches to slave mode .  meanwhile i wanted to  connect device C  to A 
(C as initiator  and A as advertising mode) , since  A has switched to 
slave mode , it cant able to advertise again ( controller returns  error 
message " command disallowed") .  Even i tried to change the role  
forcefully through hcitool command ,  the result was same.
          My intention is to make  the device A as a server with 
multiple clients.  Currently im not using any of the profiles(ATT , 
GATT) . i want  it to be done using L2CAP sockets

2. Is it possible to change the imtu  of the LE connection other than 
23bits( which is hardcoded in L2cap driver)




On 07/20/2012 10:21 AM, Andre Guedes wrote:
> Hi Ajay,
>
> On Fri, Jul 20, 2012 at 3:11 AM, Ajay KV<ajay.kv@globaledgesoft.com>  wrote:
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

