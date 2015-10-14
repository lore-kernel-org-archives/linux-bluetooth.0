Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGXr9JEe-k+WDTAH3fu0-SK18BV2J=w00OWcCsYhirJB1vv36A@mail.gmail.com>
References: <CAGXr9JEe-k+WDTAH3fu0-SK18BV2J=w00OWcCsYhirJB1vv36A@mail.gmail.com>
Date: Wed, 14 Oct 2015 10:49:26 +0300
Message-ID: <CABBYNZ+e+agNGpw=VseUV393--pWLA_KtW-AiUWL8oDQs4t2AQ@mail.gmail.com>
Subject: Re: Why does BlueZ remove BLE device services with disconnect reason 0?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Tue, Oct 13, 2015 at 8:59 PM, Petri Gynther <pgynther@google.com> wrote:
> linux-bluetooth:
>
> I'm seeing the following issue with BlueZ 5.30 and BLE HoG remote control:
>
> The BLE HoG device is already paired and been able to reconnect to
> BlueZ host previously.
> But, every once in a while, the reconnect fails with "Reason:
> Connection Failed to be Established (0x3e)" -> reason 0
> (MGMT_DEV_DISCONN_UNKNOWN).
> That causes BlueZ to remove all services of this HoG device
> (disconnected -> unavailable), and after that, the HoG device is
> useless on any future reconnect attempts.
>
> Question:
> Why does BlueZ tear down all services of a BLE device when there is an
> intermittent connection error with reason 0
> (MGMT_DEV_DISCONN_UNKNOWN)?

IT is probably because in 5.30 we used to cleanup the database if the
discovery failed.

> This obviously does not happen in the normal case when the disconnect
> reason is 3 (MGMT_DEV_DISCONN_REMOTE).
> Can someone point me to the relevant code? I need to prevent this BLE
> service tear-down.

Check the git history, I think we fixed that already, or even better
use 5.35 that has persistent caching so the services are only removed
if you remove the device.

-- 
Luiz Augusto von Dentz
