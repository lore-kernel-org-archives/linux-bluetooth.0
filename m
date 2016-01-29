Return-Path: <beaufort.francois@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CC3EE005-1971-4FA6-8C44-BD5FDDA01ED0@holtmann.org>
References: <CAEZxfGMJZva2Rmfm4P8D+zTnY7RbvaaA-e3R3SxoLycuD9D==A@mail.gmail.com>
 <CAD0=r8zoEbgP_XhA6j7Jz2RJ0jUNVirQL74vfqPX7dRtziWyOA@mail.gmail.com>
 <CAEZxfGOmyVm2-LsdjcYK8LXaQ7TFnBJCmKt3wXtPkurepDR-OA@mail.gmail.com> <CC3EE005-1971-4FA6-8C44-BD5FDDA01ED0@holtmann.org>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Fri, 29 Jan 2016 13:56:08 +0100
Message-ID: <CAEZxfGO63XEdkW6KFCSjn6XfF=hAUWgYJ62vwF+Sgpc6Uc6sDA@mail.gmail.com>
Subject: Re: Two connect failed...
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you Marcel!

On Fri, Jan 29, 2016 at 12:07 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Francois,
>
>> Reducing APP_ADV_INTERVAL to 400 (instead of 1600) makes the "LE
>> Create Connection" work every single time now.
>>
>> Hopefully with bluetooth-next update in Chrome OS
>> (https://code.google.com/p/chromium/issues/detail?id=576577#c20) and
>> especially https://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=2f99536a5b34d5b0f54723067d68f6cef3f0fdc6,
>> we won't have to set a smaller Advertising Interval as it reduces
>> battery's life.
>>
>> Do you maybe have another recommendation while it reaches Stable channel?
>
> I highly doubt there is anything else that can be done. I would cherry pick that single patch and backport it into the Chrome OS kernel.
>
> Regards
>
> Marcel
>
