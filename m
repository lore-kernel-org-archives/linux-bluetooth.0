Return-Path: <cyrus@holtmann.org>
Message-ID: <1349706394.27233.71.camel@aeonflux>
Subject: Re: Wireshark
From: Marcel Holtmann <marcel@holtmann.org>
To: Michal.Labedzki@tieto.com
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Date: Mon, 08 Oct 2012 16:26:34 +0200
In-Reply-To: <E50901D4F2CF69428D43141B7C8586793514C59580@EXMB03.eu.tieto.com>
References: <E50901D4F2CF69428D43141B7C8586792CFACCF505@EXMB03.eu.tieto.com>
	 <20120928135747.GD8184@aemeltch-MOBL1>
	 <E50901D4F2CF69428D43141B7C8586792CFACCF507@EXMB03.eu.tieto.com>
	,<20121003080438.GA11960@x220>
	 <E50901D4F2CF69428D43141B7C8586793514C59580@EXMB03.eu.tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> > I think you must have misunderstood what I was trying to say. Did you
> > actually look into what the monitor socket we talked about is? I wasn't
> > trying to say wireshark shouldn't be used (so no point in iterating it's
> > benefits - you've already convinced me) but that its Bluetooth decoding
> > support be ported from traditional HCI sockets to use monitor sockets
> > instead. This wouldn't give us any new decoders to wireshark but it
> > would allow early HCI traffic decoding (e.g. on plugged in USB dongles)
> 
> Hmm... Do you mean something like: 
> https://bugs.wireshark.org/bugzilla/show_bug.cgi?id=5032

that is Bluetooth HCI data inside USB traffic captured via usbmon
interfaces. Would work as well, but you need a lot of filtering to get
the right data that you are looking for. Especially problematic if the
device is not on USB or split across multiple USB busses. Which is
possible with Bluetooth 3.0 HighSpeed.

The Bluetooth monitor socket would give all at once. And will also give
you some extra data in case you missed the initial packets when the
adapter was plugged in. Like type (BR/EDR vs AMP) and address.

> I will look at that and I this is on my TODO list. But please note that my first goal is add
> full Bluetooth stack support to Wireshark (profiles and protocols). When this will be done I want to and other stuff like BToverUSB, etc.

You will never be done with all profiles and protocols. I have been
working with Bluetooth for over 11 years, they will always come with
another protocol or profile.

> The purpose of my visit here is fetch some needed logs for testing new dissectors and present this new tool to all Bluetooth developers here.
> And of course I very like new idea.
> 
> New monitor sockets is not very important for now, I focus on decoding dump files (I do not have any real devices to live-capture testing). 
> It is ok for future. By the way, this sounds like task for libpcap, not really Wireshark (by I am not familiar with internals yet)

Maybe it should be added to libpcap, but nevertheless it needs to be
done. It is the only way to get reliable data from the system these
days. The kernel is taking more and more control. And that becomes hard
to capture from userspace since it will be by definition too late.

> > which isn't possible with current wireshark or hcidump and context
> > discovery when tracing is started after there already exists
> > connections.
> 
> > Considering these benefits monitor sockets compared to HCI ones is it
> > something you might be interested in implementing?
> 
> Is that stable? 

Yes, it is stable.

> Hmmm... Has anyone logs? :)

It is like HCI with an extra header. Look at hci_mon.h.

Regards

Marcel


