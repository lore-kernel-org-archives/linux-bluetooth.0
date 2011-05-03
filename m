Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 May 2011 09:27:34 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, Keith Packard <keithp@keithp.com>,
	Vinicius Gomes <vinicius.gomes@openbossa.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.39-rc2 regression: X201s fails to resume
 b77dcf8460ae57d4eb9fd3633eb4f97b8fb20716
Message-ID: <20110503092734.1c153fc3@susi.home.s3e.de>
In-Reply-To: <20110423163759.GB2323@joana>
References: <yun1v1fj024.fsf@aiko.keithp.com>
	<alpine.LFD.2.00.1104070022280.3971@localhost6.localdomain6>
	<alpine.LFD.2.00.1104082340020.2724@localhost6.localdomain6>
	<yunaag0tjzb.fsf@aiko.keithp.com>
	<20110409000857.GB25581@piper>
	<20110411173409.1567679c@lxorguk.ukuu.org.uk>
	<BANLkTinK-cA67X6Knp-h5SKpjpDpwaMgZg@mail.gmail.com>
	<yunaafjs28n.fsf@aiko.keithp.com>
	<20110421225953.GA2323@joana>
	<yun62q7i21o.fsf@aiko.keithp.com>
	<20110423163759.GB2323@joana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 23 Apr 2011 13:37:59 -0300
"Gustavo F. Padovan" <padovan@profusion.mobi> wrote:

> * Keith Packard <keithp@keithp.com> [2011-04-21 17:04:51 -0700]:
> 
> > 
> > On Thu, 21 Apr 2011 19:59:53 -0300, "Gustavo F. Padovan" <padovan@profusion.mobi> wrote:
> > 
> > > Patch is on the way to mainline. It's currently on wireless-2.6. Next steps
> > > are net-2.6 -> linux-2.6.
> > 
> > I didn't see it on linux-kernel, so I was a bit worried. I'd love to
> > test it in place of the kludge that Vinicius sent me.
> 
> I usually don't cc linux-kernel in my pull-requests, maybe I should.

Did this hit mainline already? I seem to suffer from this still with -rc5
-- 
Stefan Seyfried

"Dispatch war rocket Ajax to bring back his body!"
