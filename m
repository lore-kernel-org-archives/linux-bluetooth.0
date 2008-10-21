Return-Path: <cyrus@holtmann.org>
Message-ID: <48FE57C7.4050507@dtsp.co.nz>
Date: Wed, 22 Oct 2008 11:29:27 +1300
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Richi Plana <richip@richip.dhs.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez / Bluetooth Docs
References: <1224550188.21866.9.camel@richip.dhs.org> <48FE519F.9070409@richip.dhs.org>
In-Reply-To: <48FE519F.9070409@richip.dhs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Richi Plana wrote:
>> Working under the assumption that one can't bind two BT headsets to one
>> BT adapter (device or whatever the correct term is), I've made available
>> two BT adapters on my notebook (one USB dongle) and am now trying to
>> pair one headset with one device. The problem is I've no idea how this
>> works outside of the automagic that Fedora does (using hcid).

Not that I've tried it, but I expect that this assumption is wrong - you 
can talk to multiple bluetooth devices with one transceiver, and I don't 
see any reason to expect headsets to be a special case?

For access via ALSA I have, for my one headset:
pcm.bluetooth {
        type bluetooth
        device "00:13:A9:C2:43:41"
}


You might have some success putting two such entries into your .asoundrc 
(you might have a pcm.bluetooth1 and pcm.bluetooth2, and obviously you 
need to enter the two device addresses for your headsets).  I do this 
under BlueZ 4.x, so it might be different in your case.

Then this kind of thing should work: mplayer -ao alsa:device=bluetooth1 
play.mp3

