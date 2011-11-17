Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Nov 2011 11:26:27 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 bluez 2/2] Add A2MP definitions
Message-ID: <20111117092627.GA2838@fusion.localdomain>
References: <005201cca4e0$e2467680$a6d36380$@org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <005201cca4e0$e2467680$a6d36380$@org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Wed, Nov 16, 2011, Peter Krystad wrote:
> +++ b/lib/a2mp.h
> @@ -0,0 +1,137 @@
> +/*
> + *
> + *	BlueZ - Bluetooth protocol stack for Linux
> + *
> + *	Copyright (C) 2010-2011 Code Aurora Forum.  All rights reserved.
> + *
> + *	This program is free software; you can redistribute it and/or modify
> + *	it under the terms of the GNU General Public License version 2 and
> + *	only version 2 as published by the Free Software Foundation.
> + *
> + *	This program is distributed in the hope that it will be useful,
> + *	but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *	GNU General Public License for more details.

I haven't forgotten about these but just been waiting for feedback from
Marcel about this inconsistent (compared to the rest of the source tree)
license header that you have (this one is "GPL 2 only" whereas the rest
(including other files that you add content to) are "GPL 2 or later".

Johan
