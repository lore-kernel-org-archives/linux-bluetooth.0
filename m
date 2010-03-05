Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <768077.72808.qm@web52601.mail.re2.yahoo.com>
References: <367108.65360.qm@web52604.mail.re2.yahoo.com>
	 <2d5a2c101002260041n472b3d23m10f9048f69ea1b23@mail.gmail.com>
	 <1267806674.22567.4.camel@localhost.localdomain>
	 <768077.72808.qm@web52601.mail.re2.yahoo.com>
Date: Fri, 5 Mar 2010 16:35:41 -0300
Message-ID: <2a9506371003051135v3bf107dct36cc9ab71a213326@mail.gmail.com>
Subject: Re: obexd 0.14 "put" file corruption
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ed,

On Fri, Mar 5, 2010 at 3:07 PM, Ed Tsang <netdesign_98@yahoo.com> wrote:
> I think I found the problem.  It is when the MTU is 4096, the send size is set to
> 3896 (200 for the overhead). So the last 200 did not get send
> and it remember as "pre-fill" for the next transfer. The code did try to move the data but incorrectly.
>
>   clinet/session.c  put_xfer_progress()
> ----- origional
>  memmove(session->buffer + written, session->buffer, session->filled);
>  /* try to move from the remaining from the bottom of the buffer to the beginning of buffer
>   but memove is (*dest, * src, len)  not as normally most people, including me, will guess (*src, *dest, len)
> -------- should be
>  memmove(session->buffer, session->buffer + written,  session->filled);
>
>

Yeah, I can reproduce it changing DEFAULT_BUFFER_SIZE to something
bigger, 32767 for example.

Care to send a patch against the current git?

Thanks for the report.

> with the change, it seem working now?
>
>
> Ed
>


Cheers,
-- 
Vinicius Gomes
INdT - Instituto Nokia de Tecnologia
