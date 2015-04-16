Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Device class not writeable via dbus
From: Marcus Redeker <marcus@openremote.org>
In-Reply-To: <1815811.8ZlaWYb6CG@leonov>
Date: Thu, 16 Apr 2015 09:09:28 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A1432115-C15B-4A07-BB90-E6A731C20B3B@openremote.org>
References: <16972ECC-114B-4CA0-A2B1-1BE0FB115199@openremote.org> <1815811.8ZlaWYb6CG@leonov>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

True, but  I would like todo that through dbus and not manually and have to restart bluetoothd afterwards.
Any chance this can be done in the near future?
-Marcus

> 
> You can configure CoD in main.conf
> [General]
> Class = 0x000100
> 
> Note the comment that only major and minor bits are considered. Service bits 
> are dynamically configured based on registered services.
> 
> 
> -- 
> BR
> Szymon Janc

