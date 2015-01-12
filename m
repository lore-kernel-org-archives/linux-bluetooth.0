Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
References: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
Date: Mon, 12 Jan 2015 10:34:03 -0200
Message-ID: <CABBYNZ+5EHXEL8H7+pgnJWNih72fu_k2Qu6tJ9G7eQCfyJD-_A@mail.gmail.com>
Subject: Re: [PATCH 0/6] L2CAP control field + AVRCP browsing PDU parsing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Wed, Jan 7, 2015 at 6:23 AM, Vikrampal Yadav <vikram.pal@samsung.com> wrote:
> Support for parsing L2CAP extended control field and
> AVRCP SetBrowsedPlayer added in Bluetooth monitor.
>
> Vikrampal Yadav (6):
>   monitor: Make the parameter name generic
>   monitor: Add functionality to store extented control in DB
>   monitor: Extract extended L2CAP extended control field
>   monitor: Add support for parsing L2CAP extended control field
>   monitor: Add support for parsing L2CAP control field
>   monitor: Add AVRCP SetBrowsedPlayer support
>
>  monitor/avctp.c |  86 +++++++++++++++++++-
>  monitor/l2cap.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 319 insertions(+), 6 deletions(-)
>
> --
> 1.9.1

Applied, thanks. Please make sure you follow the coding style, I had
to fix a few lines that were over 80 columns.


-- 
Luiz Augusto von Dentz
