Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/6] android/socket: Reserve channel for HSP AG
Date: Fri, 28 Feb 2014 18:06:07 +0100
Message-ID: <1848977.f8HFz4UXRu@uw000953>
In-Reply-To: <20140228164459.GA23792@localhost.P-661HNU-F1>
References: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com> <1393604374-10127-4-git-send-email-szymon.janc@tieto.com> <20140228164459.GA23792@localhost.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Friday 28 of February 2014 18:44:59 Johan Hedberg wrote:
> Hi Szymon,
> 
> On Fri, Feb 28, 2014, Szymon Janc wrote:
> > ---
> >  android/socket.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/android/socket.c b/android/socket.c
> > index ee98b54..f6863c8 100644
> > --- a/android/socket.c
> > +++ b/android/socket.c
> > @@ -47,8 +47,9 @@
> >  
> >  #define RFCOMM_CHANNEL_MAX 30
> >  
> > +#define HSP_AG_DEFAULT_CHANNEL	11
> >  #define OPP_DEFAULT_CHANNEL	12
> > -#define HFAG_DEFAULT_CHANNEL	13
> > +#define HFP_AG_DEFAULT_CHANNEL	13
> >  #define PBAP_DEFAULT_CHANNEL	19
> 
> Wasn't our plan to mirror the BlueZ doc/assigned-numbers.txt here? At
> least the OPP and HSP channels don't match up with that.

We followed Bluedroid channels (although for HSP I did check which one is
used:), but we could go with BlueZ assigned-numbers.txt. That would require
fixed channels numbers for MAP, but that shouldn't be a problem.

Will send a patch for that.

-- 
Best regards, 
Szymon Janc
