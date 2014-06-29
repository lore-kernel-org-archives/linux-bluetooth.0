Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: LE mouse reconnect problem
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHZ1yCniScfX+Cvoyv0B3GaYWL41qPJD4V+Le+3HENYS5kUdYw@mail.gmail.com>
Date: Sun, 29 Jun 2014 21:19:13 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Ryan Press <ryan@presslab.us>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <60346ECF-9A0B-4D3B-BDD6-A617797550D9@holtmann.org>
References: <CABx3TkUE_qFJggDNw8wUCcQzrdo6L5p3Ag3djpiUewwk_uJu5Q@mail.gmail.com> <CABBYNZLhONv81vAN8OAFX1dK5UCm44AYb2sZLyUp2gRQ4CywcA@mail.gmail.com> <CABx3TkVgs6J1UR8Z5Rbyd2e90p74RfggpzsvnxzgWGgN9c2Epg@mail.gmail.com> <CABx3TkUbD+svVpNW+0vjWS3pujZsECTOO0XxJmUQY6wOEkkZQw@mail.gmail.com> <CABBYNZKyd_jgSO-NpzbMhVo=Y1ZzWC29bX4q1YBQd73Mm4HWaQ@mail.gmail.com> <CABx3TkW-PhVeD2=Nr2pj5iL2uUm8T0B+w+WFB2EwaeW7OtChtQ@mail.gmail.com> <CABBYNZK2v-US-kOh6v28EKnqsLyjXrDUGpNJE6Wcfqv3YBwm9A@mail.gmail.com> <CABx3TkU+JvmekRYBS1iYuriJaprMznH=g6vw2MVYi+2Vqc7Y5w@mail.gmail.com> <CABx3TkXsRXUNG4RudXnYifyN4Tq4MssVGXZE6uQtPtxU34bw7A@mail.gmail.com> <20140629051442.GA31085@t440s.P-661HNU-F1> <20140629052949.GA32130@t440s> <E8C350F2-6B3C-4ECD-A281-DDC25C339489@holtmann.org> <CAHZ1yCniScfX+Cvoyv0B3GaYWL41qPJD4V+Le+3HENYS5kUdYw@mail.gmail.com>
To: Scott James Remnant <keybuk@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

>> The biggest problem here is that even if you are trying to be private and doing everything right, the mouse will broadcast your public address every time it tries to reconnect. So thank you Microsoft for forcing us to be trackable.
>> 
> 
> \o/
> 
> (I'd had an open bug to investigate why this mouse wasn't
> reconnecting, y'all beat me to it)

the same applies to the HP mouse btw.

I have seen the same problem using the Microsoft and HP mice on OS X about a month ago, but I couldn't be bothered to investigate it. OS X also uses non-resolvable private addresses for scanning.

>> Now the biggest problem is that with 3.15 and 3.16-rcX kernels we would need to go back to using our identity address for discovery. This means active scanning and it means we are broadcasting our identity address to everybody when trying to find this mouse. I rather not do that.
>> 
> 
> I think we would rather just document that this mouse isn't going to
> reconnect, since you can at least use the UI to reconnect by hand.
> Switching back to active scanning on the identity address would make
> our devices trackable, which is very definitely not on our wish list.

Besides a minor issue with the GATT channel in bluetoothd on auto-reconnection, I have this nicely working now using the kernel passive background scanning. Which means we can use non-resolvable private addresses for the discovery. However the earliest kernel this goes in will be 3.17 and I still need some minor cleanups here and there to make this smooth.

What we most likely are going to do is allow discovery using identity address for 3.15 and 3.16 and then with 3.17 we are switching back to privacy for discovery.

Regards

Marcel

