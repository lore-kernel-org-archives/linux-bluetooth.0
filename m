Return-Path: <James@superbug.demon.co.uk>
Message-ID: <404274D0.7040005@superbug.demon.co.uk>
Date: Sun, 29 Feb 2004 23:25:04 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO. Some ideas.
References: <40421024.20602@superbug.demon.co.uk>	 <1078074126.1942.31.camel@pegasus> <40423226.8050007@superbug.demon.co.uk>	 <1078087109.1942.54.camel@pegasus> <4042575B.20305@superbug.demon.co.uk> <1078092105.1942.93.camel@pegasus>
In-Reply-To: <1078092105.1942.93.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
>>Some audio applications need this "pointer" feature, which is why alsa 
>>provides it.
>>An example of this is playback of DVDs.
>>Video output needs to be kept closely in sync with the audio, and this 
>>"pointer" and "trigger" feature allow the application to closely control 
>>exactly when the sound plays. "trigger" handles the "start the sound 
>>exactly now", and "pointer" provides feedback, saying that "sound sample 
>>xyz is currently playing, so display video frame xyz now". "pointer" 
>>also provides for "audio is playing 0.25 seconds ahead of video, adjust 
>>it to match".
>>These are not hardware specific features, all sound hardware has these 
>>features, including bluetooth audio, and we just need some way for 
>>higher layers to get access to the values.
>>Another example is Voice over IP. If using a headset, one might want to 
>>use it to make VoIP calls over the internet. One of the most important 
>>issues with VoIP is latency. The lower the latency, the more natural the 
>>conversation will be. Long latency produces conversations will long 
>>breaks in between and possible delayed echos. It is a lot more difficult 
>>to have a natually smooth conversation if the latency is high. These 
>>"pointer" and "trigger" and "period_time_elapsed" functions allow for 
>>applications to program minimum latancy that any particular hardware can 
>>handle.
> 
> 
> You shouldn't think so much about it. Try to implement the ALSA driver
> without it and we see how it goes.
> 
> Regards
> 
> Marcel
> 

So you want me to implement it in such a way that would add 10-20ms of 
latency and have no audio/video syncronisation features?
We might as well stay with the current alsa over network sockets which 
is what we have now.

Cheers
James
