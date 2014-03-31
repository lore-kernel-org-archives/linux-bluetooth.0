Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CBACCFA0AEB13A41977475BCF3E896FC3E9D2AE11D@SC-VEXCH2.marvell.com>
References: <1391626900-11168-1-git-send-email-bzhao@marvell.com>
	<20140329072359.GA31453@t440s.P-661HNU-F1>
	<CBACCFA0AEB13A41977475BCF3E896FC3E9D2AE11D@SC-VEXCH2.marvell.com>
Date: Mon, 31 Mar 2014 12:33:40 -0700
Message-ID: <CAHZ1yC=RSM32z44Py_eOjV7fqS-FFq2_yG_Ex2EdtuzDWd01eg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix to auto accept pairing request for no MITM case
From: Scott James Remnant <keybuk@google.com>
To: Hirenkumar Tandel <hirent@marvell.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Bing Zhao <bzhao@marvell.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>, Rahul Tank <rahult@marvell.com>,
	Quinton Yuan <qyuan@marvell.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Mar 30, 2014 at 9:34 PM, Hirenkumar Tandel <hirent@marvell.com> wrote:
>
> So basically this changes the policy from rejecting pairings when an agent is not registered to accepting them in case it's a just-works pairing? I'm not convinced we want to do such a policy change that relaxes security in this regard.
>
> Do you have an actual product use case for this? What's the background and reasoning behind it?
>
> [Hiren]A use case is for chrome book, for user not logged in case, Bluetooth is working at this time, but default-agent is not registered, however user will expect  Bluetooth to work for certain simple devices like mouse.
>

That is NOT a use case that is valid for a Chromebook. We do NOT want
to accept random Bluetooth pairings without a user logged in to
confirm.

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
