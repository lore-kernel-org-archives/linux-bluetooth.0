Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Oct 2011 11:22:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH bluez] add get_le/get_be helpers
Message-ID: <20111025092203.GA5154@fusion.localdomain>
References: <1319448004-8513-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111025085242.GB3514@fusion.localdomain>
 <CAMOw1v453iY4wKu46XcqtMQROT0T7Z0-xsTxAYWL6K0XQk=efQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAMOw1v453iY4wKu46XcqtMQROT0T7Z0-xsTxAYWL6K0XQk=efQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Oct 25, 2011, Lucas De Marchi wrote:
> On Tue, Oct 25, 2011 at 6:52 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Andrei,
> >
> > On Mon, Oct 24, 2011, Emeltchenko Andrei wrote:
> >> Helpers to access LE / BE values. In bluetooth there is a mixture
> >> of LE / BE network byte order.
> >> ---
> >>  lib/bluetooth.h |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 files changed, 64 insertions(+), 0 deletions(-)
> >
> > Applied. Thanks.
> 
> Should we convert code to use these new functions?

Yes, please.

Johan
