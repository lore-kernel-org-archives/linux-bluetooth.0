Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090929141027.GA10060@jh-x301>
References: <f9d4bd30909290647ue3e5131oc14baf3d6aa2a334@mail.gmail.com>
	 <20090929141027.GA10060@jh-x301>
Date: Tue, 29 Sep 2009 12:02:19 -0300
Message-ID: <f9d4bd30909290802t366ad0e9ud6b3fb88d86b2127@mail.gmail.com>
Subject: Re: [PATCH] obex-client API - Missing method
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 29, 2009 at 11:10 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Tue, Sep 29, 2009, Claudio Takahasi wrote:
>> "Close" method  description on Session interface is missing, I added a
>> brief description on my branch "devel":
>>
>> git://git.infradead.org/users/cktakahasi/obexd.git devel
>
> The patch has been pushed upstream (with a minor language fix). Thanks.
>
> Johan
>

Hi Johan/Marcel,

I noticed that "Close" on Session interface looks like a "self kill".
The current behavior is: unregister transfer
interface (if exists) and  after unregister session interface(if ref
reaches zero). Maybe a better place(if we rename it to RemoveSession)
is "org.openobex.Client" interface, the same interface of CreateSession.

Krau.
