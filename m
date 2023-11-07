Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27220CA43
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jf1/0XV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A17DC433C7;
	Tue,  7 Nov 2023 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699338690;
	bh=ZbbXEst1MN/YJ42gHNB9eN+R+I0GdIoD7UuNAgu6/yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jf1/0XV+gkdPJBLGuEoR2UXNy7zwrTPyTD2jOyIuNHR0KzHKF1XISytb25na/r5Y8
	 kvuGsJd5Cqg2pk8fq1Cvtlqb4iRJjEd31GSk+J+l9rmMKy5V2eKeG0JRudF/+lFLza
	 iqNbYODmazsUFGcYdSb0qQH20121Fnr2zo4JY9v4=
Date: Tue, 7 Nov 2023 07:31:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuran Pereira <yuran.pereira@hotmail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/2] Bluetooth: Replaces printk with pr_debug in bt_dbg
Message-ID: <2023110752-headset-gains-41a7@gregkh>
References: <DB3PR10MB6835C002EB4C5A05AD17610BE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <DB3PR10MB6835DE6D279B65EC040B92AEE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR10MB6835DE6D279B65EC040B92AEE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>

On Tue, Nov 07, 2023 at 03:56:08AM +0530, Yuran Pereira wrote:
> bt_dbg() uses printk, as opposed to other functions in this file
> which use pr_* family of logging functions.
> 
> This patch changes that by replacing `printk(KERN_DEBUG` with
> the equivalent pr_debug() call which makes the overall file
> look more uniform and cleaner.
> 
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>  net/bluetooth/lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
> index 063032fe9c68..96ba39f8b461 100644
> --- a/net/bluetooth/lib.c
> +++ b/net/bluetooth/lib.c
> @@ -329,7 +329,7 @@ void bt_dbg(const char *format, ...)
>  	vaf.fmt = format;
>  	vaf.va = &args;
>  
> -	printk(KERN_DEBUG pr_fmt("%pV"), &vaf);
> +	pr_debug("%pV", &vaf);

You might have just changed the functionality here, are you SURE this is
identical to the original code?  How was it tested?

I'm not saying this is a bad idea to do, just be aware of the
consequences for this change and document it properly (hint, the
changelog does not document the user-visible change that just happened.)

Note, pr_debug() is NOT identical to printk(), look at the source for
the full details.

thanks,

greg k-h
