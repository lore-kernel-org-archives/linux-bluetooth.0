Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329813983-26707-8-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1329813983-26707-8-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 21 Feb 2012 13:51:30 +0200
Message-ID: <CABBYNZK_Ea2fGuoFHp29Gvk6qRaJ9HbvztXkZnzBzPo6ZdCxjw@mail.gmail.com>
Subject: Re: [PATCH obexd 7/9] client: expose obc_transfer_set_callback
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 21, 2012 at 10:46 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> This will allow setting the callback before the transfer is started,
> particularly to report queued transfer cancellations.

IMO making obc_transfer_register to take the callback and user_pointer
is better, we don't want anything to overwrite the callback.

-- 
Luiz Augusto von Dentz
