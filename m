Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] serial: Add support to Disconnect fd passing
 connections
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 23 Aug 2011 12:51:27 -0700
In-Reply-To: <CABBYNZLLGijC1A2MfuOKYqfiNQB=UuKsQ+awE804AkHZLfoZ4g@mail.gmail.com>
References: <1314033585-22244-1-git-send-email-padovan@profusion.mobi>
	 <1314033585-22244-2-git-send-email-padovan@profusion.mobi>
	 <1314116296.3373.213.camel@aeonflux> <20110823162822.GA26522@joana>
	 <1314117006.3373.214.camel@aeonflux> <20110823164501.GB26522@joana>
	 <CABBYNZLLGijC1A2MfuOKYqfiNQB=UuKsQ+awE804AkHZLfoZ4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314129089.3373.218.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> > This already fails today. Our code doesn't allow us to call twice the Connect
> > method, so we can't have two of the same UUID connected.
> 
> Well with RFCOMM you can't really connect multiple times to the same
> channel/UUID and if we return the same fd clients will probably have
> conflicts.

you can not connect the same channel twice (except in the other
direction), that is true, but you can connect to a different channel
with a different UUID. That is the reason why we also allow connection
by handles. Or at least we should.

So even if we would make this limitation of 1 connection per UUID, the
API is a fully asymmetric then. You are suppose to disconnect with the
result of the connect call. I do not like that at all. It is bad API
design and we are trying to squeeze this in the wrong way.

Regards

Marcel


