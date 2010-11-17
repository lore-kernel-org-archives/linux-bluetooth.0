Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCHv3 5/7] Add approval request for incoming pairing requests with OOB mechanism
Date: Wed, 17 Nov 2010 17:03:09 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "marcel@holtmann.org" <marcel@holtmann.org>
References: <1289922247-20712-1-git-send-email-szymon.janc@tieto.com> <1289922247-20712-6-git-send-email-szymon.janc@tieto.com> <20101116162412.GB3638@jh-x301>
In-Reply-To: <20101116162412.GB3638@jh-x301>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201011171703.09413.szymon.janc@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > +	req->msg = dbus_message_new_method_call(agent->name, agent->path,
> > +				"org.bluez.Agent", "RequestApproval");
> 
> I think the name of this method is one of the more important things to
> get right before we push this upstream. I'm not so sure of the current
> proposal. I have a feeling that it'd be a good idea to have the term
> "pair" somewhere explicitly in the name. How about "RequestPairing"? I
> know Marcel will have something to say about this too.

Maybe make it more descriptive like RequestPairingApproval ?
Yet, RequestPairing sounds ok.

-- 
Szymon Janc
on behalf of ST-Ericsson
