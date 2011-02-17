Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110217190401.GA22042@jh-x301>
References: <AANLkTinBBdyyUR5-f=HMBNZ-38KnGdnU_M38kzcLuoBg@mail.gmail.com>
	<20110217190401.GA22042@jh-x301>
Date: Fri, 18 Feb 2011 00:10:48 +0100
Message-ID: <AANLkTimcP5Km2Nb2HhapDyTO_qmPzBFUC_1GbkYdVwy7@mail.gmail.com>
Subject: Re: PATCH [1/2] batostr(): Switch byte order before converting
From: David Herrmann <dh.herrmann@googlemail.com>
To: David Herrmann <dh.herrmann@googlemail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Feb 17, 2011 at 8:04 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> We can't go ahead and change the behavior of existing libbluetooth
> functions like that since it would break any applications relying on the
> old behavior (without baswap). So this patch isn't acceptable upstream.

I thought of this more like a bug because it doesn't make sense to me
why there should be a function returning the string without swapping
the bytes first. So I didn't think of this as breaking the API, but
more like fixing a function that is not used because it produces
incorrect results.
Anyway, your explanation makes sense and I don't use this function so
I am totally ok with that.

David
