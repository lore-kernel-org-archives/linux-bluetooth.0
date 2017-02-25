Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1487981606-14150-1-git-send-email-juha.kuikka@synapse.com>
References: <1487981606-14150-1-git-send-email-juha.kuikka@synapse.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 25 Feb 2017 17:11:11 +0200
Message-ID: <CABBYNZJR3Tpi8CjSyZmThJYG5fQUxhe-ZndPbqujgr3H4BEpnw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix zero VID&PID on HoG initial connection
To: Juha Kuikka <juha.kuikka@synapse.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Juha Kuikka <juha.kuikka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juha,

On Sat, Feb 25, 2017 at 2:13 AM, Juha Kuikka <juha.kuikka@synapse.com> wrote:
> When a BLE HID-over-GATT (HoG) device is initially connected, the created uHID
> device has zero VID and PID, this is due to couple issues in how HoG handles
> Device Information Service (DIS).
>
> This patch set provices a fix for this.
>
> Juha Kuikka (3):
>   dis: Fix attribute handle when initializing from db
>   hog: Move dis_notify around
>   hog: When no VID&PID also register a DIS notifier
>
>  profiles/deviceinfo/dis.c | 21 ++++++++++++++++++++-
>  profiles/input/hog-lib.c  | 21 +++++++++++----------
>  2 files changed, 31 insertions(+), 11 deletions(-)
>
> --
> 2.7.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
