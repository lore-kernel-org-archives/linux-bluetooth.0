Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4214EB3E.3070502@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: possible to use phone itself as headset?
References: <20050217040417.615C2133CC@sc8-sf-spam2.sourceforge.net> <42148DDB.2010002@gmx.net> <cv2nd1$gu1$1@sea.gmane.org>
In-Reply-To: <cv2nd1$gu1$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 17 Feb 2005 12:06:38 -0700

Hi

There is a profile (I forget the name) that allows for the phone to use 
a sort of bluetooth access point for its connection to the phone 
network. No one implements it however. And it is voice-quality mono.

I don't think any handset will do what you want out of the box, but if 
you're good at programming inside symbian maybe you could make one of 
the symbian phones do it. I suppose that's beyond the level of effort 
you were hoping for.

Brad

soraberri wrote:
> Hi Marcel,
> Maybe I haven't explain myself... I don't know what you have found at 
> the link Lars gave, I only see that there is a implementation of the 
> headset profile in BlueZ (so you could speak to the laptop and the 
> laptop would make a bluetooth link to the phone, which is connected to 
> the GSM network)... but what we need in order to use a phone as a 
> headset is not found in this link, at least I can't find it! :c)
> 
> 
> 
> Marcel Partap wrote:
> 
>>> From: Lars Grunewaldt <lgw@dark-reality.de>
>>> Bluetooth-alsa is about supporting the BT headset profile, and the phone
>>> won't implement it. Phones support the handsfree profile, you can find a
>>> link to two projects on our homepage that might be usefull, i.e.
>>> http://www.soft.uni-linz.ac.at/_wiki/tiki-index.php?page=ProjectBluezHandsfree 
>>>
>>
>>
>> you're right, thx. And the link has this! It needs CVS sdp and stuff, 
>> and I have no clue how to use it, but it seems to work.
>>
>>
>> From: soraberri <421246@posta.unizar.es>
>>  > As far as I know, we would only need to implement headset profile in
>>  > the phone side. I think this shouldn't be impossible, after all
>>  > SymbianOS has public API for RFCOMM, L2CAP and SDP socket connection,
>> Nope, somebody has done it already. Look at the link Lars gave.
>>  > and I think it is also possible to create SCO connections in a socket
>>  > basis... So, what is the problem then? Even in the assumption that we
>>  > managed to develop the headset profile I think NONE actual mobile
>>  > phone would let us hook the audio streaming from/to the
>>  > microphone/speaker to/into a SCO channel. It is physically posible, of
>>  > course because the AudioGateway profile embedded in the phone just do
>>  > it, but I'm afraid we have no public interface to get this
>>  > functionality (I'm not Symbian developer, let's hope somebody tell
>>  > this is not true!).
>> IIUC, not true. C link.
>>
>>  > Maybe phone manufacturers are too dependent on the Telephony Companies
>>  > requirements to allow this nice functionality which would lead us
>>  > without doubt to make VoIP calls from the phone if it detects the
>>  > presence of the appropiate service running in our home's box.
>> Guess what. Think about it. Doom - for them. Goodbye to insane 
>> telecommunication costs. KILLER linux feature. Wooooooooow, awesome ;==)
>> For that, please someone who can actually code talk to them, merge it 
>> into bluez and so. As said, I have absolutely no clue how to just use 
>> it, so I won't be even taking the time to compile it. I'll wait till 
>> it's covered by the bluez-utils ebuild + deps. :==P
>>
>> Oh yeah, stop.. all the euphory - but still the audio stream needs to 
>> be grabbed without the /phone/ actually opening a connection. Hope 
>> this is hackable.
>> so long guys.
>>
>>
>> -------------------------------------------------------
>> SF email is sponsored by - The IT Product Guide
>> Read honest & candid reviews on hundreds of IT Products from real users.
>> Discover which products truly live up to the hype. Start reading now.
>> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
