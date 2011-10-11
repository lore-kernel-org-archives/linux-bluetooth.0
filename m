Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBf7fXR61TRGoKx6N0kKerXdmewphL-yu3J6vJjqbehNkA@mail.gmail.com>
References: <1318359533-7640-1-git-send-email-padovan@profusion.mobi>
	<CAKT1EBf7fXR61TRGoKx6N0kKerXdmewphL-yu3J6vJjqbehNkA@mail.gmail.com>
Date: Tue, 11 Oct 2011 16:28:51 -0400
Message-ID: <CAJdJm_N6L5bYctkivfDgfPnuHEATwgLC+d4gDW+5P1iRP5+vPQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix permission of enable_le param
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 11, 2011 at 3:33 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> On Tue, Oct 11, 2011 at 3:58 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
>> With 0444 it is impossible to change the param, changing it to 0644.
>
> If you allow changing the "enable_le" parameter dynamically it is also
> necessary check the controller features and update the LE host
> supported bit(if necessary).
> I am afraid that allowing to change it dynamically will break the
> consistency: what is gonna happen with the active operations(discovery
> & connections)?
>
> In our backlog we were planning to check LE host supported bit to
> allow/block LE connections or any other feature related to LE.

For me, it makes more sense to have bluez set LE host supported bit on
start, and have no "enable_le" module parameter at all.

I think just allowing to change enable_le after the module has been
loaded will not work as expected.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
