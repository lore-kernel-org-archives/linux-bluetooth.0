Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Mar 2009 14:12:42 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Fix another sdp-xml bug
Message-ID: <20090324121242.GA20589@localhost>
References: <1237895709.14805.722.camel@cookie.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1237895709.14805.722.camel@cookie.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Mar 24, 2009, Bastien Nocera wrote:
> Spotted by Luiz, another invalid memory access when trying to read past
> the end of a string that's not nul-terminated.
> 
> strndup to the rescue.

Thanks! Pushed upstream.

Johan
