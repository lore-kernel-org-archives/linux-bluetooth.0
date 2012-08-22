Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <503503C1.6060805@globaledgesoft.com>
References: <5008F67F.5030604@globaledgesoft.com>
	<CACJA=fUW4a-B-1SGQmPbh+J5YKJ9bVEFbz8ZUezPOD3w0Hmsxw@mail.gmail.com>
	<502E56DF.3020103@globaledgesoft.com>
	<CAJdJm_P=4fbHXG7gFpYQht9NmD88nixzO95N-HsgYwUOMx+pig@mail.gmail.com>
	<502ED4E8.9040702@globaledgesoft.com>
	<CAJdJm_OBh4OzKJejongsaWm1mSx2GN5Yki3B4nYc6C2DbVS=nw@mail.gmail.com>
	<503503C1.6060805@globaledgesoft.com>
Date: Wed, 22 Aug 2012 06:40:10 -0400
Message-ID: <CAJdJm_Nj26JGoA6Hjd2kMbP-XSOsub65ZyjK3XB4ybh57D_+9A@mail.gmail.com>
Subject: Re: BLE - multiple connections
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay KV <ajay.kv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Wed, Aug 22, 2012 at 12:07 PM, Ajay KV <ajay.kv@globaledgesoft.com> wrote:
>         i could not able to figure it out  yet , why its  showing this error
> " command disallowed" . Here im using fedora 13 with kernel 2.6.39 . i tried

This kernel is too old. For sure a lot of LE stuff will not work
correctly on it. Can you try compiling your own kernel (latest
version) and use tha latest BlueZ version with it?

> with both dongles , iogear and cirago . But the result is same.  i dont
> think that  its something wrong with kernel version, as we  uses hci
> commands (hciconfig hci0 leadv ) that directly talks with controller .
> please clear this issue..

Sorry, but I ran out of ideas. Can you describe with more details
which exact steps are you taking to get the "command disallowed" HCI
error? I.e. right after you attach the dongle, which commands are you
issuing.

Also an hcidump showing the entire session (since the dongle is
attached) should help. Without more information we are not unable to
help further.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
