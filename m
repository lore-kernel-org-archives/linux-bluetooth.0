Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110126113608.GA9658@jh-x301>
References: <1296040915-5519-1-git-send-email-pavan_savoy@sify.com>
	<20110126113608.GA9658@jh-x301>
Date: Wed, 26 Jan 2011 18:09:38 +0530
Message-ID: <AANLkTimi44zSy2-1Z+A6RMtvj01NY-9_EeTxnWZFU=TQ@mail.gmail.com>
Subject: Re: [PATCH] plugins: hciops: remove scan disable on poweroff
From: Pavan Savoy <pavan_savoy@sify.com>
To: pavan.savoy@gmail.com, linux-bluetooth@vger.kernel.org,
	Pavan Savoy <pavan_savoy@sify.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 26, 2011 at 5:06 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Pavan,
>
> On Wed, Jan 26, 2011, pavan.savoy@gmail.com wrote:
>> From: Pavan Savoy <pavan_savoy@sify.com>
>>
>> remove sending of the scan disable command when the
>> device is being powered off.
>>
>> Signed-off-by: Pavan Savoy <pavan_savoy@sify.com>
>> ---
>>  plugins/hciops.c |    5 -----
>>  1 files changed, 0 insertions(+), 5 deletions(-)
>
> Pushed upstream after I added some extra info to the commit message and
> removed the signed-off-by line (since we don't use that in user space).

Thanks Johan..

> Johan
>
