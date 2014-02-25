Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Feb 2014 08:26:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: Re: [PATCH BlueZ v7 07/11] gatt: Add external services tracking
Message-ID: <20140225062656.GA3288@localhost.P-661HNU-F1>
References: <1392835893-6723-1-git-send-email-claudio.takahasi@openbossa.org>
 <1392835893-6723-8-git-send-email-claudio.takahasi@openbossa.org>
 <20140224083344.GA29475@x220.p-661hnu-f1>
 <CAJdJm_OWfmjs2CbFxGP--nno0x5o+6R3FU5+nEP6VC7bjgNKJQ@mail.gmail.com>
 <CAJdJm_MhdZwHYuwNCJCvnfRN6DpivKLJi_hiV7icV69gFCne6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_MhdZwHYuwNCJCvnfRN6DpivKLJi_hiV7icV69gFCne6Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Feb 24, 2014, Anderson Lizardo wrote:
> On Mon, Feb 24, 2014 at 8:49 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> > Hi Johan,
> >
> > On Mon, Feb 24, 2014 at 4:33 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> >> This whole timer thing seems too hackish to me.
> >>
> >> A better way to fix this might be to have something like
> >> g_dbus_client_set_proxies_complete_watch (or some better name) to let
> >> the code wait until GetManagedObjects has returned and the initial
> >> proxies added. Do you agree?
> >
> > We came up with this workaround during development, but we forgot to
> > highlight on the cover letter. Indeed a function like the one you
> > propose should be enough.
> >
> > Regarding the name for the function, I was thinking as
> > "g_dbus_client_proxies_ready_watch()". What do you think?
> 
> Or "g_dbus_client_set_proxies_ready_watch()" to be consistent.

That sounds good enough to me.

Johan
