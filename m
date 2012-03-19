Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331559165-28367-6-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1331559165-28367-6-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 19 Mar 2012 10:09:13 -0300
Message-ID: <CABBYNZKKWhEXvULPUpTp6bRPfUV+QeX2nVZbdNJVPFFL6mSPvw@mail.gmail.com>
Subject: Re: [PATCH obexd v0 05/11] client: transfer api merges put and get
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel

On Mon, Mar 12, 2012 at 10:32 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> A new enum type is used to distinguish put and get transfers.
>
> This is more convenient since it is done when registering the transfer,
> and not when it is actually started. The main benefits would be:
>    - Some actions can be taken during creation, such as opening files.
>    - session.c gets simplified.
>    - The size of a put transfer can be exposed in D-Bus, while queued.
>    - The type of transfer (put or get) can be exposed in D-Bus.
>
> None of these D-Bus changes are included in this patch.

In this case I would prefer register_put/register_get instead of yet
another parameter and a enum with 2 values.

-- 
Luiz Augusto von Dentz
