Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318234286.16562.8.camel@chanten-desktop>
References: <1318234286.16562.8.camel@chanten-desktop>
Date: Mon, 10 Oct 2011 16:59:24 +0300
Message-ID: <CABBYNZJ8F7U5RpNkyv0QTrceK2LZbjitxsWAfnGMPeW7K=ti4g@mail.gmail.com>
Subject: Re: Question about A2DP, Pulseaudio.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On Mon, Oct 10, 2011 at 11:11 AM, Chan-yeol Park
<chanyeol.park@samsung.com> wrote:
> Hello bluetooth developers.
>
> I have a few questions about BlueZ,PulseAudio.
> If there are any plan to develop. I want to discuss how to implement the
> below.
>
> 1. How to handle New Codec(A2DP) between BlueZ and PulseAudio
> As far as I understand puleaduio add_card() working by UUID info.
> however , in case of mpeg and other codec, we can't use it.

You can have whatever you want as capabilities including new codecs,
so yes it is, or intended to be, possible to have your own SEP
capabilities. UUID in that case only defines the profile/role of the
endpoint you are registering, in fact with test/simple-endpoint it is
already possible to register mp3 endpoints.

> I think AudioSink dbus interface should provide codec info that headset
> supports. Based on it, PulseaAudio can know headset support codec info.

We are trying to avoid using device object to expose this info because
it creates a need of device detection on the clients which is not that
trivial to get it right e.g. PA module-bluetooth-discover. Also the
matching capabilities is done by bluetoothd, PA just receives the
transport configuration, the only thing that is not possible right now
is to force one specific endpoint over the others, what you can do
however is to register this specific endpoint using a dedicated
process/connection (e.g. a media player) and then call Audio.Connect
or AudioSink.Connect from that same process/connection, in other words
the sender's endpoint have higher priority than the other endpoint
registered.

Note that PA cannot mix audio encoded so it just a pass through, so it
is kind tricky to detect whether to use an endpoint or not specially
if the application is not streaming only encoded data.

> Bluez audio.conf should have option related to this.
>
> 2. auto_connect.
> Could you explain this purpose?

This is only valid for the only API, when set this indicates to
bluetoothd that if the device is not connected to start connecting to
it, which means PA will be blocked until it connects which IMO is a
bad.

> 4. Is there anyone could explain sco_sink, sco_source? If there are ALSA
> code related to it, could you tell me the link that explain ?

This is used when SCO packets are not routed to HCI, SCO socket
read/writes won't do anything, in that case we need a device to
read/write the data. Apparently some system don't even bother
exporting this audio path to the software stack because it is only
active while on call, if this is your case then it means we cannot
control the audio routing in software and we probably should do
nothing (e.g. set sco_sink/sco_source to "none" and when HFP/HSP is
active set card profile to 'Off'), but note that this type of
configuration has many limitation for instance a system like that
cannot do navigation or voice commands using SCO.

-- 
Luiz Augusto von Dentz
