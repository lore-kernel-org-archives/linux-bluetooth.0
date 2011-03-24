Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201103241211.07592.szymon.janc@tieto.com>
References: <1300891601-11412-1-git-send-email-andre.dieb@signove.com>
	<20110324092452.GE30621@jh-x301>
	<AANLkTikPc1ejpG5vvpRYk-AmPHtYXJe-GgQuj7-5vr3=@mail.gmail.com>
	<201103241211.07592.szymon.janc@tieto.com>
Date: Thu, 24 Mar 2011 09:59:28 -0300
Message-ID: <AANLkTik_wfOuhUg1qJWG6XdNukbs-maH9nyPeJecGxkB@mail.gmail.com>
Subject: Re: [PATCH 1/5] Inline ATT dump functions
From: =?UTF-8?Q?Andr=C3=A9_Dieb?= <andre.dieb@signove.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

In case most agree with this, I can change my patch and provide some
patches changing old code.

Cheers

On Thu, Mar 24, 2011 at 8:11 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi,
>
>> No, I don't. This patch is merely because all hcidump parsers (hci,
>> l2cap, etc) are done inline.
>>
>> On Thu, Mar 24, 2011 at 6:24 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> > Hi André,
>> >
>> > On Wed, Mar 23, 2011, Andre Dieb Martins wrote:
>> >> ---
>> >>  parser/att.c |   32 ++++++++++++++++----------------
>> >>  1 files changed, 16 insertions(+), 16 deletions(-)
>> >
>> > Do you have some measurements that show that inlining actually has a
>> > noticable effect? You're also missing the justification for this change
>> > in the commit message.
>
> Personally I think that we should have most (if not all) of static functions
> uninlined and leave inlining decision to compiler (i.e. -finline-functions)
>
> Inlining functions based on "strong feelings and experience" or "function
> is short" without proper profiling this is just pure guesswork and can easily
> lead to unwanted results.
>
> --
> BR
> Szymon Janc
>
