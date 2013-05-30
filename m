Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/2] doc: Add reauthentication commands and event to Management API
Date: Fri, 31 May 2013 00:10:50 +0200
Message-ID: <15570803.bRbUDUQyn6@athlon>
In-Reply-To: <849D1D9E-D8A0-491B-9BCF-13878A536A54@holtmann.org>
References: <1368566595-8836-1-git-send-email-szymon.janc@gmail.com> <24461786.QnjOjE6FNW@athlon> <849D1D9E-D8A0-491B-9BCF-13878A536A54@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 28 May 2013 03:57:24 Marcel Holtmann wrote:
> Hi Szymon,

Hi Marcel,

> 
> >>> Those will be used to allow/disallow of performing remote device
> >>> reauthentication.
> >> 
> >> I guess you could expand this explaining why you need this in the MGMT
> >> API,
> >> i.e. why this can't be implemented on userspace only.
> > 
> > This will allow to avoid ACL disconnect in case of auth failure and should
> > allow to reauth also for incoming connections e.g. this is what Android
> > do.
> > I couldn't figure out how this could be achieved in userspace only but if
> > it is possible I'm totally after userspace-only implementation.
> 
> can someone send around some btmon traces that would demonstrate this. I am
> not really following on what the issue here is and what we trying to solve.

Yeah... I was confused about how authentication works. After more reading and 
testing I see that remote device with no linkkey will initiate pairing before 
connecting so this patch was trying to address non-existing issue and can be
ignored. Sorry for noise.

I'll follow with agent api extension only.

-- 
Szymon K. Janc
szymon.janc@gmail.com
