Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <mcprabhakaran@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Thu, 5 Aug 2010 13:53:47 +0300
Subject: RE: L2cap Security And Role Switch
Message-ID: <99B09243E1A5DA4898CDD8B700111448096BA3C277@EXMB04.eu.tieto.com>
References: <AANLkTimAktDFG+abbsMpgKfkNtmX3tqqhwXd-OZwgRWj@mail.gmail.com>
	<99B09243E1A5DA4898CDD8B700111448096BA3C23C@EXMB04.eu.tieto.com>
 <AANLkTikLE+ybEx=9SOQNEhc5hptMXmcuHwyX3EY69XYD@mail.gmail.com>
In-Reply-To: <AANLkTikLE+ybEx=9SOQNEhc5hptMXmcuHwyX3EY69XYD@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

>-----Original Message-----
>From: Prabhakaran M.C [mailto:mcprabhakaran@gmail.com] 
>Sent: Thursday, August 05, 2010 12:38 PM
>To: Rymarkiewicz Waldemar
>Cc: linux-bluetooth@vger.kernel.org
>Subject: Re: L2cap Security And Role Switch
>
>Hi Waldek,
>
>On Thu, Aug 5, 2010 at 3:37 PM,  
><Waldemar.Rymarkiewicz@tieto.com> wrote:
>> Hi,
>>
>>>-----Original Message-----
>>>From: linux-bluetooth-owner@vger.kernel.org
>>>[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of 
>>>Prabhakaran M.C
>>>Sent: Wednesday, August 04, 2010 4:09 PM
>>>To: linux-bluetooth@vger.kernel.org
>>>Subject: Reg: L2cap Security And Role Switch
>>>
>>>Hello All,
>>>
>>> Whenever L2cap security is HIGH and remote device does role switch, 
>>>Bluez accepts the Role switch and L2cap disconnects the channel 
>>>because of HIGH security.
>>>
>>> For PAN profile, I would like to keep the L2cap security to HIGH 
>>>since it involves internet browsing but the Widcomm stack 
>always does 
>>>a role switch in PAN connection and Bluez disconnects l2cap channel.
>>>
>>> Can someone please point in specification about the l2cap security 
>>>level and Role switch relation. I tried to find out this but I could 
>>>not get this behavior described in specification. Please 
>provide your 
>>>comments and inputs. Thanks in Advance.
>>>
>>>Thanks,
>>>Prabhakaran.
>>>--
>>
>> Note that HIGH sec level requires encription on the link. 
>Role switch procedure turn off  the encription before it 
>starts switching roles and turn on it again after all. In 2.1 
>spec the controller handles switching off/on encription (pause/resume).
>>
>> Thanks,
>> /Waldek
>
> From the logs, the link was authenticated and encrypted.
>Then Widcomm stack disables the encryption, does a role 
>switch, enables the encryption.
>After role switch bluez kernel disconnects l2cap channel due 
>to HIGH security. I just want to know where this disconnection 
>part is defined in spec. Or Bluez has to just reject the role 
>switch operation instead of disconnection?
>
>--
>Thanks,
>Prabhakaran.

As far as I know it's not defined in the spec. It's simply Bluez design. What I would like to see, the bluez should block outgoing data flow in l2cap for the period of role switch.
It's done in rfcomm this way, I guess (?). 

I agree, in my view the current desing in this use case is not perfect.

Thanks,
/Waldek






