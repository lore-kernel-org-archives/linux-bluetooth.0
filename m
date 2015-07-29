Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: dogan yazar <doganyazar@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Advertising api - local name missing
Date: Wed, 29 Jul 2015 09:14:25 +0200
Message-ID: <3899290.gRdBhv36Rn@leonov>
In-Reply-To: <CANzaTi4UOpyNbUw=8-HTd+oM6_soOgf25hPW_FgruH_jCUYGMw@mail.gmail.com>
References: <CANzaTi4UOpyNbUw=8-HTd+oM6_soOgf25hPW_FgruH_jCUYGMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dogan,

On Tuesday 28 of July 2015 17:01:53 dogan yazar wrote:
> Advertising api does not have a field to set shortened or complete
> local name. Daemon sets the local name (bluetoothd[828]:
> src/adapter.c:local_name_changed_callback() Current alias: foo)
> but when I run test/example-advertisement the local name is not sent
> in the advertisement.
> Is this a deliberate design choice, or a bug or just a low priority
> feature to be implemented later?

Name and appearance would be placed in scan response. Kernel already allows to 
set flags for this but for some reason this is not exposed in D-Bus.
This is similar to TX Power which is exposed in D-Bus API so you may look at 
this if you are willing to add support for name.

Also note that first instance controller by kernel should already have local 
name included in scan response.

-- 
BR
Szymon Janc
