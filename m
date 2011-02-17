Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Feb 2011 16:04:01 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: PATCH [1/2] batostr(): Switch byte order before converting
Message-ID: <20110217190401.GA22042@jh-x301>
References: <AANLkTinBBdyyUR5-f=HMBNZ-38KnGdnU_M38kzcLuoBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinBBdyyUR5-f=HMBNZ-38KnGdnU_M38kzcLuoBg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Wed, Feb 16, 2011, David Herrmann wrote:
> The library function batostr() computes incorrect results because it
> does not swap byte-ordering before converting the address. This patch
> fixes this behaviour. It tries to make batostr() look like ba2str() to
> be consistent.

We can't go ahead and change the behavior of existing libbluetooth
functions like that since it would break any applications relying on the
old behavior (without baswap). So this patch isn't acceptable upstream.

Johan
