Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75665358AA
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oOcX6UKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71478C433CA;
	Tue,  7 Nov 2023 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699380802;
	bh=gazaRc+aEiIyTzNinDjx0ki65vH/wKHbHk/6Ydw3L4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOcX6UKm4/PBOxQiHjHPNKhhHh8phKJLtEmQmdaIx/e2sKj7d2IAKTNYQvTivuHUn
	 xraxU6y5AcfE409OESVyY5/VZ252r+5wV3YgMD5VkT6UM5y8QAwvaCTdgFFNrNTLBj
	 EdtMiqBCv1CN+yhovvAYxyu4j+UAUaXDk8pJPQig=
Date: Tue, 7 Nov 2023 19:13:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuran Pereira <yuran.pereira@hotmail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/2] Bluetooth: Replaces printk with pr_debug in bt_dbg
Message-ID: <2023110752-laundry-stiffness-9f34@gregkh>
References: <DB3PR10MB6835C002EB4C5A05AD17610BE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <DB3PR10MB6835DE6D279B65EC040B92AEE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <2023110752-headset-gains-41a7@gregkh>
 <DB3PR10MB6835DDFE9086DAC4B01C7508E8A9A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR10MB6835DDFE9086DAC4B01C7508E8A9A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>

On Tue, Nov 07, 2023 at 09:32:51PM +0530, Yuran Pereira wrote:
> Hello Greg,
> On Tue, Nov 07, 2023 at 07:31:27AM +0100, Greg KH wrote:
> > 
> > You might have just changed the functionality here, are you SURE this is
> > identical to the original code?  How was it tested?
> > 
> > I'm not saying this is a bad idea to do, just be aware of the
> > consequences for this change and document it properly (hint, the
> > changelog does not document the user-visible change that just happened.)
> > 
> > Note, pr_debug() is NOT identical to printk(), look at the source for
> > the full details.
> > 
> 
> Thank you for the heads-up. 
> Yes, you're right.
> 
> I just took another look and it seems that using pr_debug here
> does defeat the purpose of bt_dbg which was created for situations
> where `DYNAMIC_DEBUG` and `DEBUG` are disabled.
> 
> The likely equivalent would have been `pr_devel` but that also
> depends on `DEBUG`.
> 
> Do you think that a new `pr_devel_uncond` like the one below
> (only to be used in exceptional scenarios) would be a good idea?
> 
> ```
> #define pr_devel_uncond(fmt, ...) \
>     printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> ```
> 
> This would neither depend on `DYNAMIC_DEBUG` nor on `DEBUG`.

No, not at all, the bluetooth subsystem should move to actually use the
proper dynamic debug infrastructure and not have their own "special"
subsystem loging macros/functions.  What you are doing here is the
proper way forward, BUT you need to make everyone aware that it is going
to change how things work from what they do today.

In other words, it's not just a "trivial" change, you need to get
approval to change this type of functionality from the Bluetooth
developers/maintainers.

thanks,

greg k-h
