Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [RFC 1/2] doc: Add reauthentication commands and event to Management API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <24461786.QnjOjE6FNW@athlon>
Date: Tue, 28 May 2013 03:57:24 +0900
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <849D1D9E-D8A0-491B-9BCF-13878A536A54@holtmann.org>
References: <1368566595-8836-1-git-send-email-szymon.janc@gmail.com> <1368566595-8836-2-git-send-email-szymon.janc@gmail.com> <20130514231538.GA395@samus.indt.org> <24461786.QnjOjE6FNW@athlon>
To: Szymon Janc <szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> Those will be used to allow/disallow of performing remote device
>>> reauthentication.
>> 
>> I guess you could expand this explaining why you need this in the MGMT API,
>> i.e. why this can't be implemented on userspace only.
> 
> This will allow to avoid ACL disconnect in case of auth failure and should
> allow to reauth also for incoming connections e.g. this is what Android do.
> I couldn't figure out how this could be achieved in userspace only but if it
> is possible I'm totally after userspace-only implementation.

can someone send around some btmon traces that would demonstrate this. I am not really following on what the issue here is and what we trying to solve.

Regards

Marcel

