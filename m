Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201108240807.09267.dstockwell@frequency-one.com>
References: <201108240807.09267.dstockwell@frequency-one.com>
Date: Thu, 25 Aug 2011 01:47:06 +0300
Message-ID: <CABBYNZLygk5nYnnLDL8zVcq52RReaWpK7jz+g46Ttdis5ZZjjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] AVRCP: Add Passthrough Signal
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Wed, Aug 24, 2011 at 4:07 PM, David Stockwell
<dstockwell@frequency-one.com> wrote:
> [PATCH 3/3] AVRCP: Add Passthrough Signal
>
> Send Passthrough signal, not only for simple keystrokes,
> but especially for Vendor Unique key, passing company-id
> and vendor-unique string as well.

I would like to do this differently, with target/controller/player
registering themselves to avoid having to blindly emit signals like
this which can no effect at all or loop effect, this should also make
us able to detect if there are multiple entities and address them
properly which is needed for 1.4.


-- 
Luiz Augusto von Dentz
