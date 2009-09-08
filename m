Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Sep 2009 16:16:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Kornatowski <pkorn@gmx.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: AnswerRequested-signal just works with HSP, but not with HFP?
Message-ID: <20090908131645.GA15098@jh-x301>
References: <7.0.1.0.2.20090908144122.02210dd8@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7.0.1.0.2.20090908144122.02210dd8@gmx.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Tue, Sep 08, 2009, Peter Kornatowski wrote:
> I want to make use of the answer-button of a bt-headset in my linux app 
> but it just works in HSP, not in HFP mode (I have been playing around 
> with this since bluez 4.3x, but the error stayed).
> I tried this in C and in python and I get the AnswerRequested-signal  
> only when "HFP=false" is set in /etc/bluetooth/audio.conf.
> Tests with three different headsets and on two different computers  
> (Ubuntu laptop and debian lenny desktop PC) showed the exact same 
> behaviour.

HFP has a much more complicated state machine than HSP (actually HSP is
almost stateless compared to HFP). In order for the headset to send us a
"answer" request the headset needs to think that there is an incoming call
active and for this we should be sending more information to it than just
the "RING" message (which HSP uses). After answering the call the headset
also needs to be notified that the call has actually been answered in
order for the headset to be able to send a "end call" request later (and
this of course needs to happen even if you answer the call from the PC
instead of from the headset).

So, as you can guess, for all this to work you need pretty tight
integration with your telephony application/subsystem. BlueZ does already
provide a way to handle this through something called a telephony driver
but depending on what telephony software you use you may need to create
your own driver. There are currenytly three drivers (audio/telephony-*.c)
coming with upstream bluez: dummy, maemo and ofono. The dummy driver is
what you have most likely compiled and you might be able to get away with
the signals that it sends, or if some signals are missing add them by
hacking audio/telephony-dummy.c.

Johan
