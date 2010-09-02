Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 23:16:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	rufferson@gmail.com
Subject: Re: [PATCH] Remember fake devices for the daemon's lifetime
Message-ID: <20100902201628.GA7671@jh-x301>
References: <1283446547.2361.68.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283446547.2361.68.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Thu, Sep 02, 2010, Bastien Nocera wrote:
> Here's a rework of Ruslan's patch. This should make PS3 BD remotes
> faster to reconnect, by not having to setup uinput every time.

Thanks. This one has also been pushed upstream.

Johan
