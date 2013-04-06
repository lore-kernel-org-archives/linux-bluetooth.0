Return-Path: <cyrus@holtmann.org>
From: Kalle Valo <kvalo@adurom.com>
To: Eugene Krasnikov <k.eugene.e@gmail.com>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Adrian Chadd <adrian@freebsd.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	ath9k_htc_fw <ath9k_htc_fw@lists.infradead.org>,
	"linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Version number policy!
References: <CAJ-Vmo=LVSzdEo6DhfOVT_0JHCTMmdPU1zGfMuBmhmr8QuDmJQ@mail.gmail.com>
	<CAB=NE6V3sApMSGWkKbaFaJC4+VpLxgYF-xyNRKxiA-YDCwhGkQ@mail.gmail.com>
	<201304051903.11215.chunkeey@googlemail.com>
	<CAFSJ42bqquh+xekt8+V3wbG3MOUVFELTxR3mNPfS0Jn9J7OURQ@mail.gmail.com>
Date: Sat, 06 Apr 2013 08:52:19 +0300
In-Reply-To: <CAFSJ42bqquh+xekt8+V3wbG3MOUVFELTxR3mNPfS0Jn9J7OURQ@mail.gmail.com>
	(Eugene Krasnikov's message of "Fri, 5 Apr 2013 19:23:54 +0200")
Message-ID: <8762008auk.fsf@purkki.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Eugene Krasnikov <k.eugene.e@gmail.com> writes:

> Good point regarding timestamp.
>
> When it comes to feature bitmap do you have an example of such a
> bitmap from carl9170? Why not to rely always on major version?

I'm with Christian here. In ath6kl we switched to firmware advertising
feature capabilities and I have never looked back, it's so much easier.
You don't need to do any mapping between firmware versions and features,
you just deal one feature at a time.

-- 
Kalle Valo
