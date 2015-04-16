Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcus Redeker <marcus@openremote.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Device class not writeable via dbus
Date: Thu, 16 Apr 2015 08:48:10 +0200
Message-ID: <1815811.8ZlaWYb6CG@leonov>
In-Reply-To: <16972ECC-114B-4CA0-A2B1-1BE0FB115199@openremote.org>
References: <16972ECC-114B-4CA0-A2B1-1BE0FB115199@openremote.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcus,

On Wednesday 15 of April 2015 21:03:08 Marcus Redeker wrote:
> All,
> the class property is read only on the dbus interface of
> „org.blue.Adapter1“. Why is that?
> How can I change the device class from my program?
> Regards,
> -Marcus

You can configure CoD in main.conf
[General]
Class = 0x000100

Note the comment that only major and minor bits are considered. Service bits 
are dynamically configured based on registered services.


-- 
BR
Szymon Janc
