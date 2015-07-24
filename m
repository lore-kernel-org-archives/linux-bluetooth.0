Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Anupam Roy <anupam.r@samsung.com>, linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: RE: [PATCH] tools/obex-client-tool.c: Fix memory leak in obex-client-tool
In-Reply-To: <1437480187-24264-1-git-send-email-anupam.r@samsung.com>
References: <1437480187-24264-1-git-send-email-anupam.r@samsung.com>
Date: Fri, 24 Jul 2015 10:59:20 -0300
Message-ID: <874mkt64hz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Anupam Roy <anupam.r@samsung.com> writes:

> ping
>
>> -----Original Message-----
>>From: Anupam Roy <anupam.r@samsung.com>
>>To: linux-bluetooth@vger.kernel.org
>>Cc:sachin.dev@samsung.com; anupam.r@samsung.com
>>Date: Fri, 26 Jun 2015 08:58:33 -0400
>>Subject: [PATCH] tools/obex-client-tool.c: Fix memory leak in obex-client-tool
>>
>>GOptionContext object should be freed in case socket connection
>>fails and program execution is terminated.
>>

The code looks fine.

(But I didn't get the first email)


Cheers,
--
Vinicius
