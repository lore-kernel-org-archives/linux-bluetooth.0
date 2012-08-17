Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <502E56DF.3020103@globaledgesoft.com>
References: <5008F67F.5030604@globaledgesoft.com>
	<CACJA=fUW4a-B-1SGQmPbh+J5YKJ9bVEFbz8ZUezPOD3w0Hmsxw@mail.gmail.com>
	<502E56DF.3020103@globaledgesoft.com>
Date: Fri, 17 Aug 2012 06:57:33 -0400
Message-ID: <CAJdJm_P=4fbHXG7gFpYQht9NmD88nixzO95N-HsgYwUOMx+pig@mail.gmail.com>
Subject: Re: BLE - multiple connections
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay KV <ajay.kv@globaledgesoft.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 17, 2012 at 10:36 AM, Ajay KV <ajay.kv@globaledgesoft.com> wrote:
> 1:  suppose device A  and B is in connected state (B as initiator  and A  as
> advertising mode)  , so obviously role change happens and A switches to
> slave mode .  meanwhile i wanted to  connect device C  to A (C as initiator
> and A as advertising mode) , since  A has switched to slave mode , it cant
> able to advertise again ( controller returns  error message " command
> disallowed") .  Even i tried to change the role  forcefully through hcitool
> command ,  the result was same.
>          My intention is to make  the device A as a server with multiple
> clients.  Currently im not using any of the profiles(ATT , GATT) . i want
> it to be done using L2CAP sockets

You need to check if your controller supports the LE state
combinations you are trying to use. Run "hciconfig hci0 lestates" And
check the supported states. Also see Core Spec v4.0 page 1096 for more
details.

Some controllers don't support LE scanning and LE advertising at the
same time, so make sure you don't have LE scanning enabled in "A"
while trying to re-enable advertising.

> 2. Is it possible to change the imtu  of the LE connection other than
> 23bits( which is hardcoded in L2cap driver)

I think this was fixed on more recent kernel releases. See patches
from Andre Guedes around May 31st (which are already upstream).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
