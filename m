Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090715120613.15f4f1ec@symphony>
References: <ea2906620907140856r718f5f76k59a461dfc9dd666c@mail.gmail.com>
	 <ea2906620907150355k23a2dd8cl26f7d916f775e6e3@mail.gmail.com>
	 <20090715120613.15f4f1ec@symphony>
Date: Wed, 15 Jul 2009 12:16:51 +0100
Message-ID: <ea2906620907150416k43589f23m27cf8bbe49caa02a@mail.gmail.com>
Subject: Re: Super fast audio with alsa
From: Daniel Castro <castromd@tcd.ie>
To: James Le Cuirot <chewi@aura-online.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2009/7/15 James Le Cuirot <chewi@aura-online.co.uk>:
> On Wed, 15 Jul 2009 11:55:52 +0100
> Daniel Castro <castromd@tcd.ie> wrote:
>
>> I have a Motorola S9 headset, and I followed the instructions in
>> http://wiki.bluez.org/wiki/HOWTO/AudioDevices to configure it to
>> listen music with Audacious.
>> I also have blueman installed which makes it very easy to pair and
>> connect.
>>
>> It kinda' works, but most of the times the audio goes super fast, it
>> goes through the whole song in seconds, and CPU usage gets very high.
>> When it works, if I leave it then it keeps working, but as soon as I
>> start doing stuff like next song, play/pause it get messy again.
>>
>> Not sure it makes sense?
>> Can someone help? Need more info? Can you point me in the right
>> direction?
>
> I have the Motorola S9 and it works with ALSA for me but I'm not sure
> if I ever tried it through Audacious. Did you try it via a plug device
> or did you use the device directly?

not sure how to answer your question.

so i created the ~/.asoundrc file with:
pcm.S9bluetoothraw {
   type bluetooth
   device 00:0D:FD:23:1A:DE
}
pcm.S9bluetooth {
    type plug
    slave {
        pcm S9bluetoothraw
    }
}

and then from audacious I tell it to use ALSA Output plugin for it's
audio system and set S9bluetooth as the audio device.

>
> Personally I'm waiting for PulseAudio's bluetooth support to get
> completed because I find the ALSA driver a bit unreliable and
> impractical. It sometimes crashes the player and heaven forbid you go
> out of range!

I use pulse audio at my home computer and it just works, no issues.
I created the asundrc file and issue the "pactl load-module
module-alsa-sink device=S9bluetooth" command every time I want to use
it and used pavucontrol the first time to configure it to use shared
outputs.

But on my work computer shared output won't work and if I start
sending audio out to the S9 and then another application (say Pidgin)
sends audio everything crashes. That's why I'm hoping to use just
audacious with ALSA.

Do you see any other solution I could try?

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
