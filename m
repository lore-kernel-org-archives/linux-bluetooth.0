Return-Path: <lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
In-Reply-To: <FAED1DA6-7C0F-47A0-AA07-C392AB43AF67@holtmann.org>
References: <20171208124057.32162-1-lukasz.rymanowski@codecoup.pl> <FAED1DA6-7C0F-47A0-AA07-C392AB43AF67@holtmann.org>
From: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Date: Wed, 13 Dec 2017 10:51:55 +0100
Message-ID: <CAExxLLDKspz53LsjtmCOnwPS+Ds=RKEyxftH5nOk-h-tkE+abg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add support to advertise when connected
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

On 13 December 2017 at 09:42, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lukasz,
>
>> So far, kernel did not allow to advertise when there was a connection
>> established. With this patch kernel does allow it if controller
>> supports it.
>>
>> If controller supports non-connectable advertising when connected, then
>> only non-connectable advertising instances will be advertised.
>>
>> Signed-off-by: =C5=81ukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
>> ---
>> net/bluetooth/hci_request.c | 55 +++++++++++++++++++++++++++++++++++++--=
------
>> 1 file changed, 46 insertions(+), 9 deletions(-)
>
> patch has been applied to bluetooth-next tree.

Thanks
>
> I also assume that we will be getting mgmt-tester patches to verify the b=
ehavior.

:) yup, will do.

>
> Regards
>
> Marcel
>

=C5=81ukasz
