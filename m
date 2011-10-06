Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 13:24:43 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix using the attribute struct for encoding ATT
 pdus
Message-ID: <20111006162443.GB25313@samus.indt.org>
References: <1317911897-6567-1-git-send-email-vinicius.gomes@openbossa.org>
 <20111006160834.GA11338@fusion.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111006160834.GA11338@fusion.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 19:08 Thu 06 Oct, Johan Hedberg wrote:
> Hi Vinicius,
> 
> On Thu, Oct 06, 2011, Vinicius Costa Gomes wrote:
> > The enconding and decoding of ATT pdus should be kept as much
> > free of dependences from other parts of the code as possible, so
> > it can be used in many contexts.
> > 
> > In this case, for encoding and decoding notifications and indications
> > we did have to pass an instance of an attribute instead of direct
> > values.
> > ---
> >  attrib/att.c |   45 +++++++++++++++++++++++++--------------------
> >  attrib/att.h |    9 ++++++---
> >  2 files changed, 31 insertions(+), 23 deletions(-)
> 
> Did you forget to include the changes to the places where this API is
> used? The source tree should remain compilable between each individual
> commit (to maintain e.g. bisectability) and that's not happening with
> your patch.

I messed up with my last rebase, sorry about that. Fixed patch coming
soon.

> 
> Johan

Cheers,
-- 
Vinicius
