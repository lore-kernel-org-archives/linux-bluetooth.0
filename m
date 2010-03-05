Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <745591.47999.qm@web52606.mail.re2.yahoo.com>
References: <367108.65360.qm@web52604.mail.re2.yahoo.com>
	 <2d5a2c101002260041n472b3d23m10f9048f69ea1b23@mail.gmail.com>
	 <1267806674.22567.4.camel@localhost.localdomain>
	 <768077.72808.qm@web52601.mail.re2.yahoo.com>
	 <2a9506371003051135v3bf107dct36cc9ab71a213326@mail.gmail.com>
	 <745591.47999.qm@web52606.mail.re2.yahoo.com>
Date: Fri, 5 Mar 2010 17:38:40 -0300
Message-ID: <2a9506371003051238r3be587e2s2681fab9f459a5c9@mail.gmail.com>
Subject: Re: obexd 0.14 "put" file corruption
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ed,

On Fri, Mar 5, 2010 at 4:51 PM, Ed Tsang <netdesign_98@yahoo.com> wrote:
> Vinicius,
>>  Care to send a patch against the current git?
>
>   I love to, but I don't know how to generate the patch and setup git?.
>
>  The delta is  on  client/session.c   put_xfer_progerss(..)
> - memmove(session->buffer + written, session->buffer, session->filled);
> + memmove(session->buffer, session->buffer + written,  session->filled);
>
> Could you help me put it into the source.
> If you are kind enough to point me a link to setup the git and generate a patch, I could be ready next time.
>

Sure, just asked for this patch to be included.

Here[1][2][3] are some references to get you started.

>
> Ed
>


Cheers,
-- 
Vinicius Gomes
INdT - Instituto Nokia de Tecnologia

[1] http://www.kernel.org/pub/software/scm/git/docs/

[2] http://git.wiki.kernel.org/index.php/GitDocumentation

[3] http://book.git-scm.com/
