Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1425996255-12146-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1425996255-12146-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 11 Mar 2015 16:03:17 +0200
Message-ID: <CABBYNZL=OvT7f1E6PfLk9PXaO93FT9z+8o8Nu-G5+jrRxaQ7Sg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] shared/gatt-client: Add support for
 prepare/execute write
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Mar 10, 2015 at 4:04 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> This is v5 of previous [PATCH 1/2] shared/gatt-client: Add write prepare and execute
>
> v2 handles comments from Luiz plus some clean ups.
>
> Main change is that gatt client can start reliable session by calling write prepare
> with id == 0. In return gatt client will get session id which should be used in
> following write prepare and execute write.
>
> This set also makes sure that on bt_gatt_client_cancel, reliable session will be
> correctly terminated.
>
> Last patch adds means to test this with btgatt-client
>
> v3:
> * Forgoten fixup on last patch now is merged.
>
> v4:
> * Fix parameters order pointed by Gowtham
>
> v5:
> * handles Luiz comments about moving write execute 0x00 to bt_gatt_client_cancel.
> *** BLURB HERE ***
>
> Lukasz Rymanowski (7):
>   tools/btgatt-client: Minor fix of menu alignment
>   shared/gatt-client: Add helper to cancel long write request
>   shared/gatt-client: Make usage of cancel_long_write_cb
>   shared/gatt-client: Add write prepare and execute
>   shared/gatt-client: Add coexistence of long write and prepare write
>   shared/gatt-client: Support cancel of prepare write
>   tools/btgatt-client: Add prepare and execute write
>
>  src/shared/gatt-client.c | 350 ++++++++++++++++++++++++++++++++++++++++++-----
>  src/shared/gatt-client.h |  12 ++
>  tools/btgatt-client.c    | 212 +++++++++++++++++++++++++++-
>  3 files changed, 540 insertions(+), 34 deletions(-)
>
> --
> 1.8.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
