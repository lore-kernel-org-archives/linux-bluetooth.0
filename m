Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Mar 2013 21:18:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v0 03/11] device: Replace connected_profiles with
 btd_service
Message-ID: <20130322191858.GA2906@x220.P-661HNU-F1>
References: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1363678855-12765-4-git-send-email-mikel.astiz.oss@gmail.com>
 <20130322105754.GC10769@x220.ger.corp.intel.com>
 <CAJdJm_N57Q+d4ObHyUEuD3CyYAXo26yU2gn8WUtb-GtURqeF7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_N57Q+d4ObHyUEuD3CyYAXo26yU2gn8WUtb-GtURqeF7Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Mar 22, 2013, Anderson Lizardo wrote:
> > On Tue, Mar 19, 2013, Mikel Astiz wrote:
> >> +static gint service_state_cmp(gconstpointer a, gconstpointer b)
> >> +{
> >> +     struct btd_service *service = (gpointer) a;
> >
> > Couldn't you just declare the local variable const to avoid the ugly
> > cast?
> >
> >> +     service_state_t state = (service_state_t) GPOINTER_TO_INT(b);
> >
> > I think it'd be cleaner to just have:
> >
> >         const service_state_t *state = b;
> >
> >> +     if (service_get_state(service) == state)
> >
> > And this would then become:
> >
> >         if (service_get_state(service) == *state)
> 
> I don't think these are equivalent, unless the caller is also changed
> to use "&state" instead of "GINT_TO_POINTER(state)".

You're right, and that's what I (incorrectly) thought the original code
was doing.

Johan
