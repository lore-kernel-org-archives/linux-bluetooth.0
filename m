Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 16:11:18 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 2/7] Bluetooth: EFS: definitions and headers
Message-ID: <20111013131109.GC13721@aemeltch-MOBL1>
References: <1316179596-30906-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1316179596-30906-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111006173425.GB5652@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111006173425.GB5652@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Oct 06, 2011 at 02:34:25PM -0300, Gustavo Padovan wrote:
> > @@ -452,6 +486,8 @@ enum {
> >  	CONF_CONNECT_PEND,
> >  	CONF_NO_FCS_RECV,
> >  	CONF_STATE2_DEVICE,
> > +	CONF_LOCAL_PEND,
> > +	CONF_REMOTE_PEND,
> 
> I think I already asked this, but I may have forgotten. What are these two
> flags for? I can't get anything from their names.

The meaning for those flags are: CONF_LOCAL_PEND - local side sent L2CAP
Conf Rsp Pending, same for remote side. BTW: I am now rebasing those
patches so it would be easier to read.

Best regards 
Andrei Emeltchenko 
