Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Bluetooth connect to Google Home?
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <afdf0587-5e02-4df0-2ea8-17b137454576@mathcs.emory.edu>
 <CABBYNZ+CXHBcaK-uLwG3fWMycYJsb+-+Ec81ZrPfnRHMi3=Uqg@mail.gmail.com>
From: Ken Mandelberg <km@mathcs.emory.edu>
Message-ID: <58e8b487-7bb3-8710-7a09-e9a0e7854396@mathcs.emory.edu>
Date: Sun, 21 Jan 2018 19:18:41 -0500
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+CXHBcaK-uLwG3fWMycYJsb+-+Ec81ZrPfnRHMi3=Uqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

First of all I did go and use btmon to get a complete trace. Its a bit 
long so here is a url for it

     http://www.mathcs.emory.edu/~km/bt.out

For this trace, I deleted the google device from /var/lib/bluetooth and 
the cache, and restarted
bluetooth, so I would have it from the start. bluetoothctl turned scan 
on long enough to see the
device and then I did a pair that ended with

Failed to pair: org.bluez.Error.AuthenticationCanceled

While this trace is the typical failure, one time (out of many tries) it 
actually did pair, connect,
and played sound. Once I did a disconnect, it still showed paired, but 
then connect would fail.

These speakers work perfectly via bluetooth from android.



Luiz Augusto von Dentz wrote on 01/19/2018 01:47 PM:
> Hi Ken,
>
> On Fri, Jan 19, 2018 at 4:09 PM, Ken Mandelberg <km@mathcs.emory.edu> wrote:
>> The Google Home speakers offer bluetooth connectivity which works with
>> Android phones and tablets. I don't have IOS devices but I presume they
>> work too.
>>
>> When I try to pair with bluez based bluetooth on Linux on my very first try
>> it wants a pin. I try one of the generic pins and it fails. Subsequent
>> pairing attempts fail but never ask for a PIN again.
> Weird that would mean it is using legacy pairing which is very weird
> considering most systems should already have 4.0 controllers, anyway
> we could tell more from the HCI trace if you have it. (you can use
> either btmon, hcidump to collect that.)
>
>> After a long timeout bluetoothctl shows
>>
>> Failed to pair: org.bluez.Error.AuthenticationCanceled
>>
>> Info shows
>>
>> Device E4:F0:42:60:85:DF
>>          Name: Office speaker
>>          Alias: Office speaker
>>          Class: 0x5e0400
>>          Icon: audio-card
>>          Paired: no
>>          Trusted: no
>>          Blocked: no
>>          Connected: no
>>          LegacyPairing: no
>>          UUID: Audio Sink
>> (0000110b-0000-1000-8000-00805f9b34fb)
> At least A2DP should work with the above UUID.
>
>>          UUID: A/V Remote Control Target
>> (0000110c-0000-1000-8000-00805f9b34fb)
>>          UUID: A/V Remote Control
>> (0000110e-0000-1000-8000-00805f9b34fb)
>>          UUID: PnP Information
>> (00001200-0000-1000-8000-00805f9b34fb)
>>          UUID: Google
>> (0000fe9f-0000-1000-8000-00805f9b34fb)
>>
>> Any way to workaround?
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

