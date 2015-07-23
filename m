Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Qingtao Cao <qingtao.cao.au@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth\@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: How to write a C program to be paired asynchronously?
In-Reply-To: <CAPcThSHpPpV8f=WeEEFySrWP9sHCfzqs+n5U+n+=wohwg0=g-g@mail.gmail.com>
References: <CAPcThSGd9RO=8aK0ALkyWzSa7zLpr=8o7qMpT5sNex=LWu_XtQ@mail.gmail.com> <CABBYNZLLd-dS0u39roqCrin=MpYy7WNiL4MEYDik0o-0G84JDA@mail.gmail.com> <CAPcThSHpPpV8f=WeEEFySrWP9sHCfzqs+n5U+n+=wohwg0=g-g@mail.gmail.com>
Date: Thu, 23 Jul 2015 18:43:50 -0300
Message-ID: <877fpq5z3d.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harry,

Qingtao Cao <qingtao.cao.au@gmail.com> writes:

> Hi Luiz,
>
> Many thanks for your comments! I sure will try to navigate through the
> source code to find a concrete answer.
>
> I did some progress today but had a further related question about the
> agent in the pairing process.
>
> Previously I have manipulated bluez's dbus APIs to pair a given remote
> device successfully, turns out before invoking the
> CreatePairedDevice() method on the org.bluez.Adapter interface, I only
> need to register the handler of the RequestConfirmation() message on
> the org.bluez.Agent interface (although no object existed to register
> it in the first place) to reply an empty reply and the pairing attempt
> launched by remote device can succeed.
>
> Later today I found that in order to handle async pairing request from
> remote device successfully, aside from the handler of the same
> RequestConfirmation() message, the missing piece seems to be using the
> RegisterAgent() method on the org.bluez.Adapter interface, without
> which the bluetoothd seems won't throw out the RequestConfirmation()
> message at all.
>
> Now what puzzles me is that if I register an agent before invoking the
> CreatePairedDevice() method and passing it the discretionary object
> path of the agent registered,  the RequestConfirmation() won't be
> called at all in the first scenario. Also the doc/adapter-api.txt says
> that during CreatePairedDevice() invocation it's not necessary to
> register an agent, but it didn't prohibit it. By contrast, an agent
> would have to be registered in the second scenario.

If you pass "/" as the agent path to CreatePairedDevice() it should use
the agent that was registered for that Adapter.

(You are asking about BlueZ 4.XX, which was released some time ago, I
may have forgotten how it used to work ;-)

>
> So, how should I use an agent consistently regardless of whether it is
> incoming or outgoing pairing request?

That "/" trick should do the job.

>
> Moreover, different agent capability such as KeyboardDisplay or
> NoInputNoOutput will make a difference in terms of agent APIs invoked
> by bluetoothd during pairing, how should I assign a proper capability
> for my agent, if needed, for different devices such as mobile, headset
> or keyboard?

Usually you don't have all the information necessary at the point when
CreatePairedDevice() to choose, only when the bonding procedure is started,
and both devices exchange their capabilities you have that kind of
information. So, my suggestion is, implement all the callbacks, so you
can pair with all kinds of devices, inform the most sofisticated
capability and leave the kernel to do the negotiation.


Cheers,
--
Vinicius
