Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Dec 2013 12:25:52 +0100
From: Alexander Aring <alex.aring@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-zigbee-devel@lists.sourceforge.net, werner@almesberger.net,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 bluetooth-next 1/7] 6lowpan: fix udp nullpointer
 dereferencing
Message-ID: <20131217112552.GB21663@omega>
References: <1387276373-23882-1-git-send-email-alex.aring@gmail.com>
 <1387276373-23882-2-git-send-email-alex.aring@gmail.com>
 <CAJdJm_MC7DOYZ_nf-Sv6c61s0X-i2yY-7chgd5gA9ScFvVkRBg@mail.gmail.com>
 <20131217110601.GA21663@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20131217110601.GA21663@omega>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 17, 2013 at 12:06:01PM +0100, Alexander Aring wrote:
> On Tue, Dec 17, 2013 at 06:58:12AM -0400, Anderson Lizardo wrote:
> > Hi Alexander,
> > 
> > On Tue, Dec 17, 2013 at 6:32 AM, Alexander Aring <alex.aring@gmail.com> wrote:
> > > Sometimes a nullpointer dereferencing occurs because of using a wrong
> > > pointer arithmetic in udp_uncompression.
> > >
> > > This patch changes "**(hc06_ptr + 3)" to the right one "*(*hc06_ptr +
> > > 3)". Dereferencing like "**(hc06_ptr + 3)" works in a random case only.
> > 
> > And why not use hc06_ptr[0][3] ? IMHO it is more readable and the
> > arithmetic is the same (as far as I know).
> >
> 
> mhh maybe we change it to *hc06_ptr[3] ? Otherwise we have always
> something like [0][#] for access.
> 
meant (*hc06_ptr)[3] here, but I have a better idea to add a function
wich sets some data and increment it automatically. Will send v3 with
that soon.

- Alex
