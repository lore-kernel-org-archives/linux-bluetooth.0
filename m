Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 May 2011 07:54:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix starting security procedures when not needed
Message-ID: <20110511045412.GA4511@ideapad.Elisa>
References: <1304984994-14114-1-git-send-email-vinicius.gomes@openbossa.org>
 <BANLkTinX+8SXu+6jg5v4vHjde1fOWP2_cw@mail.gmail.com>
 <20110510145624.GA6502@piper>
 <BANLkTimFhnHyyJvSE+9wQB+NAS=GppzaZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTimFhnHyyJvSE+9wQB+NAS=GppzaZg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz & Vinicius,

> > In any case, while writing this email, I realized that only checking
> > all bt_io_set() calls wasn't enough, so this patch may be incomplete.
> > All bt_io_listen() users should be safe, but there are some callers
> > of bt_io_connect() that may depend on BtIO setting the default
> > security level to MEDIUM.
> 
> Exactly, so if you really want to use kernel default you will have to
> change all of those, but I don't thing we use any other security level
> more than medium, then it would better not to change it.

The problem is that the same function is used within btio.c for parsing
options, no matter if they're from _set, _connect or _listen. Having an
default to MEDIUM within btio.c means that we don't know when a
bt_io_set caller *doesn't* want to modify the existing security level.
(something the commit message should explain more clearly, btw). So I do
think we need to remove this default from btio.c and have all users set
it explicitly when needed (I could find 2 or 3 places missing it under
audio/ but there could be more). A simple "git grep BT_IO_OPT_" gives a
pretty good overview. Just look for places that give a PSM or RFCOMM
channel but no SEC_LEVEL.

Johan
