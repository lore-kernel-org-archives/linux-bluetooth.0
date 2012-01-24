Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jan 2012 10:34:02 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix memory leak when loading keys
Message-ID: <20120124133402.GA25057@samus>
References: <1327364511-6348-1-git-send-email-vinicius.gomes@openbossa.org>
 <20120124130240.GA30801@x220>
MIME-Version: 1.0
In-Reply-To: <20120124130240.GA30801@x220>
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 15:02 Tue 24 Jan, Johan Hedberg wrote:
> Hi Vinicius,
> 
> On Mon, Jan 23, 2012, Vinicius Costa Gomes wrote:
> > If we need a copy of those keys we should copy them.
> > ---
> >  plugins/hciops.c |   12 +++++++++++-
> >  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> Applied. Thanks.
> 
> In the future, could you please try to adopt the commit summary naming
> convention we've started using where there's a short prefix to highlight
> the part of the code the patch relates to. In this this case it should
> have been "hciops: ...".

Noted. Would you want me to resend my last series?

> 
> Johan

Cheers,
-- 
Vinicius
