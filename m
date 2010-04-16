Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35B17FE5076C7040809188FBE7913F983A1E128B77@SC1EXMB-MBCL.global.atheros.com>
References: <k2i2d5a2c101004140110s5834b2e6u86290c6466baa723@mail.gmail.com>
	 <35B17FE5076C7040809188FBE7913F983A1E128A57@SC1EXMB-MBCL.global.atheros.com>
	 <y2q2d5a2c101004141229gaf2dbac4u89e4e627004ddd95@mail.gmail.com>
	 <35B17FE5076C7040809188FBE7913F983A1E128B32@SC1EXMB-MBCL.global.atheros.com>
	 <z2k2d5a2c101004141334kc91838fatc9bcce8d81e38740@mail.gmail.com>
	 <35B17FE5076C7040809188FBE7913F983A1E128B77@SC1EXMB-MBCL.global.atheros.com>
Date: Fri, 16 Apr 2010 16:19:13 +0300
Message-ID: <h2x2d5a2c101004160619w9bc99d1es5ecee3acb6caf615@mail.gmail.com>
Subject: Re: detecting dead link
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mike Tsai <Mike.Tsai@atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 15, 2010 at 12:09 AM, Mike Tsai <Mike.Tsai@atheros.com> wrote:
>>>Ok, so I do miss understanding the situation. In that case, host can program link supervision timeout to a shorter time (like 3 or 4 seconds) as suggested. So the link supervision timeout shall kick in far ahead of LMP response timeout. The user will get disconnect notification sooner,

It seems that somebody already give us a favor and patented it:

http://www.freepatentsonline.com/y2009/0258596.html

That is exactly what I was looking for, depending on the link usage
(a2dp, sco) reduce the link supervision timeout to detect the link
loss faster. Well I guess the only option now is to do this
statically, which I don't think will address the problem completely
since we can only change the timeout once due to this patent.

Grrr, it is so obvious why people patent such generic usage, I really
hate software patents. Very frustrating.

-- 
Luiz Augusto von Dentz
Computer Engineer
