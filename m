Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <l2h2a9506371004181127g305febb5leb7392a54bb5692e@mail.gmail.com>
References: <x2q2c3916b71004180928s9778e8d8zdeebe9e350ae4a19@mail.gmail.com>
	 <l2h2a9506371004181127g305febb5leb7392a54bb5692e@mail.gmail.com>
Date: Mon, 19 Apr 2010 08:26:02 +0300
Message-ID: <s2x2c3916b71004182226k58a2e354ke6b1609dc6bef1e2@mail.gmail.com>
Subject: Re: obexd FTP server signals
From: Daniel Abraham <daniel.shrugged@gmail.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Apr 18, 2010 at 9:27 PM, Vinicius Gomes
<vinicius.gomes@openbossa.org> wrote:
> On Sun, Apr 18, 2010 at 1:28 PM, Daniel Abraham
> <daniel.shrugged@gmail.com> wrote:
>> But I'd like to have a level of granularity similar to the FTP client:
>> signals about starting/progress/canceling/completing transfers, which
>> specific kinds of trasfers are done (list folder, get file, put file,
>> etc.).
>
> At first we considered some form of status reporting, but after
> thinking and looking at other "file sharing" servers we noticed that
> it was not really useful for the server to report that information,
> for example, sshd and any ftp server, don't have any form of status
> reporting.
>
> In those cases only the client reports the status, because the client
> is where the user has control. I don't think obexd is much different
> from those servers.
>
> But, do you have a concrete case for this?

1. Using it as a benchmark platform

In that case, the server is the focus point for gathering data
(consistently), and the clients are just remote black boxes. If I
can't expect and respond to specific events, I'd have to write
equivalent apps for each OS, which is sometimes impossible, and then
hope that methodology & measurements are consistent.

2. Basis for server activity logging

3. Less specific, but the sky is the limit: enabling server-side
timeouts/triggers/dynamic content/etc. - based on the user actions,
flows, history...

Anyway, my personal interest is in automating, logging and timing file
transfers from/to unknown remote clients.

Thanks
