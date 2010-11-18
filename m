Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 10:44:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Kuehne <andre.kuehne@gmx.net>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Apple Wireless Keyboard connection issue
Message-ID: <20101118084449.GA29790@jh-x301>
References: <20101116212701.50060@gmx.net>
 <20101117013009.GA15855@vigoh>
 <20101117090534.GA11494@jh-x301>
 <4CE45F63.7030902@gmx.net>
 <20101117222751.GA20735@jh-x301>
 <4CE48602.1000009@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CE48602.1000009@gmx.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Nov 18, 2010, Andre Kuehne wrote:
> > git bisect good
> a352058752e541539b09e55124d411a534cc14af is the first bad commit
> commit a352058752e541539b09e55124d411a534cc14af
> Author: Johan Hedberg <johan.hedberg@nokia.com>
> Date:   Thu Nov 4 04:38:35 2010 +0200
> 
>     Cache adapter address for quick lookup

That's actually not related to the HID issue. There's a later commit
that fixed the general initialization issue that this commit caused.

I was now able to get hold of a Bluetooth keyboard and fixed the issue.
The problem was indeed in the commit that Gustavo originally pointed
out. It's just that my original patch for it was incomplete and so
didn't properly fix the issue. Anyway, a proper fix has now been pushed
to git. Please test with that.

Johan
