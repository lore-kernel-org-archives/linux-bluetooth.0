Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ChEt6IevVUjWIxK8LSxd-_mQL47nxsrsmQXAUtJ4vB8vApY4ILVJUlDFpKNfSxStiYamZxKZhRmVy9LWpyDlSM3R5LyJzjv5qIVXuKp-NAY=@krauser.org>
References: <ChEt6IevVUjWIxK8LSxd-_mQL47nxsrsmQXAUtJ4vB8vApY4ILVJUlDFpKNfSxStiYamZxKZhRmVy9LWpyDlSM3R5LyJzjv5qIVXuKp-NAY=@krauser.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Jul 2018 20:07:46 +0300
Message-ID: <CABBYNZ+w1YQ27iESgxXqJayn8WLSKTWXx4EM9iZHwCWLqX-t3w@mail.gmail.com>
Subject: Re: [PATCH v4 BlueZ 0/3] Provide MTU on GATT reads and writes.
To: David Krauser <david@krauser.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Mon, Jul 9, 2018 at 7:24 PM, David Krauser <david@krauser.org> wrote:
> These patches will append the negotiated MTU to the options
> dictionary that is provided over DBus on characteristic reads
> and writes.
>
> These will also allow a user to configure the max mtu in main.conf
>
> v2: Lowercase "MTU" in options dict and mark old key as deprecated.
> v3: Fix mangled whitespace. Renamed two options in main.conf
> v4: Removing deprecated options
>
> David Krauser (3):
>   src: provide MTU on GATT value reads and writes
>   doc: provide MTU on GATT value reads and writes
>   src: make att le mtu configurable in main.conf
>
>  doc/gatt-api.txt    |  6 ++++--
>  src/device.c        |  2 +-
>  src/gatt-database.c | 23 +++++++----------------
>  src/hcid.h          |  1 +
>  src/main.c          | 22 +++++++++++++++++++---
>  src/main.conf       |  9 +++++++--
>  6 files changed, 39 insertions(+), 24 deletions(-)
>
> --
> 2.18.0

Ive made some changes and applied this set, the options are now
ExchangeMTU and KeySize.

-- 
Luiz Augusto von Dentz
