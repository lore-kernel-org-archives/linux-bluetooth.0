Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0582BDEB-2274-4130-B13A-C122B86FFDAA@holtmann.org>
References: <CA+V-a8v1DaXL=S850KWaBt-ykDGr_533y8bAkpKq+NMoiVRncA@mail.gmail.com>
 <0582BDEB-2274-4130-B13A-C122B86FFDAA@holtmann.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 28 Sep 2015 10:32:40 +0100
Message-ID: <CA+V-a8sigPgaFM86uV804xO_4cBTUn==EQPLb1NySznCTdddwQ@mail.gmail.com>
Subject: Re: rfcomm sockets
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Sep 25, 2015 at 4:05 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Prabhakar,
>
>> I am using 5.34 bluez-5 stack on linux kernel version 3.14. when I
>> create rfcomm connection and do cat /dev/rfcomm0 and from other
>> terminal send AT commands to rfcomm0 I get proper response and other
>> characters continuously(> ??? ...) echoed from rfcomm0.
>> If I do the same from bluez4-101 I get proper response with no other characters.
>>
>> What is the proper way to do rfcomm communication ? I am trying to
>> connect to a OBD device via rfcom socket.
>
> the /dev/rfcomm0 is a TTY. You have to set it to the right mode (most cases raw mode) to make sure that no extra characters are inserted. If you use rfcomm connect command, then the --raw switch might help.
>
Thanks the raw flag did the trick.

Cheers,
--Prabhakar Lad
