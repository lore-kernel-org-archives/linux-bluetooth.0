Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CDAF57F8-C541-42AF-8FEE-47A5221DF63A@holtmann.org>
References: <CAKafyqoTVzbVv1Wk21wRSjxyH68bL+gCT_0qF9fvmUWnqkgEeg@mail.gmail.com>
	<CDAF57F8-C541-42AF-8FEE-47A5221DF63A@holtmann.org>
Date: Wed, 22 Jul 2015 11:28:17 +0530
Message-ID: <CAKafyqrhmNKOX258_cH_iYiOi=ALVTVzvxfEd4_HXGJrnHrpuQ@mail.gmail.com>
Subject: Re: Bluez-Android: L2CAP Socket Communication over
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mercel,

   I am not looking to add it to AOSP. Could you please add some more
information If I want to add it for native application.

Thanks for your inputs ..

ManyThanks,
Prabhu

On Fri, Jun 19, 2015 at 6:19 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Prabhu,
>
>>  Currently, I see only rfcomm sockets, I want L2CAP socket
>> communication for my use case.
>>
>> I am looking to add this support.  Share me your views on this.
>
> should be pretty straight forward to add to BfA. However getting support into Bluetooth Service into AOSP might be a bit more trickier. Native application of course can always open the L2CAP socket directly.
>
> Regards
>
> Marcel
>
