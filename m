Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EEB0421.4030407@linux.intel.com>
References: <1323853510-5195-1-git-send-email-frederic.danis@linux.intel.com>
	<1323853510-5195-2-git-send-email-frederic.danis@linux.intel.com>
	<CABBYNZKyY40pn-Sm_VSxHLqzbrQ9q-63Sjwmf=kvh4Dy1x9-bw@mail.gmail.com>
	<4EE9D453.6020503@linux.intel.com>
	<CABBYNZL3sCMtSQ4bVetdA25wRmoFZz8BWhsZoRcf4WpcCpi54w@mail.gmail.com>
	<4EEB0421.4030407@linux.intel.com>
Date: Fri, 16 Dec 2011 12:35:10 +0200
Message-ID: <CABBYNZJzczoFhUzvz3wJ5Ssxc8t191UFB7H8ckTygtDXWpNObA@mail.gmail.com>
Subject: Re: [RFC v5 1/8] audio: Move tel drivers to DBus interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Fri, Dec 16, 2011 at 10:41 AM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:
>
> I wrote flowcharts for SCO connections and some AT commands (AT+NREC,
> AT+VGS, ...) for the 2 approaches (side by side). This is available on
> http://pastebin.com/sLBj7kpW

Good work putting this together, probably we should add this to the
documentation, btw this already shows us the latency won't be that
great with this solution.

> As you can see, when passing Media Transport path in NewConnection method,
> the complexity is located during volume management.
> I do not think that we can have synchronization problems if property changed
> signal is sent in all cases.

What do you mean by all cases, it has to be emitted in all cases and
that is the problem, you don't know if the signal is a notification
caused by calling SetProperty or someone else has changed the value.
This became clear in the case of AT+VGS,AT+VGM, if you handle the
signal its going to cause a ping-pong effect, obviously there are ways
to ignore like checking if the value has really changed, but we have
to be careful here since we had this type of problem in harmattan when
the values changed too quickly it creates a loop.

Btw, Im not so sure this currently works because you should only be
able to set something if you have acquired the fd, have you changed
that so the agent can also do it?

> When moving MediaTransport to telephony agent (i.e. oFono), complexity moves
> to SCO connections, passing SCO fd through oFono to PulseAudio.
> This will also imply to remove code from Media Transport, which will
> complicate this set of patches.
> It will also break similarity between A2DP and HSP/HFP (currently both media
> transport code are in BlueZ, breaking that will set one transport in BlueZ,
> the other not).

True, but are you sure the agent wont have to deal directly with the
SCO connection? Afaik there were some AT commands to do the audio
transfer, although for HFP it seems to be directly by
connecting/disconnecting SCO.

-- 
Luiz Augusto von Dentz
