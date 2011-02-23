Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110223030903.GB16014@jh-x301>
References: <1298328606-7993-1-git-send-email-sheldon.demario@openbossa.org>
	<1298401924-20094-3-git-send-email-sheldon.demario@openbossa.org>
	<20110223030903.GB16014@jh-x301>
Date: Wed, 23 Feb 2011 10:23:34 -0300
Message-ID: <AANLkTikLVsq8gmS+qc8nfitrHJTE1KwB3+wzBxdVOv8V@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] Create helper functions to deal with handles on
 interactive gatttool
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: Sheldon Demario <sheldon.demario@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

On Wed, Feb 23, 2011 at 12:09 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Sheldon,
>
> On Tue, Feb 22, 2011, Sheldon Demario wrote:
>> +     *dst = strtoll(src, &e, 16);
>> +     if (errno != 0 || *e != '\0') {
>> +             return -1;
>>       }
>
> Firstly, you've got a coding style issue here: no {} for one-line
> scopes. Secondly, are you sure that this is the right way to check for
> strtoll failure? If there was some earlier libc function that failed
> errno might be set to != 0 even if strtoll succeeds, right? Or are all
> errno using libc functions guaranteed to set errno to 0 on success?
> Reading the man-page of strtoll it seems you should be checking for
> LLONG_MIN and LLONG_MAX return values.

If strtoll() returns LLONG_MIN or LLONG_MAX the errno is set to ERANGE
so it is not need to check for these returning values. However, as
Lizardo said, the errno must be set to 0 before strtoll() be called,
so will send this fix.

Sheldon.
