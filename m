Return-Path: <cyrus@holtmann.org>
Date: Thu, 21 Apr 2011 19:59:53 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Keith Packard <keithp@keithp.com>
Cc: Vinicius Gomes <vinicius.gomes@openbossa.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: 2.6.39-rc2 regression: X201s fails to resume
 b77dcf8460ae57d4eb9fd3633eb4f97b8fb20716
Message-ID: <20110421225953.GA2323@joana>
References: <yun1v1fj024.fsf@aiko.keithp.com>
 <alpine.LFD.2.00.1104070022280.3971@localhost6.localdomain6>
 <alpine.LFD.2.00.1104082340020.2724@localhost6.localdomain6>
 <yunaag0tjzb.fsf@aiko.keithp.com>
 <20110409000857.GB25581@piper>
 <20110411173409.1567679c@lxorguk.ukuu.org.uk>
 <BANLkTinK-cA67X6Knp-h5SKpjpDpwaMgZg@mail.gmail.com>
 <yunaafjs28n.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yunaafjs28n.fsf@aiko.keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keith,

* Keith Packard <keithp@keithp.com> [2011-04-21 14:50:32 -0700]:

> On Mon, 11 Apr 2011 13:59:23 -0300, Vinicius Gomes <vinicius.gomes@openbossa.org> wrote:
> 
> > Will send a proper fix soon. Thanks all.
> 
> This is still broken in -rc4, I'd love to see a proper patch soon --
> this will affect any machine with a bluetooth device.

Patch is on the way to mainline. It's currently on wireless-2.6. Next steps
are net-2.6 -> linux-2.6.

Regards,

-- 
Gustavo F. Padovan
http://profusion.mobi
