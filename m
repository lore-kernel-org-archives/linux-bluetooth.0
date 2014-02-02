Return-Path: <cyrus@holtmann.org>
Date: Sat, 1 Feb 2014 17:48:50 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/3] Bluetooth: Remove use_debug_keys debugfs entry
Message-ID: <20140202014850.GA5133@x220.p-661hnu-f1>
References: <1391198123-55506-3-git-send-email-marcel@holtmann.org>
 <CAJdJm_NaPjDdZfNXbPu-z1OBkwq89hfvN-eg6_mDDpkOMswT1g@mail.gmail.com>
 <9CDEAC4F-17D1-4CB4-BB5F-91D1D793791B@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9CDEAC4F-17D1-4CB4-BB5F-91D1D793791B@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jan 31, 2014, Marcel Holtmann wrote:
> >> Since the use of debug keys can not be identified from the current
> >> settings information, this debugfs entry is no longer.
> > 
> > I believe you meant "debug keys can be identified..."  and "is no
> > longer necessary.”
> 
> indeed I did.
> 
> Johan, in case you go ahead with applying this patch, please fix this up.

Done. All three patches in the set are now in the bluetooth-next tree.

Johan
