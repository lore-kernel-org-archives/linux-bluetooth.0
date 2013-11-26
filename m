Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Nov 2013 15:43:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Subject: Re: Crasher during remote initiated pairing
Message-ID: <20131126134308.GA20389@x220.p-661hnu-f1>
References: <1385398409.3423.25.camel@nuvo>
 <20131126133427.GA19614@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131126133427.GA19614@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Nov 26, 2013, Johan Hedberg wrote:
> On Mon, Nov 25, 2013, Bastien Nocera wrote:
> > Heya,
> > 
> > I have a particularly stubborn device, the TomTom Go Remote that tries
> > to connect to my computer as soon as it's turned on, even when I've
> > removed the pairing on the computer side.
> > 
> > With GNOME's Bluetooth wizard open, I receive an out of the blue request
> > for pairing, I pass it the expected PIN code (0000), I then find that
> > the wizard doesn't work as I expected and turn it off. bluetoothd
> > promptly crashes:
> > 
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x00007f0cf9ffde24 in agent_auth_cb (agent=<optimized out>, derr=0x7fffab655920, user_data=0x7f0cfb2e0020) at src/adapter.c:4370
> > 4370		struct service_auth *auth = adapter->auths->head->data;
> > (gdb) p adapter
> > $1 = (struct btd_adapter *) 0x7f0cfb2e0020
> > (gdb) p adapter->auths
> > $2 = (GQueue *) 0x7f0cfb2d1240
> > (gdb) p adapter->auths->head
> > $3 = 0x0
> > 
> > Some missing NULL checks?
> 
> Not sure. The GQueue internals should not be of our concern, meaning if
> we have a non-NULL GQueue pointer I'd expect it to be safe to call
> g_queue_is_empty on that pointer. I wonder if this is some kind of
> freed memory access or similar. valgrind might show this.

Just ignore the above, I was following the exact line number in the
trace (4370) which landed me in process_auth_queue() instead of
agent_auth_cb(), i.e. I was looking at the wrong piece of code and
making the wrong conclusions.

Johan
