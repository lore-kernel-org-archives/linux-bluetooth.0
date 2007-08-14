Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100708131939k32d34dc7u9961aecc0c0cf624@mail.gmail.com>
Date: Mon, 13 Aug 2007 23:39:43 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1187027354.6262.59.camel@ubuntu.mpl.access-company.com>
MIME-Version: 1.0
References: <46BD85F4.1090400@free.fr> <1186855275.6698.10.camel@violet>
	<1186999158.6262.10.camel@ubuntu.mpl.access-company.com>
	<1186999538.6698.141.camel@violet> <46C07EAC.8060407@free.fr>
	<1187024669.6698.214.camel@violet>
	<1187027354.6262.59.camel@ubuntu.mpl.access-company.com>
Subject: Re: [Bluez-devel] An explanation of a2dpd weird behaviour on high
	resolution timers enabled kernels
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I took some time investigating this issue, it really seems to
be a out of sync problem. As marcel said we send data too
fast and in some headset this cause the stream playback
to sound a lot faster than it should. As I dont have one of
those headset with this problem I emulate mine using a
computer + a2recv, and for my surprise any of the dongle
 I tried to plugged had the same issue, so it seems it is not
direct connected to broadcom chips, but it probably tied
 with the way the sink is implemented.

The problem occurs because a2recv has no buffer after
decode the packet, it simple sent to dsp in the frequency
it receives from bluetooth, and this dont seem to be the way
we expected a sink to work. I also run tests inserting a
usleep(10000) after sending a packet, this helped a lot in the
way I got almost perfect audio in the emulated sink. But still
there it sounds noisy if I plug a good wire headset on sink,
this is probably because the frames are not all in the same
rate, we dont send frame per frame so the sleep only helps to
synchronize some frames  between the packets but not the
ones that are within the packet.

Im not sure if this can be solved with a flow control on L2CAP,
and Im also not sure if the headset that do work use it, well
I guess they couldn't because we dont support that too, right?
This leads me to believe headsets should have its own decoded
buffer that should be consumed in the proper audio rate not
the stream rate as a2recv seems to assume.

We can of course send frame per frame in the exact frame rate
we want the audio to be played, but we should considerer this
problems when acting as a sink.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
