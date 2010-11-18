Return-Path: <cyrus@holtmann.org>
Message-ID: <4CE576DB.5090205@gmx.net>
Date: Thu, 18 Nov 2010 19:56:27 +0100
From: Andre Kuehne <andre.kuehne@gmx.net>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Apple Wireless Keyboard connection issue
References: <20101116212701.50060@gmx.net> <20101117013009.GA15855@vigoh> <20101117090534.GA11494@jh-x301> <4CE45F63.7030902@gmx.net> <20101117222751.GA20735@jh-x301> <4CE48602.1000009@gmx.net> <20101118084449.GA29790@jh-x301>
In-Reply-To: <20101118084449.GA29790@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/18/2010 09:44 AM, Johan Hedberg wrote:
> I was now able to get hold of a Bluetooth keyboard and fixed the issue.
> The problem was indeed in the commit that Gustavo originally pointed
> out. It's just that my original patch for it was incomplete and so
> didn't properly fix the issue. Anyway, a proper fix has now been pushed
> to git. Please test with that.

Thank you Johan and Gustavo, current git works fine for me.

Andre
