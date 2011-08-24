Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314129089.3373.218.camel@aeonflux>
References: <1314033585-22244-1-git-send-email-padovan@profusion.mobi>
	<1314033585-22244-2-git-send-email-padovan@profusion.mobi>
	<1314116296.3373.213.camel@aeonflux>
	<20110823162822.GA26522@joana>
	<1314117006.3373.214.camel@aeonflux>
	<20110823164501.GB26522@joana>
	<CABBYNZLLGijC1A2MfuOKYqfiNQB=UuKsQ+awE804AkHZLfoZ4g@mail.gmail.com>
	<1314129089.3373.218.camel@aeonflux>
Date: Wed, 24 Aug 2011 13:43:47 +0300
Message-ID: <CABBYNZJx4-ciwfoXeFsiDvBN4hszTE_imqq=Cb-ssoBsdx+UQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: Add support to Disconnect fd passing connections
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Aug 23, 2011 at 10:51 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> > This already fails today. Our code doesn't allow us to call twice the Connect
>> > method, so we can't have two of the same UUID connected.
>>
>> Well with RFCOMM you can't really connect multiple times to the same
>> channel/UUID and if we return the same fd clients will probably have
>> conflicts.
>
> you can not connect the same channel twice (except in the other
> direction), that is true, but you can connect to a different channel
> with a different UUID. That is the reason why we also allow connection
> by handles. Or at least we should.

You mean record handle? Currently we support connecting by UUID,
friendly name or channel.

> So even if we would make this limitation of 1 connection per UUID, the
> API is a fully asymmetric then. You are suppose to disconnect with the
> result of the connect call. I do not like that at all. It is bad API
> design and we are trying to squeeze this in the wrong way.

Currently we support disconnecting by UUID, friendly name, channel and
dev node. As you mentioned it doesn't really work for fd since it is
only unique per process, in the other hand the parameter is a pattern.

Perhaps what we should be doing is to return a object path in
Serial.Connect e.g. [variable
prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serialXX then Disconnect
just get it as parameter, the drawback is that this does not return
the tty/fd immediately so we need another round-trip or return
multiple values to Connect.

-- 
Luiz Augusto von Dentz
