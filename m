Return-Path: <cyrus@holtmann.org>
Message-ID: <1326183215.6454.197.camel@aeonflux>
Subject: Re: [PATCH 1/5] Bluetooth: Make l2cap_clear_timer return if timer
 was running or not
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"kanak.gupta@stericsson.com" <kanak.gupta@stericsson.com>
Date: Tue, 10 Jan 2012 00:13:35 -0800
In-Reply-To: <201201100901.30248.szymon.janc@tieto.com>
References: <1326122391-8438-1-git-send-email-szymon.janc@tieto.com>
	 <1326122391-8438-2-git-send-email-szymon.janc@tieto.com>
	 <1326138457.6454.158.camel@aeonflux>
	 <201201100901.30248.szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> > so I am enforcing this now. No more empty commit message bodies!
> > 
> > Explain your patch and why do you need it. This is the perfect example
> > where you mention ahead of time why you want this.
> 
> I'll squash 1 and 2 then and add some more explanation.

I prefer you keep the separation. The splitting of your patches is
actually the part I liked a lot. They were logically separated. You just
need to be a bit more verbose with your commit messages to describe what
you are doing and why.

Bad luck that you are the first one where I am enforcing this now, but
that is just life. Blame all the others that send in patches with crappy
commit messages ;)

Regards

Marcel


