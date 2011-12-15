Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111215140901.GB3164@x220>
References: <1323950056-28708-1-git-send-email-hemant.gupta@stericsson.com>
	<20111215120851.GA10113@x220>
	<CACj007=R3bmR2e=xgAdSXPXb12OdkAPXh_0qGba+mM46KBjjyQ@mail.gmail.com>
	<20111215135616.GA3164@x220>
	<CACj007mVHuigfhHxg9FsA5PEVYtft0veGqh82YSPJENF7ExAjA@mail.gmail.com>
	<20111215140901.GB3164@x220>
Date: Thu, 15 Dec 2011 19:40:29 +0530
Message-ID: <CACj007mQTYnwNaMavmiMTk-BT0WgzBha4TOwM6oiqWj1iZ9ZJQ@mail.gmail.com>
Subject: Re: [PATCHv2] mgmt: Add support for Passkey handling
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Dec 15, 2011 at 7:39 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> On Thu, Dec 15, 2011, Hemant Gupta wrote:
>> In my code, I am using htobl(passkey), while passkey is sent to kernel.
>> So you mean I need to change it to btohl ?
>
> No, you use htobl when encoding (writing to) a mgmt message and btohl
> when decoding (reading from) one.
Thanks a lot for clarification. Will send new patch in a moment.

>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
