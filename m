Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 4/5] android/hal: Add support for handling pin request event
Date: Tue, 29 Oct 2013 13:40:31 +0100
Message-ID: <5039375.pvTmde513Z@uw000953>
In-Reply-To: <20131029121945.GA1008@x220.p-661hnu-f1>
References: <1383047562-4799-1-git-send-email-szymon.janc@tieto.com> <1383047562-4799-5-git-send-email-szymon.janc@tieto.com> <20131029121945.GA1008@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Hi Szymon,
> 
> On Tue, Oct 29, 2013, Szymon Janc wrote:
> > ---
> >  android/hal-bluetooth.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> 
> I've applied the first three patches in this set, but are you sure the
> following isn't prone to unaligned access issues:
> 
> > +	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
> > +	bt_bdname_t *name = (bt_bdname_t *) ev->name;
> 
> I.e. wouldn't this be an issue if the expected alignment of bt_bdaddr_t
> and bt_bdname_t pointers is different from the alignment of ev->bdaddr
> and ev->name.

bt_bdaddr_t and bt_bdname_t are declared as packed structures so this is safe.
I'll add comment in v4 as suggested.

-- 
BR
Szymon Janc

