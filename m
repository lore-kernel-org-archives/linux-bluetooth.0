Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315396567.1979.36.camel@aeonflux>
References: <1314033585-22244-1-git-send-email-padovan@profusion.mobi>
	<1314033585-22244-2-git-send-email-padovan@profusion.mobi>
	<1314116296.3373.213.camel@aeonflux>
	<20110823162822.GA26522@joana>
	<1314117006.3373.214.camel@aeonflux>
	<20110823164501.GB26522@joana>
	<CABBYNZLLGijC1A2MfuOKYqfiNQB=UuKsQ+awE804AkHZLfoZ4g@mail.gmail.com>
	<1314129089.3373.218.camel@aeonflux>
	<CABBYNZJx4-ciwfoXeFsiDvBN4hszTE_imqq=Cb-ssoBsdx+UQg@mail.gmail.com>
	<20110906051657.GB13617@joana>
	<CABBYNZ+wMVMQ=43dgZpPAXpP-17Tr4rdRHWjYqyKnARbn0SudQ@mail.gmail.com>
	<1315396567.1979.36.camel@aeonflux>
Date: Wed, 7 Sep 2011 15:09:02 +0300
Message-ID: <CABBYNZ+D+VGs7DAFKTd0fa3gdrGyA_SqwqXxgpVZUJv_uhTO=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: Add support to Disconnect fd passing connections
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Sep 7, 2011 at 2:56 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> yes, you do have to keep track of the client. You wanna do a proper
> shutdown if the client exits unexpectedly. Or forgets to call shutdown.

I guess the kernel would auto release the socket if the process exit
and nobody else has a reference to it, so if we close our fd after it
has been transferred the only one with reference is the client, iirc
this was a problem to tty because we have to release the devnode to
disconnect which involves ioctl but afaik that is not the case for
sockets and the client can basically call close and be done with it,
right?

-- 
Luiz Augusto von Dentz
