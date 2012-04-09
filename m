Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1333955136.16897.26.camel@aeonflux>
References: <1333950443-32114-1-git-send-email-hemant.gupta@stericsson.com>
	<1333955136.16897.26.camel@aeonflux>
Date: Mon, 9 Apr 2012 12:38:41 +0530
Message-ID: <CACj007m9UkLZCP8eMqe+Va94a3nfHQ_pB2VY8eS6DxoNkSq8Sw@mail.gmail.com>
Subject: Re: [PATCH] mgmtops: Handle Start Discovery Complete in case of failure
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Apr 9, 2012 at 12:35 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Hemant,
>
>> This patch adds handling of start discovery complete event in cases
>> when discovery fails to get started.
>>
>> Change-Id: I214c8deb10fd97a529faeec50d789478aea2f402
>
> please do not include the Android specific change id stuff in the
> upstream patches.
>
Thanks for pointing out, missed it somehow. I have re-sent a new patch.
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
