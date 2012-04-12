Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334065112-14966-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334065112-14966-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 12 Apr 2012 13:58:53 +0300
Message-ID: <CABBYNZJP6P+=vtcjVG1figcb+1iktyjOJvEXhB-pgFwiayQa7Q@mail.gmail.com>
Subject: Re: [PATCH obexd v1 03/11] client: refactor transfer callback use
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Apr 10, 2012 at 4:38 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Separated internal functions are used to report success, failure, and
> progress, instead of using the callback directly.
>
> This makes the code more readable.

It adds more debug output but its also adds more lines of code,
perhaps if you join transfer_notify_complete and transfer_notify_error
then Im fine with it.

-- 
Luiz Augusto von Dentz
