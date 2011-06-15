Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jun 2011 16:06:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Fix handling asynchronous plugin reads
Message-ID: <20110615130645.GA13007@dell.ger.corp.intel.com>
References: <1307957658-11330-3-git-send-email-lkslawek@gmail.com>
 <1307964277-12590-1-git-send-email-lkslawek@gmail.com>
 <BANLkTim1bbjPbzG+=gvBua2Y7OM=YTdeNA@mail.gmail.com>
 <BANLkTinJkDZq2a+Z78p1wMAHdC1cO4ngPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTinJkDZq2a+Z78p1wMAHdC1cO4ngPw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Tue, Jun 14, 2011, Slawomir Bochenski wrote:
> On Tue, Jun 14, 2011 at 8:33 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >> +       if (ret == -EAGAIN) {
> >> +               suspend_get(os, os->obex, os->obj);
> >> +       } else if (ret < 0) {
> >>                os_set_response(os->obj, err);
> >>                OBEX_CancelRequest(os->obex, TRUE);
> >> -       } else
> >> +       } else {
> >>                OBEX_ResumeRequest(os->obex);
> >> +       }
> >
> > One line statements do not need {
> Kernel coding style states that this is not true when another branch
> in the if-else has more than one statement. Then braces should be used
> for all branches.
> >
> >> -       return FALSE;
> >> +       if (os->suspended)
> >> +               return TRUE;
> >> +       else
> >> +               return FALSE;
> >>  }
> >
> > I guess here you can just return os->suspended.
> I guess I can.

I've applied 1/4 and 2/4 since they seem fine. Luiz had some more
comments on 3/4 (I assume he'll send an email soon) and I still didn't
see an update on 4/4 to address this coding style issue Luiz pointed
out.

Johan
