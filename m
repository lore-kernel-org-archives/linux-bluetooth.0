Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACj007mVHuigfhHxg9FsA5PEVYtft0veGqh82YSPJENF7ExAjA@mail.gmail.com>
References: <1323950056-28708-1-git-send-email-hemant.gupta@stericsson.com>
	<20111215120851.GA10113@x220>
	<CACj007=R3bmR2e=xgAdSXPXb12OdkAPXh_0qGba+mM46KBjjyQ@mail.gmail.com>
	<20111215135616.GA3164@x220>
	<CACj007mVHuigfhHxg9FsA5PEVYtft0veGqh82YSPJENF7ExAjA@mail.gmail.com>
Date: Thu, 15 Dec 2011 19:39:23 +0530
Message-ID: <CACj007mKsc5h0Fn8HinxCanpkfAF2y==gz+W_1vNxP9aTo01Nw@mail.gmail.com>
Subject: Re: [PATCHv2] mgmt: Add support for Passkey handling
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 15, 2011 at 7:29 PM, Hemant Gupta <hemantgupta.ste@gmail.com> wrote:
> Hi Johan,
>
> On Thu, Dec 15, 2011 at 7:26 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Hemant,
>>
>> On Thu, Dec 15, 2011, Hemant Gupta wrote:
>>> Thanks for the comment, I used it since the kernel was using le32, and
>>> the structure allocated was u32? Dont we require to do the type
>>> casting?
>>
>> No. To my understanding the difference is only annotational, i.e. it's
>> only there to remind you of the endianness of the variable. In user
>> space we just use uint32_t but have to remember to call btohl before
>> using the value for anything.
> In my code, I am using htobl(passkey), while passkey is sent to kernel.
> So you mean I need to change it to btohl ?

The defines in bluetooth.h seems same for both btohl and htobl
#define htobl(d)  bswap_32(d)
#define btohl(d)  bswap_32(d)
>>
>> Johan
>
>
>
> --
> Best Regards
> Hemant Gupta
> ST-Ericsson India



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
