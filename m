Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110823164501.GB26522@joana>
References: <1314033585-22244-1-git-send-email-padovan@profusion.mobi>
	<1314033585-22244-2-git-send-email-padovan@profusion.mobi>
	<1314116296.3373.213.camel@aeonflux>
	<20110823162822.GA26522@joana>
	<1314117006.3373.214.camel@aeonflux>
	<20110823164501.GB26522@joana>
Date: Tue, 23 Aug 2011 21:39:29 +0300
Message-ID: <CABBYNZLLGijC1A2MfuOKYqfiNQB=UuKsQ+awE804AkHZLfoZ4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: Add support to Disconnect fd passing connections
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Gustavo,

On Tue, Aug 23, 2011 at 7:45 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
>
> This already fails today. Our code doesn't allow us to call twice the Connect
> method, so we can't have two of the same UUID connected.

Well with RFCOMM you can't really connect multiple times to the same
channel/UUID and if we return the same fd clients will probably have
conflicts.

> But what do you suggest? I think that create a unique ID for each connected
> fd can fix this. Serial code would be responsible to assign the UID.

We can play with pipe/splice/tee, but I think that nobody will really
gonna need multiple clients per connection.

-- 
Luiz Augusto von Dentz
