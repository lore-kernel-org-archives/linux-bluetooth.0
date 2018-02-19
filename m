Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
References: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Feb 2018 12:40:33 +0200
Message-ID: <CABBYNZ+hyywcy7tLQ5cG61+ivzWp7SCy24FHv6z=FOwrNhyyYw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/7] Improve ad service and add ad clear
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Fri, Feb 16, 2018 at 7:44 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> The new clear command clears advertise configuration explicitly.
>
> ERAMOTO Masaya (7):
>   client: Fix null output for ad service uuid
>   client: Not output ad service info if no uuid sets
>   client: Fix data growth if reconfiguring ad service
>   client: Improve help messages for advertise
>   client: Introduce data_clear() calling ->clear()
>   client: Introduce ad_disable_{uuids,service,manufacturer}
>   client: Add clear command for advertise
>
>  client/advertising.c |  50 ++++++++++++++++++---
>  client/advertising.h |   3 ++
>  client/main.c        | 123 +++++++++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 152 insertions(+), 24 deletions(-)
>
> --
> 2.14.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
