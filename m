Return-Path: <cyrus@holtmann.org>
Subject: Re: obexd 0.14 "put" file corruption
From: Bastien Nocera <hadess@hadess.net>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: Ed Tsang <netdesign_98@yahoo.com>,
	Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2a9506371003051238r3be587e2s2681fab9f459a5c9@mail.gmail.com>
References: <367108.65360.qm@web52604.mail.re2.yahoo.com>
	 <2d5a2c101002260041n472b3d23m10f9048f69ea1b23@mail.gmail.com>
	 <1267806674.22567.4.camel@localhost.localdomain>
	 <768077.72808.qm@web52601.mail.re2.yahoo.com>
	 <2a9506371003051135v3bf107dct36cc9ab71a213326@mail.gmail.com>
	 <745591.47999.qm@web52606.mail.re2.yahoo.com>
	 <2a9506371003051238r3be587e2s2681fab9f459a5c9@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 08 Mar 2010 14:31:41 +0000
Message-ID: <1268058702.22567.160.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2010-03-05 at 17:38 -0300, Vinicius Gomes wrote:
> Hi Ed,
> 
> On Fri, Mar 5, 2010 at 4:51 PM, Ed Tsang <netdesign_98@yahoo.com> wrote:
> > Vinicius,
> >>  Care to send a patch against the current git?
> >
> >   I love to, but I don't know how to generate the patch and setup git?.
> >
> >  The delta is  on  client/session.c   put_xfer_progerss(..)
> > - memmove(session->buffer + written, session->buffer, session->filled);
> > + memmove(session->buffer, session->buffer + written,  session->filled);
> >
> > Could you help me put it into the source.
> > If you are kind enough to point me a link to setup the git and generate a patch, I could be ready next time.
> >
> 
> Sure, just asked for this patch to be included.

You could at least have mentioned Ed's name in the commit log, or
attributed the patch to him...

> Here[1][2][3] are some references to get you started.



