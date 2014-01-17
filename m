Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389960506-10273-1-git-send-email-ncopa@alpinelinux.org>
References: <1389960506-10273-1-git-send-email-ncopa@alpinelinux.org>
Date: Fri, 17 Jan 2014 16:47:57 +0200
Message-ID: <CABBYNZLmpK51xe80XxAwT7rBRkUGsZNhcmMWSnHSyuY--meu_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] bnep: avoid use of caddr_t
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Natanael Copa <natanael.copa@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Natanael Copa <ncopa@alpinelinux.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natanael,

On Fri, Jan 17, 2014 at 2:08 PM, Natanael Copa <natanael.copa@gmail.com> wrote:
> caddr_t is legacy BSD and should be avoided.
>
> This fixes building against musl libc.

The patches looks good, but could please also add to the description
the actual errors you got.
