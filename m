Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
References: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Aug 2016 14:59:14 +0300
Message-ID: <CABBYNZ+1KgTRR6GdWd+k=-8Wtq36o0vKXY+HjjfWnGN-uHKmVQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/7] client: Add advertise support
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 11, 2016 at 3:14 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This changes adds command to manage advertisement data to bluetootctl.
>
> Note: This also fix the format of ManufacturerData and ServiceData that
> has been documented as being dictionaries but the implemention and sample
> has it more like a struct using fixed types instead of variant container
> so this would probably break any application using these properties.
>
> Luiz Augusto von Dentz (7):
>   core/advertising: Fix not parsing data properly
>   test/example-advertisement: Fix data format of properties
>   client: Add advertise command
>   client: Add set-advertise-uuids command
>   client: Add set-advertise-service command
>   client: Add set-advertise-manufacturer command
>   client: Add set-advertise-tx-power command
>
>  Makefile.tools             |   2 +
>  client/advertising.c       | 452 +++++++++++++++++++++++++++++++++++++++++++++
>  client/main.c              | 139 ++++++++++++++
>  src/advertising.c          |  24 ++-
>  test/example-advertisement |  12 +-
>  5 files changed, 613 insertions(+), 16 deletions(-)
>  create mode 100644 client/advertising.c
>
> --
> 2.7.4

Applied.


-- 
Luiz Augusto von Dentz
