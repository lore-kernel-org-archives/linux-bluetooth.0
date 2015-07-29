Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: Advertising api - local name missing
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3899290.gRdBhv36Rn@leonov>
Date: Wed, 29 Jul 2015 15:49:01 +0200
Cc: dogan yazar <doganyazar@gmail.com>, linux-bluetooth@vger.kernel.org
Message-Id: <574E465E-380B-4680-97B1-2FAB9E11D947@holtmann.org>
References: <CANzaTi4UOpyNbUw=8-HTd+oM6_soOgf25hPW_FgruH_jCUYGMw@mail.gmail.com> <3899290.gRdBhv36Rn@leonov>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>> Advertising api does not have a field to set shortened or complete
>> local name. Daemon sets the local name (bluetoothd[828]:
>> src/adapter.c:local_name_changed_callback() Current alias: foo)
>> but when I run test/example-advertisement the local name is not sent
>> in the advertisement.
>> Is this a deliberate design choice, or a bug or just a low priority
>> feature to be implemented later?
> 
> Name and appearance would be placed in scan response. Kernel already allows to 
> set flags for this but for some reason this is not exposed in D-Bus.
> This is similar to TX Power which is exposed in D-Bus API so you may look at 
> this if you are willing to add support for name.
> 
> Also note that first instance controller by kernel should already have local 
> name included in scan response.

have you checked the supported advertising flags by the kernel. I think we do not support the name inclusion by the kernel. Meaning bluetoothd would have to do that for us and manually put it in the scan response data.

This is something that could be added to the kernel. It is specified by mgmt-api.txt, but not implemented yet.

Regards

Marcel

