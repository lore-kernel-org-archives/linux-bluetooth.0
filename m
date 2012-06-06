Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJgzZwBC4KWf_4huHA4FBuo5+n_cNqobWWnVedQsY8Y-g@mail.gmail.com>
References: <1323703867-20577-1-git-send-email-bulislaw@linux.com>
	<1323703867-20577-4-git-send-email-bulislaw@linux.com>
	<20111215115009.GB8056@x220>
	<CAPGrrxWWRPkCyKgRu2SkEmdhjdZgkjEQ+ES0DhfuoshvsVBUfw@mail.gmail.com>
	<20111215121700.GA10535@x220>
	<CAPGrrxVH_S=bJopAv-9nzW_kL9YxJh4FHYGRby-dZQcjS+jvzw@mail.gmail.com>
	<CABBYNZJgzZwBC4KWf_4huHA4FBuo5+n_cNqobWWnVedQsY8Y-g@mail.gmail.com>
Date: Wed, 6 Jun 2012 10:19:50 +0100
Message-ID: <CAPGrrxUF-KAiZpaPfdinT0ZHXhMt-2CiwBAi3fsrtv23aAUNhQ@mail.gmail.com>
Subject: Re: [PATCH obexd 4/4] Add support for PullMessagesListing in MAP client
From: Bartosz Szatkowski <bulislaw@linux.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?UTF-8?B?U8WCYXdlayBCb2NoZcWEc2tp?= <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 6, 2012 at 9:14 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Bartosz,
>
> On Thu, Dec 15, 2011 at 2:45 PM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
>>>
>>> So the plan is to return something else than the raw XML that MAP
>>> provides? In that case I don't think it's necessary to hold on to the
>>> exact spec naming of these functions. E.g. GetMessages or GetMessageList
>>> might make more sense in the case that you return a pre-parsed
>>> list/structure of some kind.
>>>
>>> Johan
>>
>> We planned to return dict {field: value}. Generally I don't care much
>> about this name - we can go with GetMessageListing, as I seem to use
>> both forms without noticing it anyway.
>
> Are there still plans to continue this work? I would like to change
> this method to return a dictionary like we do for pbap and perhaps
> unify this in a single listing so we do folder + messages.
>
>
> --
> Luiz Augusto von Dentz

Hi Luiz,
since January I'm not longer Comarch employee - so you probably should
ask Sławek/Radek/Łukasz whether they're planing to continue work on
it.

-- 
Cheers,
Bartosz Szatkowski
