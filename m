Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Feb 2011 00:09:03 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/7] Create helper functions to deal with handles on
 interactive gatttool
Message-ID: <20110223030903.GB16014@jh-x301>
References: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
 <1298401924-20094-3-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298401924-20094-3-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Tue, Feb 22, 2011, Sheldon Demario wrote:
> +	*dst = strtoll(src, &e, 16);
> +	if (errno != 0 || *e != '\0') {
> +		return -1;
>  	}

Firstly, you've got a coding style issue here: no {} for one-line
scopes. Secondly, are you sure that this is the right way to check for
strtoll failure? If there was some earlier libc function that failed
errno might be set to != 0 even if strtoll succeeds, right? Or are all
errno using libc functions guaranteed to set errno to 0 on success?
Reading the man-page of strtoll it seems you should be checking for
LLONG_MIN and LLONG_MAX return values.

I've pushed the first two patches since they were fine, but I'll stop
here until we get some clarification on this matter.

Johan
