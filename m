Return-Path: <cyrus@holtmann.org>
Message-ID: <4C40F0A7.3090902@gmail.com>
Date: Fri, 16 Jul 2010 19:52:07 -0400
From: Tim Bennett <tjbenne@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Secure Simple Pairing Mode - Setting NoInputNoOutput mode
References: <4C40AF95.4080505@gmail.com> <20100716233715.GA24138@jh-x301>
In-Reply-To: <20100716233715.GA24138@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan
On 16-Jul-10 7:37 PM, Johan Hedberg wrote:
> Hi Tim,
>
> On Fri, Jul 16, 2010, Tim Bennett wrote:
>    
>> Is there a method (programmatic or hciconfig - type) to change the Mode of a
>> BT v2.1 dongle to require NoInputNoOutput/JustWorks pairing?
>>
>> I want to make my box (running linux 2.6.30.2 kernel on an arm processor
>> with Bluez 4.67 and a Broadcom v2.1 dongle) pair with another device in the
>> "JustWorks" (NoInputNoOutput) mode.
>>
>> 1. The SSP mode seems to default to "Numeric Comparison" mode.  I am trying
>> to find out how to switch to "Just Works" (NoInputNoOutput mode)
>> Can someone point me to a command or code that would switch my adapter into
>> the NoInputNoOutput mode?
>> Is it something I can configure through hciconfig or through a dbus command?
>>
>>   2. The man page for hciconfig has the command hciconfig hciX sspmode
>> [mode].  Is [mode] only valid for 0 or 1?
>>
>> In looking in hciconfig.c, at the
>> hci_read_simple_pairing_mode/hci_write_simple_pairing_mode functions, there
>> is no clear indication as to what the accepted values are for [mode}
>>      
> You're looking a bit in the wrong place. What you want is an agent that
> registers "NoInputNoOutput" as its IO capability. You could e.g.
> experiment by using test/simple-agent. Find the two places in it that
> say "DisplayYesNo" and change them to "NoInputNoOutput". Then you can
> use that script as a "just works" pairing initator or acceptor.
>
> Johan
>    
Thank you for the kind and quick response and the helpful hint. I shall 
do as suggested!

Tim
