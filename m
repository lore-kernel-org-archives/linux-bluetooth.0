Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Apr 2011 22:03:55 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Brian Gix <bgix@codeaurora.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: Low Energy Security Manager
Message-ID: <20110406010355.GB2279@joana>
References: <4D9A44A7.4020204@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D9A44A7.4020204@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

* Brian Gix <bgix@codeaurora.org> [2011-04-04 15:22:31 -0700]:

> 
> Hi Gustavo,
> 
> I (and a few others) are currently doing LE kernel development work off of:
> 
> git://gitorious.org/bluetooth-next/for-upstream.git
> 
> which is where Vinicius' LE Security Manager resides.
> 
> Acceptance of this body of work into bluetooth-next appears to have 
> stalled out, and I was wondering if you had a sense for when it may 
> start moving forward again.  Are there any outstanding comments lodged 
> against it?  I have looked through the mail reflector, and not seen 
> anything that should hold it up, beyond perhaps the normal quiet times 
> prior to pushing bluetooth-next changes up the food chain towards the 
> official kernel.

The reason is that Marcel also want to review it and he didn't finished his
review it. So things can still changes. We have to be careful on adding new
stuff like a whole layer. If we do something wrong we will have to support
that for years and could be a bad thing. Once Marcel and me finish the review
I will push everything to bluetooth-next.  It shouldn't take so long now.

Regards,

-- 
Gustavo F. Padovan
http://profusion.mobi
