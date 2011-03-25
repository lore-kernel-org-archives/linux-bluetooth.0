Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Mar 2011 09:35:43 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 3/3] Bluetooth: delete hanging L2CAP channel
Message-ID: <20110325123458.GA2596@joana>
References: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1300979768-31963-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20110324191242.GD2236@joana>
 <AANLkTim2_owHJ9NT4B7u484D1itkuEmGUzdp1wxgaZTi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTim2_owHJ9NT4B7u484D1itkuEmGUzdp1wxgaZTi@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2011-03-25 10:57:52 +0200]:

> Hi Gustavo,
> 
> On Thu, Mar 24, 2011 at 9:12 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > Hi Andrei,
> >
> > * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-03-24 17:16:08 +0200]:
> >
> >> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> >>
> >> Sometimes L2CAP connection remains hanging. Make sure that
> >> L2CAP channel is deleted.
> >>
> >> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> >> ---
> >>  net/bluetooth/l2cap_sock.c |    5 +++--
> >>  1 files changed, 3 insertions(+), 2 deletions(-)
> >
> > This one is applied. Thanks.
> 
> Where it is applied? Cannot find it here:

I applied it to bluetooth-2.6 as it is a bug fix.

-- 
Gustavo F. Padovan
http://profusion.mobi
