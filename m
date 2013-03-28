Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v7 00/16] mSBC investigations
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1364465943-959-1-git-send-email-frederic.dalleau@linux.intel.com>
Date: Thu, 28 Mar 2013 08:40:38 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E17F26C0-174D-4C8F-AE3C-31EFCDBC0622@holtmann.org>
References: <1364465943-959-1-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> v7 features bool instead of int for odd state. uint8_t instead of int for
> increment. Little refactoring of sbcinfo and copyrights update for 2013. No
> longer bumps version number.
> 
> v6 implements sbc_init_msbc(). The SBC_MSBC flag is removed from sbc.h and
> replace by an internal flag in sbc_priv structure.
> The decoder has been validated to mSBC packets sent by an iPhone.
> The encoder couldn't be validated, but at least we know that libsbc encoded
> packets can be decoded by libsbc.
> I bumped version number to 1.1 to help compile time detection.
> 
> v5 shoudl fix the few remaining issues.  I could test neon and armv6
> and raised verbosity of commit messages.

I have two tiny comments on this one, but otherwise I am fine with the patch set. I am clearly not the authority on codec correctness, but from a pure patch flow, this is fine with me.

Does anybody else have a comment on the mSBC support?

Regards

Marcel

