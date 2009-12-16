Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Dec 2009 18:26:00 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH]btusb:Prevent illtimed autosuspend
Message-ID: <20091216182600.GA20031@srcf.ucam.org>
References: <200912161923.43127.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200912161923.43127.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 16, 2009 at 07:23:43PM +0100, Oliver Neukum wrote:
> commit 0b72b0a05c1d950e4f35520926cc36bc01fb998a
> Author: Oliver Neukum <oliver@neukum.org>
> Date:   Mon Dec 14 22:09:49 2009 +0100
> 
>     btusb:Prevent illtimed autosuspend
>     
>     The device must be marked busy as it recieves data.
>     
>     Signed-off-by: Oliver Neukum <oliver@neukum.org>

Tested-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
