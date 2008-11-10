Return-Path: <cyrus@holtmann.org>
Date: Sun, 9 Nov 2008 17:08:50 -0800 (PST)
From: Damon Hastings <damonhastings@yahoo.com>
Subject: Re: Possible to send audio to multiple bluetooth headsets at once?
To: BlueZ development <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <148506.1963.qm@web81801.mail.mud.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A perhaps more important question: how many bluetooth headsets can be actively receiving audio in the same 200 square foot space at the same time?

If the Bluetooth band simply can't handle 20 headsets streaming all at once, then I'm wasting my (and your) time trying to get multiple headsets to work in the first place!  I understand that Bluetooth 2.0 (am I using 2.0?) provides 1 to 2 Mbps of bandwidth, which should be enough to fit 8 to 16 uncompressed 8000Hz 16-bit mono streams, ignoring data redundancy, collision retransmits, and other overhead -- and 8 to 16 isn't good enough.  I can use multiple dongles on multiple computers, but they'd just interfere.

Let me break this down into sub-topics...  Don't spend too much time on each if you can't answer it off the top of your head -- the most important question is at the end!

1) I don't need good (or even decent) quality -- how do I configure for lowest bandwidth usage?  My latency requirements are also fairly relaxed -- 100ms or less should be fine.

2) I'll be sending audio *to* the headsets only; I'd like to make sure no bandwidth is wasted trying to read audio *from* them.

3) Each audio stream will be absolute digital silence (i.e. a sequence of zeroes) 90% of the time, with short bursts of speech the other 10%.  Can you tell me whether the relevant protocol/profile/whatever is smart enough to compress all those zeroes away before sending them over the air?  Or is there a config change I can make to enable such compression?  I don't think I can afford to just disconnect over the silences and reconnect on speech; the reconnect delay would probably be too long.

And now, the big question:  Given all of the above optimizations, do you think Bluetooth could fit 20 headsets?  40?  100?  I'm not going to hold you to any estimate, of course -- but I just want to know whether now is the time to forget about bluetooth altogether.  If so, then maybe I could look into WiFi headsets or something...?  I'll use wired headsets if necessary, though it would make life much more difficult for the wearers, who need at least some mobility.  Maybe I can find desktop speakers which are capable of outputting highly directional sound in a tight sound cone.  Basically, I plan to have 20 workers in a 200 sq ft space who each need their own isolated audio at their own workstation.  Each worker leaves his workstation very frequently but very briefly to perform other tasks, and he only needs the audio while he is at his workstation.

Thanks again!  :-)

Damon Hastings


--- On Sun, 11/9/08, Johan Hedberg <johan.hedberg@gmail.com> wrote:

> From: Johan Hedberg <johan.hedberg@gmail.com>
> Subject: Re: Possible to send audio to multiple bluetooth headsets at
once?
> To: "BlueZ development" <linux-bluetooth@vger.kernel.org>
> Date: Sunday, November 9, 2008, 1:35 AM
> Hi Damon,
> 
> In theory what you're trying to do should be possible,
> though you  
> might run into bandwidth issues (and there's not much
> BlueZ can do to  
> help with that). However, you do need some configuration
> file changes  
> since the defaults are for one headset only. If you're
> trying to use  
> HSP/HFP add MaxConnections=2 to the [Headset] section in
> /etc/ 
> bluetooth/audio.conf. If you're trying to use A2DP add
> SBCSources=2 to  
> the [A2DP] section of the same file. You might also want to
> experiment  
> with forcing BlueZ to use the profile you want in the case
> of multi- 
> profile headsets. For HSP/HFP you need profile=voice in
> your .asoundrc  
> entries and for A2DP you need profile=hifi.
> 
> Johan
> 
> --
> To unsubscribe from this list: send the line
> "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html



      
