Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110324092452.GE30621@jh-x301>
References: <1300891601-11412-1-git-send-email-andre.dieb@signove.com>
	<20110324092452.GE30621@jh-x301>
Date: Thu, 24 Mar 2011 07:22:20 -0300
Message-ID: <AANLkTikPc1ejpG5vvpRYk-AmPHtYXJe-GgQuj7-5vr3=@mail.gmail.com>
Subject: Re: [PATCH 1/5] Inline ATT dump functions
From: =?UTF-8?Q?Andr=C3=A9_Dieb?= <andre.dieb@signove.com>
To: Andre Dieb Martins <andre.dieb@signove.com>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No, I don't. This patch is merely because all hcidump parsers (hci,
l2cap, etc) are done inline.

On Thu, Mar 24, 2011 at 6:24 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi André,
>
> On Wed, Mar 23, 2011, Andre Dieb Martins wrote:
>> ---
>>  parser/att.c |   32 ++++++++++++++++----------------
>>  1 files changed, 16 insertions(+), 16 deletions(-)
>
> Do you have some measurements that show that inlining actually has a
> noticable effect? You're also missing the justification for this change
> in the commit message.
>
> Johan
>
