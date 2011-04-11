Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Apr 2011 12:58:26 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Keith Packard <keithp@keithp.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: 2.6.39-rc2 regression: X201s fails to resume
 b77dcf8460ae57d4eb9fd3633eb4f97b8fb20716
Message-ID: <20110411155826.GA2195@joana>
References: <yun1v1fj024.fsf@aiko.keithp.com>
 <alpine.LFD.2.00.1104070022280.3971@localhost6.localdomain6>
 <alpine.LFD.2.00.1104082340020.2724@localhost6.localdomain6>
 <yunaag0tjzb.fsf@aiko.keithp.com>
 <20110409000857.GB25581@piper>
 <yunipuouqoi.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yunipuouqoi.fsf@aiko.keithp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Keith Packard <keithp@keithp.com> [2011-04-08 19:03:25 -0700]:

> On Fri, 8 Apr 2011 21:08:57 -0300, Vinicius Costa Gomes <vinicius.gomes@openbossa.org> wrote:
> 
> > I took a shot at it and just sent a patch (also attached for convenience) 
> > that should solve the problem.
> 
> Thanks much! I applied this to -rc2 and it appears to work fine in some
> brief testing (a dozen suspend/resume cycles)
> 
> > Reported-by: Keith Packard <keithp@keithp.com>
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> 
> Tested-by: Keith Packard <keithp@keithp.com>

I applied the patch to bluetooth-2.6. Thank you all.


-- 
Gustavo F. Padovan
http://profusion.mobi
