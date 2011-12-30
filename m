Return-Path: <cyrus@holtmann.org>
Message-ID: <1325275535.1965.298.camel@aeonflux>
Subject: Re: [PATCH BlueZ 4/4] Add missing options to bootstrap-configure
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 30 Dec 2011 12:05:35 -0800
In-Reply-To: <1325273171-24698-4-git-send-email-anderson.lizardo@openbossa.org>
References: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
	 <1325273171-24698-4-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> With these options, all BlueZ C files are compiled with
> "./bootstrap-configure". The only exception is --enable-hal, which
> conflicts with the "formfactor" plugin.

actually since HAL is deprecated since a long time now, lets just go
ahead and remove that plugin as well.

Regards

Marcel


