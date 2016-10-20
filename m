Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <580891D0.5000705@gmail.com>
References: <580891D0.5000705@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Oct 2016 12:58:29 +0300
Message-ID: <CABBYNZ+ccawCjfQVrS5Zvu4M5=N-_Mz_ozLr-Kz8YcF75DuJ5g@mail.gmail.com>
Subject: Re: Write queue is not processed after last write was not proper
To: Naresh <kbn456@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Naresh,

On Thu, Oct 20, 2016 at 12:43 PM, Naresh <kbn456@gmail.com> wrote:
> Hi,
>
> I've been writing ble client application using latest bluez version (5.42)
> and based on gatttool. We have some different requirement, so we didn't used
> D-Bus based API's as its not implement with D-BUS API's, Like we wanted to
> disable filter duplicate to receive all the advertisement(Even all the
> parameters are same) for proximity check and than connect and pair.
>
> We have used HCI layer api for getting advertisement with filter duplicate
> disabled and based on the BD address we connect using the Btio layer API
> than used gattrib API to perform read/write/Notification confirmation
> operations.

gattrib API is deprecated, you should use what is under src/shared
since that is what we unit test.

> We are performing some write/write_without operation continuously based on
> request by the our app(it kind of stress test) but after some write, its
> gets stuck I mean write queue is not being processed, there is no ATT logs
> once write is failed (returning some negative id) but write are being
> queued.
>
> We have debugged this issue in bluez and found that once wakeup_writer sets
> the io_set_write_handler for queued operation than set writer_active to
> true, after that write is performed and destroyer callback will set
> writer_active back to false.
>
> But in failed case before wakeup_writer being set writer_active to true, the
> write and destroy operation are being processed i.e writer_active never set
> to false and io_set_write_handler are never set for upcoming operations.
>
> I don't know what causing this scenario.

I guess the first thing to do is to attempt to reproduce with
bt_gatt_client API and have HCI traces so we can see where it fails,
perhaps it is even disconnecting in the meantime, but it shouldn't
queue them up.

-- 
Luiz Augusto von Dentz
