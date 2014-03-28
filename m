Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1395999467-29192-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395999467-29192-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Fri, 28 Mar 2014 07:34:20 -0400
Message-ID: <CAJdJm_PGOZhZ1WZUMnZiNPiX0ntR-2fsark_2MtjPkuj=cYaFw@mail.gmail.com>
Subject: Re: [RFC v3] Add Support for Read Remote RSSI
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Mar 28, 2014 at 5:37 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> If we go with v3, then in Android case we will need to add more logic
> to bluetoothd to cover case when Application calles Read Remote Rssi
> only once. We just need to avoid letting kernel to poll without the reason.
> However I do expect android application to call this read remote rssi in
> a loop anyway.

One way to do that is to have a "timeout" timer (e.g. 5 seconds) that
is reset on each read_remote_rssi call from HAL. On this timer
expires, Unregister is called.

Note that the comment I made on the patch itself regarding configuring
the period for readings apply here: I think there should be some way
to set this period. Otherwise, a two small period (say, 1s) will be
wasting power for an application that reads only every 5s or 10s. Or
the contrary, a too long timer will make applications which read more
frequent receive inaccurate readings.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
