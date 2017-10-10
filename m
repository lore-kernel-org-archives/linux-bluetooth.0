Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvjcs-RSrdJVpqNhU8tcGxO0CPL4OG83L=Mkjb_nFv2EgvBZQ@mail.gmail.com>
References: <CALvjcs8EHZWsNd+wwcQ_XgdstpgLCpVa-Je-Xuo0PYq=anrtuw@mail.gmail.com>
 <CALvjcs-RSrdJVpqNhU8tcGxO0CPL4OG83L=Mkjb_nFv2EgvBZQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Oct 2017 11:19:12 +0300
Message-ID: <CABBYNZKiLm5x10Ax37eyP_DYVCtxaTS=4fnOuh8hmEN2=skknQ@mail.gmail.com>
Subject: Re: notification has not yet been cleaned in server side when ble is disconnected.
To: Yunhan Wang <yunhanw@nestlabs.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Tue, Oct 10, 2017 at 11:02 AM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
> Hi, Luiz
>
> Please ignore the previous email.
>
> I am seeing a bluez gatt notification problem in gatt-database.c
>
> Here is scenario:
>
> 1. Assume server has one characteristic A that is subscribed by client
> and sending notification,
> 2. Then ble connection is disconnected by client directly or
> connection disappear without unsubscribing A.
> 3. Client tries to connect to ble successfully
> 4. Client fails to subscribe that characteristic A although ble
> connection is ok.
> 5. Another retry to make Ble connection and subscribe to A can work.
>
> It seems ble disconnect at step 2 only disconnect ble connection and
> does not cleanup notify_io and stop
> notification in step 3 at code,
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c
>
> It seems retry in step 4 would trigger ccc_write_cb and release
> notify_io and stop notification so that step 5 would succeed.
> partial log from step 4:
> ccc_write_cb() External CCC write received with value: 0x0000
> pipe_hup() 0x921290 closed
>
> Any idea?

Do you have the full logs, this might be a bug since perhaps we
cleanup the notification itself though if the device is paired the
subscription should be persisted.

-- 
Luiz Augusto von Dentz
