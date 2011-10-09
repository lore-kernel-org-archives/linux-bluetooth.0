Return-Path: <cyrus@holtmann.org>
Message-ID: <4E91AC76.2000101@optimaster.eu>
Date: Sun, 09 Oct 2011 16:15:18 +0200
From: Krisztian Kocsis <krisztian.kocsis@optimaster.eu>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Fwd: Re: [pulseaudio-discuss] Bluetooth Headset Problem Update
References: <1318138170.6357.20.camel@jarl>
In-Reply-To: <1318138170.6357.20.camel@jarl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



-------- Original Message --------
Subject: 	Re: [pulseaudio-discuss] Bluetooth Headset Problem Update
Date: 	Sun, 09 Oct 2011 08:29:28 +0300
From: 	Tanu Kaskinen <tanuk@iki.fi>
Reply-To: 	General PulseAudio Discussion 
<pulseaudio-discuss@lists.freedesktop.org>
To: 	General PulseAudio Discussion 
<pulseaudio-discuss@lists.freedesktop.org>



On Sat, 2011-10-08 at 22:09 +0200, krisztian.kocsis@optimaster.eu wrote:
>  Hi!
>
>  The BIG difference when the output is oss and bluetooth is when
>  bluetooth output is used with paplay, then paplay never receives a
>  PA_COMMAND_REQUEST op, i don't know why.
>  In the background PA dispatches PA_COMMAND_GET_PLAYBACK_LATENCY
>  messages continuously (as seen with OSS output).
>
>  The playback_stream_request_bytes() function is only called from
>  handle_seek() and never called from sink_input_pop_cb() (which function
>  is also never called)!
>
>  The call chain is not so trivial, please help me how to find the point
>  where sink_input_pop_cb() should be called and why PA cannot reach this
>  point.

sink_input_pop_cb() is called when the sink requests audio from the sink
input. If the sink isn't suspended and the sink input isn't corked
(which they aren't in this case), the pop() callback should be called
very frequently. If it's not called, it means that the bluetooth sink is
not requesting any audio. So the problem is in bluez or
module-bluetooth-device. The pulseaudio log doesn't contain any error
messages, so I don't have any more clues for what might be wrong. (I
didn't spot any errors in the bluez log either, but I'm not experienced
in interpreting the bluez logs.)

-- 
Tanu


_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

