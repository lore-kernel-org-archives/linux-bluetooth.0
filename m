Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 May 2013 10:28:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ] tools: Add script for updating bt_compidtostr()
 implementation
Message-ID: <20130517072830.GA24865@x220>
References: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
 <1367612371-20930-1-git-send-email-anderson.lizardo@openbossa.org>
 <CAJdJm_O7dnpKZcTq_RJG5Hk2V_DR8jVdojSz6zuJAChyJbaZzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_O7dnpKZcTq_RJG5Hk2V_DR8jVdojSz6zuJAChyJbaZzQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, May 16, 2013, Anderson Lizardo wrote:
> On Fri, May 3, 2013 at 4:19 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> > This script uses curl and html2text to fetch company IDs from
> > bluetooth.org's "Assigned Numbers" section.
> > ---
> >
> > v2:
> >
> > * Use iconv to strip unrelated UTF-8 text from the HTML prior to passing it to
> >   html2text.
> > * Add simple sanity check for when HTML parsing fails.
> 
> ping

The script still doesn't work for me. It spews out some java script and
finally ends with "ERROR: could not parse company IDs from bluetooth.org".

Johan
