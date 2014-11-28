Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
References: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
Date: Fri, 28 Nov 2014 10:37:00 +0200
Message-ID: <CABBYNZJSxCADaEU5XLRaTUGY0AGu+8s_B+ojSAymszWiJNDNiw@mail.gmail.com>
Subject: Re: [PATCH 0/7] L2CAP control field + AVRCP browsing PDU parsing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Fri, Nov 21, 2014 at 3:47 PM, Vikrampal Yadav <vikram.pal@samsung.com> wrote:
> Support for ERTM control bytes adjustment, parsing L2CAP extended control
> field and AVRCP SetBrowsedPlayer added in Bluetooth monitor.
>
> Vikrampal Yadav (7):
>   monitor: Adjust for ERTM control bytes
>   monitor: Make the parameter name generic
>   monitor: Add functionality to store extented control in DB
>   monitor: Extract extended L2CAP extended control field
>   monitor: Add support for parsing L2CAP extended control field
>   monitor: Add support for parsing L2CAP control field
>   monitor: Add AVRCP SetBrowsedPlayer support
>
>  monitor/avctp.c |  86 +++++++++++++++++++-
>  monitor/l2cap.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 322 insertions(+), 6 deletions(-)
>
> --
> 1.9.1

Sorry for the delay, this one got lost in my inbox, most patches seems
to be missing the output they generate, could you please add it.


-- 
Luiz Augusto von Dentz
