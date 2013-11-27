Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Nov 2013 11:06:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Crasher during remote initiated pairing
Message-ID: <20131127090605.GA28918@x220.p-661hnu-f1>
References: <1385398409.3423.25.camel@nuvo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385398409.3423.25.camel@nuvo>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Nov 25, 2013, Bastien Nocera wrote:
> I have a particularly stubborn device, the TomTom Go Remote that tries
> to connect to my computer as soon as it's turned on, even when I've
> removed the pairing on the computer side.
> 
> With GNOME's Bluetooth wizard open, I receive an out of the blue request
> for pairing, I pass it the expected PIN code (0000), I then find that
> the wizard doesn't work as I expected and turn it off. bluetoothd
> promptly crashes:
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007f0cf9ffde24 in agent_auth_cb (agent=<optimized out>, derr=0x7fffab655920, user_data=0x7f0cfb2e0020) at src/adapter.c:4370
> 4370		struct service_auth *auth = adapter->auths->head->data;
> (gdb) p adapter
> $1 = (struct btd_adapter *) 0x7f0cfb2e0020
> (gdb) p adapter->auths
> $2 = (GQueue *) 0x7f0cfb2d1240
> (gdb) p adapter->auths->head
> $3 = 0x0
> 
> Some missing NULL checks?
> 
> I imagine that this should be reproduceable using simple-agent and
> making it exit after replying to RequestPinCode.

The agent_auth_cb is actually not used for pairing but for
authorization, so whether it's RequestPinCode or RequestPasskey wont
matter for the above backtrace. Anyway, I was never able to reproduce
the exact same issue as you had, but I did find two places needing some
extra checks (one in adapter.c and another in agent.c). So it'd be good
if you could give the latest git a spin and see if you can still
reproduce the crash.

Johan
