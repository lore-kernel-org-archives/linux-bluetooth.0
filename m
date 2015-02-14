Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 4/4] core: Add support for Multi Profile Specification
Date: Sat, 14 Feb 2015 15:51:59 +0100
Message-ID: <8280430.RqLY9WsdAc@leonov>
In-Reply-To: <20150214144350.GA9782@t440s.P-661HNU-F1>
References: <1423918946-14332-1-git-send-email-szymon.janc@tieto.com> <1423918946-14332-4-git-send-email-szymon.janc@tieto.com> <20150214144350.GA9782@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Saturday 14 of February 2015 16:43:50 Johan Hedberg wrote:
> Hi Szymon,
> 
> On Sat, Feb 14, 2015, Szymon Janc wrote:
> > +	str = g_key_file_get_string(config, "General", "MultiProfile", &err);
> > +	if (err) {
> > +		g_clear_error(&err);
> > +	} else {
> > +		DBG("MultiProfile=%s", str);
> > +
> > +		if (strcmp(str, "mpsd")) {
> > +			mps_mpsd = true;
> > +		} else if (strcmp(str, "mpmd")) {
> > +			mps_mpsd = true;
> > +			mps_mpmd = true;
> > +		}
> 
> Shouldn't these be '!strcmp'?
> 
> Johan

They should. I'll send V3 of this patch shortly.

-- 
BR
Szymon Janc
