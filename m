Return-Path: <cyrus@holtmann.org>
Message-ID: <4A511DD5.5050001@heisenbug.com>
Date: Sun, 05 Jul 2009 22:40:37 +0100
From: Matthew Booth <matthew@heisenbug.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Unexplained start of audio glitches on F11
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I bought a new bluetooth stereo headset last week. After I discovered 
creating /etc/bluetooth/audio.conf with:

[Headset]
HFP=true

I was able to put the headset into A2DP mode and the sound quality was 
excellent. It stayed this way for 2 days. However, I have now started 
getting audio stutters every few seconds, and my logs are full of:

l2cap_recv_acldata: Unexpected continuation frame (len 0)

The appearance of these message appears to be strongly correlated with 
audio skips. The headset continues to operate perfectly when connected 
to my mobile phone. Its battery is fully charged. I experience the 
glitches with direct line of sight to my laptop at a distance of < 2 feet.

Google shows up a number of hits on the above error message, but they're 
related to poor signal strength, which I think I've ruled out.

I'm using pulseaudio, which is running at realtime priority. For good 
measure I have also tried the bluetooth daemon both with and without 
realtime priority. This doesn't appear to be related. Does anybody have 
any more voodoo tricks?

Thanks,

Matt

P.S. I haven't managed to find any documentation for audio.conf 
anywhere. Is there any?
