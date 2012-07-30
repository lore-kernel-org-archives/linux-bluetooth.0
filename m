Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHH5__62w3gO6YMnyvEeo7Pug_C0FUVZTR6wGLDz9Tkn2cKeXA@mail.gmail.com>
References: <1343123700-23375-1-git-send-email-manojkr.sharma@stericsson.com>
	<1343138034.24426.55.camel@aeonflux>
	<CAHH5__6sQ2yyEpuDZYMd4mFmHJEJeRX4eKzVM47k9TQcSthywA@mail.gmail.com>
	<1343399863.1803.10.camel@aeonflux>
	<CAHH5__62w3gO6YMnyvEeo7Pug_C0FUVZTR6wGLDz9Tkn2cKeXA@mail.gmail.com>
Date: Mon, 30 Jul 2012 19:11:29 +0300
Message-ID: <CABBYNZ+CEJby4JJRd_+A+OjAXO=n8ZZpFqehADSAk-Lgq9A0Eg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support for reserving bandwidth on L2CAP socket
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Manoj Sharma <ursmanoj@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Manoj,

On Mon, Jul 30, 2012 at 9:30 AM, Manoj Sharma <ursmanoj@gmail.com> wrote:
> One problem which I have faced using SO_PRIORITY is explained below.
>
> Suppose we have 2 links A & B and link A has higher priority than link
> B. And outgoing data transfer is active on both links. Now if device
> on link A goes far, there would be lot of failures and number of
> re-transmissions would increase for link A. Consequently at any time
> host would have significant number of packets for link A, getting
> accumulated due to poor quality of link.But since link A packets have
> higher priority, link B packets would suffer infinitely as long as
> link A packet queue in host is non-empty. Thus link B protocols may
> fail due to timers expiring and finally disconnection at upper layers.

There is a mechanism to avoid starvation, also apparently you didn't
study the code since the priority is per L2CAP channel not per link so
we are able to prioritize per profile.

> Second problem:
> We have two links similar to above scenario. Say link A is being used
> by AVDTP and link B is being used by OBEX. Host can come across a
> situation where all controller buffers are used by OBEX and AVDTP is
> waiting for a free buffer. Now due to some reason (e.g. distance) OBEX
> link B goes weak. This results into delay in transmission of OBEX
> packets already held by controller and consequently AVDTP packets also
> get delayed which causes glitches in music streaming and user
> experience goes bad.

That is exactly what SO_PRIORITY has fixed, by setting SO_PRIORITY you
prioritize AVDTP stream over OBEX which means AVDTP can use a bigger
part of the bandwidth while OBEX uses the remaining.

The credit based algorithmic actually complicates more than solves the
problems here because it should actually fail if there is no enough
bandwidth as requested, so we would actually need to query how much
credits are available, also any type of bandwidth reservation might be
overkill with things like variable bit rate where you actually need to
know what is maximum possible bandwidth you need to reserve before
hand and that credits cannot be reserved by anyone else.

> These are the basic problems which I have faced and hence felt
> necessity of a similar but different mechanism and came up with this
> solution. This solution fixes both of the problems explained above.
> Based on the explanation above your suggestion is required further.

Could you please show us what system did you find this problem? We
could possible help you trying to figure out what is going wrong,
please note that SO_PRIORITY support was introduced in 3.0 and some
system don't actually use it, in fact so far I think only PulseAudio
make use of it.


-- 
Luiz Augusto von Dentz
