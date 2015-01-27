Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1422348800-5668-1-git-send-email-gowtham.ab@samsung.com>
References: <1422348800-5668-1-git-send-email-gowtham.ab@samsung.com>
Date: Tue, 27 Jan 2015 15:39:46 +0200
Message-ID: <CABBYNZLo9BchmAqruh131Kj4RUS+CEQUB7vONvXatKXLp7pebg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Fix memory issues and trivial code cleaup
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Tue, Jan 27, 2015 at 10:53 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> In gatt-client and gatt-helpers, the variables are accessed
> even after it is freed. Making the unref at appropriate
> places solved the issues.
>
> In tools, removed dead code warnings.
>
> *v1: Rebased.
>
> Gowtham Anandha Babu (3):
>   shared/gatt-helpers: Fix usage of freed memory
>   shared/gatt-client: Fix usage of freed memory
>   tools/hciattach_ath3k: Remove dead code warnings
>
>  src/shared/gatt-client.c  | 16 +++++++++-------
>  src/shared/gatt-helpers.c | 25 ++++++++++++++++---------
>  tools/hciattach_ath3k.c   | 11 +----------
>  3 files changed, 26 insertions(+), 26 deletions(-)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
