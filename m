Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Feb 2010 13:57:04 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Ed Tomlinson <edt@aei.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Provide a driver for the Apple Magic Mouse - opps
In-Reply-To: <201002150744.51730.edt@aei.ca>
Message-ID: <alpine.LNX.2.00.1002161356220.30967@pobox.suse.cz>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz> <201002140922.42014.edt@aei.ca> <20100215071145.GA9135@core.coreip.homeip.net> <201002150744.51730.edt@aei.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 15 Feb 2010, Ed Tomlinson wrote:

> > Almost... you need to do hid_hw_stop() first and only then unregister
> > input device, Otherwise if you unload the module while moving the mouse
> > it is likely to still oops.
> 
> How about this?  It applies on top of yesterdays patch.
> 
> Ed
> 
> ---
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 7d252d2..46fdeee 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -430,8 +430,8 @@ static void magicmouse_remove(struct hid_device *hdev)
>  {
>  	struct magicmouse_sc *msc;
>  	msc = hid_get_drvdata(hdev);
> -	input_unregister_device(msc->input);
>  	hid_hw_stop(hdev);
> +	input_unregister_device(msc->input);
>  	kfree(msc);
>  }

This looks OK.

Could you please send it altogether with short changelog entry and 
Signed-off-by line so that I could queue that up?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
