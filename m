Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Dec 2013 07:05:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 30/32] Bluetooth: Fix validating LE PSM values
Message-ID: <20131206050519.GA30747@x220.p-661hnu-f1>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
 <1386249090-10236-31-git-send-email-johan.hedberg@gmail.com>
 <CAJdJm_Pvc97a8i3vcO4NO0sDJFzUyJ3JOkGuwOyYL8Bi8RjE5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_Pvc97a8i3vcO4NO0sDJFzUyJ3JOkGuwOyYL8Bi8RjE5A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Dec 05, 2013, Anderson Lizardo wrote:
> On Thu, Dec 5, 2013 at 9:11 AM,  <johan.hedberg@gmail.com> wrote:
> > +static bool is_valid_psm(u16 psm, u8 dst_type)
> > +{
> > +       if (!psm)
> > +               return false;
> > +
> > +       if (bdaddr_type_is_le(dst_type))
> > +               return (psm < 0x00ff);
> 
> Shouldn't be "psm <= 0x00ff" here?

Yes, it should. I just sent two fix-up patches based on your feedback.
Thanks.

Johan
