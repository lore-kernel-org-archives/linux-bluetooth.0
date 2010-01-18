Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1263760863.5591.59.camel@localhost.localdomain>
References: <f6c5b8d91001170441m1d0d8755x15147f92b85b477f@mail.gmail.com>
	 <f6c5b8d91001170450n415bf083l5044e193014d8f85@mail.gmail.com>
	 <1263760863.5591.59.camel@localhost.localdomain>
Date: Mon, 18 Jan 2010 11:09:04 +0530
Message-ID: <f6c5b8d91001172139q5f23201fnd2ab2193ebc9a33f@mail.gmail.com>
Subject: Re: A2DP multiple sink support
From: Anil Sasidharan <anilvpr@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

             Thank you so much for the prompt reply. The following are
the conclusions made from your reply.
1. It is possible to support multiple sources and multiple sinks in A2DP co=
ntext
2. There can be 2 separate streams of audio between 2 sets of sources and s=
inks
3. However there might be bandwidth issues and other paging related issues

However I did not get the last point mentioned in your mail i.e. "So
expect some cracks in the audio until both connections are setup
properly".....

Could you please elaborate on this.

Once again, thanks for your time...

Warm Regards,
Anil

On Mon, Jan 18, 2010 at 2:11 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Anil,
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 We are trying to use Bluecore BT module =
(from CSR) for
>> A2DP profile support. In the present use case, our device acts as a
>> A2DP SRC. We are able to stream 44.1kHz stereo audio to a A2DP
>> headset. Now the next use case scenarios that we would like to try out
>> in A2DP context are the following:
>
> look at /etc/bluetooth/audio.conf for settings. You can configure it for
> multiple sources.
>
> The difference between same audio stream and different audio stream is
> not really for bluetoothd itself to make. If it goes to a different
> remote it has to transmit it separately anyway.
>
> If you wanna optimize this, then using GStreamer and some kind of
> mulitplexing magic of the stream could for same stream on different
> targets to reduce the SBC encoding. Otherwise you have to encode the
> stream twice.
>
> This whole thing with one source adapter works, but during inquiry and
> page it is almost impossible for a Bluetooth chip to transmit any data.
> So expect some cracks in the audio until both connections are setup
> properly.
>
> Regards
>
> Marcel
>
>
>
