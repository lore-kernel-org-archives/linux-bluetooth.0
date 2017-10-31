Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJBUqbMijwCqB=4xQa3sq1qL1YdZ710-o8WVEDL7rR27Q@mail.gmail.com>
References: <CAOVXEJJirxBj+Pb203j2orSBhTxv5tzdvAqKcuhzO1W_2bhpFQ@mail.gmail.com>
 <CABBYNZJBUqbMijwCqB=4xQa3sq1qL1YdZ710-o8WVEDL7rR27Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 31 Oct 2017 09:23:00 +0200
Message-ID: <CABBYNZ+cj0UpcGYX42+wiW4FKYDYGf7Njg=wQQXwW8jn3gY05A@mail.gmail.com>
Subject: Re: How to change default MTU for Obex over L2CAP
To: Sathish Narasimman <nsathish41@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sathish,

On Tue, Oct 31, 2017 at 9:05 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Sathish,
>
> On Tue, Oct 31, 2017 at 5:30 AM, Sathish Narasimman
> <nsathish41@gmail.com> wrote:
>> Hi,
>>
>> I am trying to do an OPP transfer between 2 Linux bluez system.
>> It is always selecting the 672 MTU size during configuration.
>>
>> May I please know how to change the MTU size.
>
> It looks like for L2CAP we don't set the MTU properly but for RFCOMM we do:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/obexd/client/bluetooth.c#n129
>
> I will send a patch in a moment.

Actually, it is the other way around, the RFCOMM don't actually
support setting the MTU since it is a stream, though we should
probably adjust the socket buffer size since we are using 32k for
OBEX.

-- 
Luiz Augusto von Dentz
