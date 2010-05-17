Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Mon, 17 May 2010 13:53:53 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Add dynamic debug feature
Message-ID: <20100517164958.GA18835@vigoh>
References: <1273549901-28856-1-git-send-email-gustavo@padovan.org>
 <1274102952.26613.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1274102952.26613.20.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2010-05-17 15:29:12 +0200]:

> Hi Gustavo,
> 
> > It is still needed a sed work in the sources to changes debug() to DBG()
> > 
> > Thanks, to Vinicius Gomes that helped me sort out a linking issue with
> > this patch.
> > ---
> >  src/logging.c |   64 +++++++++++++++++++++++++++++++++++++++++---------------
> >  src/logging.h |   28 +++++++++++++++++++++++-
> >  src/main.c    |   34 ++++++++++++++----------------
> >  tracer/main.c |   24 +++++----------------
> >  4 files changed, 95 insertions(+), 55 deletions(-)
> > 

...

> 
> For the tracer lets do syslog manually and not intersect it with the
> dynamic debug here. You might wanna send this as a separate patch to
> remove the usage of start_logging first from it.

Thanks for the comments.

> 
> And then in the end we should rename this to src/log.c of course to make
> it match with ConnMan and oFono.

Do you have others tasks in mind to make more parts of BlueZ match
ConnMan and oFono? I can work on them as part of my GSoC. ;)

-- 
Gustavo F. Padovan
http://padovan.org
