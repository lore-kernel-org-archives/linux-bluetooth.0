Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Nov 2011 10:42:08 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Michael Schmitt <tcwardrobe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	padovan@profusion.mobi
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
Message-ID: <20111128084206.GB29363@aemeltch-MOBL1>
References: <4EC679A0.7050309@gmail.com>
 <20111118153652.GA3647@fusion.localdomain>
 <4EC67E88.6060202@gmail.com>
 <20111118162111.GA4680@fusion.localdomain>
 <4EC68909.40108@gmail.com>
 <20111118203019.GA24250@x220.ger.corp.intel.com>
 <4EC91C7F.9070500@gmail.com>
 <4ED20B2F.5010609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ED20B2F.5010609@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Sun, Nov 27, 2011 at 11:04:31AM +0100, Michael Schmitt wrote:
> Just as a follow-up question (as I did not get a clear conclusion
> out of the discussion and it seems to me the "discussion" did stop
> without a real conclusion)...
> 
> What is the plan right now? Will there be a patch upstream (in the
> kernel) at some point? Is it not clear how to fix that (broken?)
> hardware driver-wise yet? Should I test something?

Could you test Johan's patch:

http://permalink.gmane.org/gmane.linux.bluez.kernel/18752

[PATCH 2/2] Bluetooth: Ignore HCI_Read_Local_Commands failures

You can also apply the first patch.

Best regards 
Andrei Emeltchenko 

> 
> regards
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
