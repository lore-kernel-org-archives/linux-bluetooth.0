Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1395999467-29192-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395999467-29192-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Tue, 22 Apr 2014 12:29:19 +0200
Message-ID: <CAMudyAurKOVaruq807qNPs9=vJeahZ2_DbjBe6AT31drCQbezg@mail.gmail.com>
Subject: Re: [RFC v3] Add Support for Read Remote RSSI
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping

On 28 March 2014 10:37, Lukasz Rymanowski <lukasz.rymanowski@tieto.com> wrote:
> v2: Idea in this version is to start/stop read remote RSSI only
> when device is connected.
> In this version there is possibility to read one time RSSI value.
>
> v3: Idea is to register/unregister for RSSI Changed event any time.
> Kernel to handle polling and notify userspace if given threshold has
> been exceeded.
>
> If we go with v3, then in Android case we will need to add more logic
> to bluetoothd to cover case when Application calles Read Remote Rssi
> only once. We just need to avoid letting kernel to poll without the reason.
> However I do expect android application to call this read remote rssi in
> a loop anyway.
>
> To consider in v3: Do we need Unregister command or we can use Register
> command with threshold equal to 0 as a unregister ?
>
> Lukasz Rymanowski (1):
>   mgmt-api: Add support for Read Remote RSSI
>
>  doc/mgmt-api.txt | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> --
> 1.8.4
>
\Łukasz
