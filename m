Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikYzoyNA2zz63wpMFLO7Hx-ufHF7Q@mail.gmail.com>
References: <1309458277-30407-1-git-send-email-claudio.takahasi@openbossa.org>
	<1309465011.5023.85.camel@novo.hadess.net>
	<BANLkTi=X__bC+4gAKuYzhvYPP-S3+QWGkw@mail.gmail.com>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA33A2BA4C12@EXDCVYMBSTM005.EQ1STM.local>
	<BANLkTikCHccP+-_dopoAWrAMFdwh8LHaQw@mail.gmail.com>
	<BANLkTikdgm==V3onWH+-fHEGmvT2ZTBrdw@mail.gmail.com>
	<BANLkTikYzoyNA2zz63wpMFLO7Hx-ufHF7Q@mail.gmail.com>
Date: Fri, 1 Jul 2011 14:15:33 -0400
Message-ID: <BANLkTikvQ_t+6jUauW-ubtt8=O7skuBjkg@mail.gmail.com>
Subject: Re: [RFC BlueZ] Add Proximity API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: mike tsai <mikeyhtsai@gmail.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Arun Kumar SINGH <arunkr.singh@stericsson.com>,
	Bastien Nocera <hadess@hadess.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Fri, Jul 1, 2011 at 1:00 PM, mike tsai <mikeyhtsai@gmail.com> wrote:
> I am a bit curious about the definition of PathLoss and Threshold
> property definition. The PathLoss has a range of 0 - 100, while the
> Threshold has low, medium and high setting. How do you plan to map
> PathLoss reading with Threshold setting?

The idea is to "low" "medium" and "high" in Threshold map to some
(hard-coded or calculated) percentage between 0% and 100%. E.g.:

low: 10%
medium: 60%
high: 90%

But of course we are open to suggestions :). It is very possible the
these values will not be hard-coded, because they will very much
depend on the quality of the radio hardware (I suppose). We will
probably need to perform some "calibration" during bonding.

The PathLoss is 0-100 range is just a linear normalization from actual
Path Loss calculation values, where 100 is mapped to the maximum
(nearest) theoretical value and 0 is the minimum (most far) value.
This can help applications which want to show the value as a
measurement of "link quality" of some sort.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
