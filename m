Return-Path: <cyrus@holtmann.org>
Message-ID: <53ABC5E8.6010608@tieto.com>
Date: Thu, 26 Jun 2014 09:04:08 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 2/5] tools/mcaptest: Add skeleton for mcap test tool
References: <1403711401-11247-1-git-send-email-jakub.tyszkowski@tieto.com> <1403711401-11247-2-git-send-email-jakub.tyszkowski@tieto.com> <20140625194716.GA16227@t440s.P-661HNU-F1>
In-Reply-To: <20140625194716.GA16227@t440s.P-661HNU-F1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 06/25/2014 09:47 PM, Johan Hedberg wrote:
> Hi Jakub,
>
> On Wed, Jun 25, 2014, Jakub Tyszkowski wrote:
>> +tools_mcaptest_SOURCES = tools/mcaptest.c \
>> +				src/log.c btio/btio.c \
>> +				android/mcap-lib.h android/mcap-lib.c
>
> I don't think we want to have tools/* depending on anything in
> android/*. Ideally the tool should depend on a nice library in
> src/shared (which we don't have) or in the worst case on
> profiles/health or then it should be moved to android/ from tools/.
>
> Johan
>

Sure. I'll move it to android/ then.

Jakub
