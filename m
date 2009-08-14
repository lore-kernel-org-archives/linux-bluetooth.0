Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2d5a2c100908131010r7b077b49i4c495d864cae6667@mail.gmail.com>
References: <4A82B32E.3020903@gmail.com>
	 <2d5a2c100908120559h1a3ed5acn26b8a07ab41cd95@mail.gmail.com>
	 <4a221c10908120710y1ad31540ib5b16f27d2af4751@mail.gmail.com>
	 <2d5a2c100908131010r7b077b49i4c495d864cae6667@mail.gmail.com>
Date: Fri, 14 Aug 2009 13:52:44 +0300
Message-ID: <4a221c10908140352x4e017608t587ad61388cd83cb@mail.gmail.com>
Subject: Re: NAP/GN with bluez-4
From: "Dmitry A. Yanko" <y.dmitry@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 13, 2009 at 8:10 PM, Luiz Augusto von
Dentz<luiz.dentz@gmail.com> wrote:
> What does the command sdptool browse local gives to you? About the
> pan2 you should create it yourself, as I explained before we don't
> handle the routing/dhcp which is required for NAP, this can be the
> problem here but in the other hand there is probably a bug since
> enabled is set to true.
Look 'local.txt' file here: http://www.cross-road.org.ua/bttests/
hcidump output also available (with 'simple-service' script started,
when remote device can see 1 service, and without, when no services
shown at all). And also dump from windows box (NAP enabled), for
comparison.

-- 
#include <regards.h>
