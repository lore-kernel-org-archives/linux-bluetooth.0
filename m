Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Fri, 31 Aug 2012 12:17:18 -0400
Message-ID: <CAJdJm_OxOaVeU=WS5RfprUBOj4wsoMMVwS9vH8S7ogxR1QPdsw@mail.gmail.com>
Subject: Re: [PATCH 0/7] RFC: proximity cleanup
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Fri, Aug 31, 2012 at 8:48 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Hi,
>
> Here are few patches to cleanup proximity profile code a bit which seem to
> keep track of some data which are redundant and has minor issue with device
> driver registration.
>
> Most cleanup is done in patch #3 which removes tracking of DBusConnection
> across whole plugin and simply uses get_dbus_connection() wherever necessary.
> This is different than other profile plugins do, but reduces code size and
> memory footprint a bit so can be done for other plugins as well if accepted.

While some cleanups here are very welcome, I'm worried that you are
cleaning up things before finishing the Proximity Reporter
implementation. Power Level characteristic for instance is currently a
stub, how do you plan to store it per adapter, without the struct
reporter_adapter?

Therefore I suggest you split the "trivial" cleanups from the removal
of struct reporter_adapter.

BTW, do you have plans to add more features to the Proximity Reporter
implementation?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
