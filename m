Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1421064511-25894-1-git-send-email-gowtham.ab@samsung.com>
References: <1421064511-25894-1-git-send-email-gowtham.ab@samsung.com>
Date: Mon, 12 Jan 2015 14:47:14 -0200
Message-ID: <CABBYNZK8JSwD=QY0X2WqYxb8bvw=L215_G_k1+_jO0hYOSwzZw@mail.gmail.com>
Subject: Re: [PATCH 0/3] core: Fix ERROR CODES desc as per core_v4.2
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Mon, Jan 12, 2015 at 10:08 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Modified the error codes description as per core V4.2, Vol 2, Part D.
> Provided fix for checkpatch errors.
>
> Gowtham Anandha Babu (3):
>   monitor/packet: Fix ERROR CODES as per core_v4.2
>   parser/hci: Fix ERROR CODES as per core_v4.2
>   monitor/packet: Fix possbile checkpatch errors
>
>  monitor/packet.c   | 23 ++++++++++++-----------
>  tools/parser/hci.c |  6 +++---
>  2 files changed, 15 insertions(+), 14 deletions(-)
>
> --
> 1.9.1

Applied, thanks.



-- 
Luiz Augusto von Dentz
