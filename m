Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1101059050.7250.39.camel@pegasus>
References: <418DB442.2050801@uen.org> <41925793.3050404@xmission.com>
	 <1100113055.25879.73.camel@pegasus> <419543B3.8050601@xmission.com>
	 <1100306337.7349.29.camel@pegasus> <41957BC1.507@xmission.com>
	 <1100351199.7349.50.camel@pegasus> <41970F25.4020902@xmission.com>
	 <1100446172.21403.16.camel@pegasus> <419B7292.9080706@xmission.com>
	 <cbf0aec9041118052714481128@mail.gmail.com>
	 <20041121064655.0b04dd8a.henryk@ploetzli.ch>
	 <1101059050.7250.39.camel@pegasus>
Content-Type: text/plain
Message-Id: <1101093515.7250.97.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 22 Nov 2004 04:18:35 +0100

Hi Henryk,

> > > I have problems synthesizing the PCM audio samples but can parse all
> > > of the example SBC streams just fine.
> > 
> > Ok, catched it. I reimplemented the SBC analyzer and synthesizer  in
> > Octave which is easier to play around with and found that my C
> > synthesizer was working fine - on wrong subband samples. The bitstream
> > unpacker had a bug which made it shift the incoming bits once to often. 
> > 
> > So sbc-test from the CVS is now able to decode 4 and 8 subband mono SBC
> > files (there's something wrong with stereo, I'll look into that
> > shortly). 
> 
> I was only able to decode 01, 03, 07 and 09. All other mono test files
> are failing. However good work, because these four sound perfect.

I tested again all example files before you moved the bits array
calculation into an own function. All of them sounded good.

With the latest code you still overwrite the stack at some point,
because the pcm_sample[][] array is only 2x128 and you return 2x256
samples from sbc_synthesize_audio() function.

I also started to write a simple SBC play program using the libao. It
works actually quite good linking your sbc.o file, but unfortunately
with 2 channel files the left channel is silent.

We should start a new thread and discuss a SBC library.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
