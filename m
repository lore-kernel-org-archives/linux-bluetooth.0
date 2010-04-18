Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <x2q2c3916b71004180928s9778e8d8zdeebe9e350ae4a19@mail.gmail.com>
References: <x2q2c3916b71004180928s9778e8d8zdeebe9e350ae4a19@mail.gmail.com>
Date: Sun, 18 Apr 2010 15:27:01 -0300
Message-ID: <l2h2a9506371004181127g305febb5leb7392a54bb5692e@mail.gmail.com>
Subject: Re: obexd FTP server signals
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Daniel Abraham <daniel.shrugged@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Sun, Apr 18, 2010 at 1:28 PM, Daniel Abraham
<daniel.shrugged@gmail.com> wrote:
> Hi, I have a question:
>
> Is there any way to get more transaction-related signals from obexd,
> when it's used as an FTP _server_?
>

No. At least, not yet.

> As far as I can see from "obexd-api.txt" and from dbus-monitor, the
> only things to catch are "session_started" and "session_removed".
>
> But I'd like to have a level of granularity similar to the FTP client:
> signals about starting/progress/canceling/completing transfers, which
> specific kinds of trasfers are done (list folder, get file, put file,
> etc.).
>
> Any ideas?

At first we considered some form of status reporting, but after
thinking and looking at other "file sharing" servers we noticed that
it was not really useful for the server to report that information,
for example, sshd and any ftp server, don't have any form of status
reporting.

In those cases only the client reports the status, because the client
is where the user has control. I don't think obexd is much different
from those servers.

But, do you have a concrete case for this?

>
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Cheers,
-- 
Vinicius
