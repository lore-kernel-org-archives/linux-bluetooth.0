Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Aug 2010 22:53:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Manuel Naranjo <manuel@aircable.net>
Cc: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Re: NoInputNoOutput and legacy pairing?
Message-ID: <20100805195314.GA13190@jh-x301>
References: <4C5B0884.2040805@aircable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C5B0884.2040805@aircable.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Manuel,

On Thu, Aug 05, 2010, Manuel Naranjo wrote:
> I have a question regarding the NoInputNoOutput mode for registering
> agents for BlueZ. What happens when there's a legacy pin request and
> the mode is NoInputNoOutput? Will it fallback to standard pin code
> pairing?

Yes. The IO capability is only relevant for Secure Simple Pairing. It
doesn't matter what capability you give for legacy pairing since you'll
always get a pin request then.

Johan
