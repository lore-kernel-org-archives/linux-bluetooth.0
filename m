Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 23 Aug 2011 15:52:17 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: Add support to Disconnect fd passing
 connections
Message-ID: <20110823185217.GD26522@joana>
References: <1314033585-22244-1-git-send-email-padovan@profusion.mobi>
 <1314033585-22244-2-git-send-email-padovan@profusion.mobi>
 <1314116296.3373.213.camel@aeonflux>
 <20110823162822.GA26522@joana>
 <1314117006.3373.214.camel@aeonflux>
 <20110823164501.GB26522@joana>
 <CABBYNZLLGijC1A2MfuOKYqfiNQB=UuKsQ+awE804AkHZLfoZ4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLLGijC1A2MfuOKYqfiNQB=UuKsQ+awE804AkHZLfoZ4g@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz, Marcel,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-08-23 21:39:29 +0300]:

> Hi Marcel, Gustavo,
> 
> On Tue, Aug 23, 2011 at 7:45 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
> >
> > This already fails today. Our code doesn't allow us to call twice the Connect
> > method, so we can't have two of the same UUID connected.
> 
> Well with RFCOMM you can't really connect multiple times to the same
> channel/UUID and if we return the same fd clients will probably have
> conflicts.

That said, I think this patch is ok, as it relies in UUID as a unique reference.

	Gustavo
