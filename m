Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335776199-16704-5-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335776199-16704-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1335776199-16704-5-git-send-email-mikel.astiz.oss@gmail.com>
Date: Wed, 2 May 2012 15:21:20 +0300
Message-ID: <CABBYNZ+7_YJjgWfewiFQ0fsf+m=ZcKOVn8GUB6RvskfYsqkXdw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/6] media: Split media_endpoint_create
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Apr 30, 2012 at 11:56 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> This function is starting to be too long and needs to be split.
>
> After this patch, the resulting code should be exactly equivalent as the
> previous implementation.
> ---
>  audio/media.c |  119 +++++++++++++++++++++++++++++++++++++-------------------
>  1 files changed, 78 insertions(+), 41 deletions(-)

This one also has the email set to gmail.


-- 
Luiz Augusto von Dentz
