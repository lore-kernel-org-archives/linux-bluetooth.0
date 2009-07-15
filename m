Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090715124452.68d53e4e@symphony>
References: <ea2906620907140856r718f5f76k59a461dfc9dd666c@mail.gmail.com>
	 <ea2906620907150355k23a2dd8cl26f7d916f775e6e3@mail.gmail.com>
	 <20090715120613.15f4f1ec@symphony>
	 <ea2906620907150416k43589f23m27cf8bbe49caa02a@mail.gmail.com>
	 <20090715124452.68d53e4e@symphony>
Date: Wed, 15 Jul 2009 12:56:33 +0100
Message-ID: <ea2906620907150456q61aa8c7ah449d175d8bca5592@mail.gmail.com>
Subject: Re: Super fast audio with alsa
From: Daniel Castro <castromd@tcd.ie>
To: James Le Cuirot <chewi@aura-online.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2009/7/15 James Le Cuirot <chewi@aura-online.co.uk>:
> On Wed, 15 Jul 2009 12:16:51 +0100
> Daniel Castro <castromd@tcd.ie> wrote:
>
>> 2009/7/15 James Le Cuirot <chewi@aura-online.co.uk>:
>> > I have the Motorola S9 and it works with ALSA for me but I'm not
>> > sure if I ever tried it through Audacious. Did you try it via a
>> > plug device or did you use the device directly?
>>
>> not sure how to answer your question.
>>
>> so i created the ~/.asoundrc file with:
>> pcm.S9bluetoothraw {
>>    type bluetooth
>>    device 00:0D:FD:23:1A:DE
>> }
>> pcm.S9bluetooth {
>>     type plug
>>     slave {
>>         pcm S9bluetoothraw
>>     }
>> }
>>
>> and then from audacious I tell it to use ALSA Output plugin for it's
>> audio system and set S9bluetooth as the audio device.
>
> That is what I meant. Should work. I'm no expert so I can't suggest
me either :(
> much more than trying something other than Audacious but I'm guessing
> you have already.
yes i have... pretty much same thing happens...

I just tried:
~$ sudo alsa reload

hit play in audacious and it's working... maybe this is a workaround
or maybe it was just coincidence... i'll monitor and see.
>
> James
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>



-- 
________________________

Daniel Castro, M.Sc.
+353 083-318-2058
dancasmo@gmail.com
castromd@tcd.ie
________________________
