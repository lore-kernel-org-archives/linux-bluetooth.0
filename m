Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Apr 2012 14:58:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemantgupta.ste@gmail.com>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] mgmtops: Handle Start Discovery Complete in case of
 failure
Message-ID: <20120410115820.GA4777@x220>
References: <1334052807-14320-1-git-send-email-hemant.gupta@stericsson.com>
 <20120410103306.GA9418@x220>
 <CACj007=tu=x=+A5xEP3Zan-rrZC6vQF+N4A8m5Lsh03iKWZzYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CACj007=tu=x=+A5xEP3Zan-rrZC6vQF+N4A8m5Lsh03iKWZzYg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Tue, Apr 10, 2012, Hemant Gupta wrote:
> On Tue, Apr 10, 2012 at 4:03 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Hemant,
> >
> > On Tue, Apr 10, 2012, Hemant Gupta wrote:
> >> This patch adds handling of start discovery complete event in cases
> >> when discovery fails to get started.
> >> ---
> >>  plugins/mgmtops.c |   33 ++++++++++++++++++++++++++++++++-
> >>  1 files changed, 32 insertions(+), 1 deletions(-)
> >
> > The patch is now applied but I still had to fix it up manually myself:
<snip>
> Thanks for the comments, I will upload a new patch soon.

I think you missed my comment above that I already fixed this myself and
applied the patch :)

Johan
