Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110126111617.GA31721@jh-x301>
References: <1295973136-30908-1-git-send-email-pavan_savoy@sify.com>
	<AANLkTinGAorqPagx_hLakiSoadbOQKv5OE4KBSa1fr5q@mail.gmail.com>
	<20110126111617.GA31721@jh-x301>
Date: Wed, 26 Jan 2011 16:56:31 +0530
Message-ID: <AANLkTin4wNd17i5OcAWhKLGwOom+K1=G1cKpEmpNXLke@mail.gmail.com>
Subject: Re: [PATCH] plugins: hciops: remove scan disable on poweroff
From: Pavan Savoy <pavan_savoy@sify.com>
To: Pavan Savoy <pavan_savoy@sify.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 26, 2011 at 4:46 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Pavan,
>
> On Tue, Jan 25, 2011, Pavan Savoy wrote:
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
> The patch seems to be corrupted (looks like the whitespace is messed
> up):
>
> Applying: plugins: hciops: remove scan disable on poweroff
> fatal: corrupt patch at line 10
> Patch failed at 0001 plugins: hciops: remove scan disable on poweroff
>
> Could you try re-sending it e.g. with git send-email?

Yes, have sent it now, may be it was corrupted because it was
forwarded from a mail which
got it via git send-email.
I wasn't registered to linux-bluetooth, with the mail ID with which i
have smtp ..

so I hope it's ok now..

> Johan
>
