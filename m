Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Date: Tue, 14 Jun 2011 10:18:34 +0100
In-Reply-To: <20110614080730.GC28890@dell.ger.corp.intel.com>
References: <BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
	 <1307554688-21555-1-git-send-email-hadess@hadess.net>
	 <20110614080730.GC28890@dell.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308043116.26522.1.camel@air.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2011-06-14 at 11:07 +0300, Johan Hedberg wrote:
> Hi Bastien,
<snip>
> This could simply be:
> 
> 	if (adapter->up)
> 		return adapter_ops->set_name(adapter->dev_id, name);
> 
> 	return 0;
> 
> Other than that I didn't find any major issues, however please consider
> the suggestion from Lizardo to split the patch in two parts.

I already sent the split patches (2 of them) last week:
http://thread.gmane.org/gmane.linux.bluez.kernel/13621

 I think this is an indication that a mailing-list isn't that good a
tracking tool...

Cheers

