Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Feb 2010 09:20:43 +0000 (GMT)
To: Nick Pelly <npelly@google.com>
Cc: Ville Tervo <ville.tervo@nokia.com>, Marcel Holtmann <marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Allow SCO/eSCO packet type selection for
 outgoing SCO connections.
In-Reply-To: <35c90d961002251705j2cd95a8cjc7d10aa432a49f4@mail.gmail.com>
References: <1265918068-14721-1-git-send-email-npelly@google.com>  <35c90d961002111159h6727bc2cw28b55ce6e919fb4f@mail.gmail.com>  <35c90d961002151315i5fc0f5b9y36aaba4415987a2f@mail.gmail.com>  <4B7BB746.1040806@nokia.com> <35c90d961002170849m1d13743fg725a87594d63b80c@mail.gmail.com>
  <1266427894.8849.66.camel@localhost.localdomain> <35c90d961002181547x1ea26ba7je4eee29ef29e6fd2@mail.gmail.com>  <4B7E46FC.5030408@nokia.com> <35c90d961002191323x50203ca1x8ed709b3f128e41d@mail.gmail.com>  <4B82380A.6040204@nokia.com>
 <35c90d961002251705j2cd95a8cjc7d10aa432a49f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1267176043.538008.21230.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 25 Feb 2010, Nick Pelly wrote:

> On Sun, Feb 21, 2010 at 11:53 PM, Ville Tervo <ville.tervo@nokia.com> wrote:
> > Nick Pelly wrote:
> >>>>
> >>>> Attached is a new patch with the consistent bit logic.
> >>>>
> >>>> Comments?
> >>>
> >>> In order to keep backwards compatibility 1 should mean "don't allow this
> >>> packet type" for all packets. Other wise old application with new kernel
> >>> would not allow any packet types.
> >>
> >> The current patch achieves this backwards compatibility by assuming
> >> that all packet types are allowed if the old sockaddr_sco struct is
> >> used (it checks the size), or if sco_pkt_type is 0.
> >
> > OK. Then my concerns are gone.
>
> As best I can tell there are no objections. We're going ahead with this patch.
>
> http://android.git.kernel.org/?p=kernel/common.git;a=commit;h=3b077241e02041b1f03fee912896b8de1d7ac096

FWIW (I am not a Linux, Android or BlueZ developer) I think abusing the
socket address structure for this is wrong and a socket option should be
used to set options for the socket.

In general, the "Address Family" AF_BLUETOOTH domain sockets should all
use the same socket address structure. That BlueZ/Linux does not and never
has done so should be considered a bug.

regards,
iain
