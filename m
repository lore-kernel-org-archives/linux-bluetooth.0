Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcus Redeker <marcus@openremote.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Device class not writeable via dbus
Date: Thu, 16 Apr 2015 10:01:06 +0200
Message-ID: <5181722.aJ0IxrIXHx@uw000953>
In-Reply-To: <A1432115-C15B-4A07-BB90-E6A731C20B3B@openremote.org>
References: <16972ECC-114B-4CA0-A2B1-1BE0FB115199@openremote.org> <1815811.8ZlaWYb6CG@leonov> <A1432115-C15B-4A07-BB90-E6A731C20B3B@openremote.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcus,

On Thursday 16 of April 2015 09:09:28 Marcus Redeker wrote:
> True, but  I would like todo that through dbus and not manually and have to restart bluetoothd afterwards.
> Any chance this can be done in the near future?
> -Marcus
> 

Class of Device is rather static configuration as those describe form factor
and that usually doesn't change.

Why do you need to change CoD on the fly?

PS
Please don't top post on ML.

> > 
> > You can configure CoD in main.conf
> > [General]
> > Class = 0x000100
> > 
> > Note the comment that only major and minor bits are considered. Service bits 
> > are dynamically configured based on registered services.
> > 
> > 
> 

-- 
Best regards, 
Szymon Janc
