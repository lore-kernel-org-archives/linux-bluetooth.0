Return-Path: <cyrus@holtmann.org>
Subject: Re: Configure bug
From: Marcel Holtmann <marcel@holtmann.org>
To: =?UTF-8?Q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD?= <obivankinobi@mail.ru>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <E1M7QzU-0001CY-00.obivankinobi-mail-ru@f83.mail.ru>
References: <E1M7QzU-0001CY-00.obivankinobi-mail-ru@f83.mail.ru>
Content-Type: text/plain
Date: Fri, 22 May 2009 09:28:44 -0700
Message-Id: <1243009724.3147.100.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I use Ubuntu Jauntry.
> Configure pass with no errors when I try to install bluez-4.40.tar.gz.
> But an error apear when I do "make":
> 
> libtool: link: cannot find the library `../sbc/libsbc.la' or unhandled argument `../sbc/libsbc.la'
> 
> The problem solved when I installed    libasound2-dev.
> It would be good if Configure will check for libasound2-dev installed in system.

seems like you ended up with ${alsa_enable} = yes and ${alsa_found} = no
and this is causes this mismatch.

Regards

Marcel


