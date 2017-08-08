Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
References: <20170808084533.2323-1-michal.narajowski@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Aug 2017 14:20:15 +0300
Message-ID: <CABBYNZ+_vNbDJMNPZc=2=tX1iDjfuoRN81HBZ2=9HVP7o-D2YA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v6 00/11] monitor: Bluetooth 5 HCI commands support
To: =?UTF-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Tue, Aug 8, 2017 at 11:45 AM, Micha=C5=82 Narajowski
<michal.narajowski@codecoup.pl> wrote:
> This set adds support for decoding Bluetooth 5 commands as listed below.
>
> Changes since v1:
>  -squash patches as requested
>  -fix coding style issues and review comments
>  -add legacy pdu decoding
>
> Changes since v2:
>  -commit message cleanups
>
> Changes since v3:
>  -fix decoding of LE Extended Advertising Report Event
>  -add support for missing error codes
>  -fix decoding of LE Set Periodic Advertising Data
>
> Changes since v4:
>  -fix decoding of LE Set Extended Scan Parameters
>  -fix decoding of LE Set Extended Scan Enable
>  -fix decoding of LE Set Extended Advertising Data
>  -fix decoding of LE Set Extended Scan Response Data
>  -fix decoding of LE Set Periodic Advertising commands
>  -fix decoding of LE Extended Create Connection
>  -fix decoding of LE Set Extended Scan Parameters
>  -fix decoding of LE Set Extended Scan Enable
>  -fix decoding of connection latency
>  -refactor printing enable field
>  -refactor printing advertising channel map and filter policy
>  -fix coding style issues
>  -rename Directed Advertising Timeout to Advertising Timeout
>
> Changes since v5:
>  -fix typo in print_enable()
>  -remove indirect calls to print_enable()
>
> Micha=C5=82 Narajowski (11):
>   monitor: Add LE Enhanced Test commands decoding
>   monitor: Add LE Extended Advertising commands decoding
>   monitor: Add LE Set Periodic Advertising commands decoding
>   monitor: Add LE Extended Scan commands decoding
>   monitor: Add LE Periodic Advertising commands decoding
>   monitor: Add LE RF commands decoding
>   monitor: Add LE Set Privacy Mode decoding
>   monitor: Fix connection latency decoding
>   monitor: Add support for missing error codes
>   monitor: Rename Directed Advertising Timeout
>   monitor: Refactor print_enable function
>
>  monitor/bt.h     |  256 +++++++++
>  monitor/packet.c | 1676 +++++++++++++++++++++++++++++++++++++++---------=
------
>  2 files changed, 1463 insertions(+), 469 deletions(-)
>
> --
> 2.11.0

Applied, thanks.

--=20
Luiz Augusto von Dentz
