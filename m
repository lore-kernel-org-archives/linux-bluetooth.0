Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Sep 2013 10:07:25 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 04/16] android: Start Android Bluetooth daemon
Message-ID: <20130930070723.GA10262@aemeltch-MOBL1>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1380291161-10232-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <9A70E0AA-C658-4B1D-8040-DD483CCD6047@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9A70E0AA-C658-4B1D-8040-DD483CCD6047@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 29, 2013 at 03:28:44PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Start Android Bluetooth daemon from HAL init(). Make sure
> > that daemon is in "running" state.
> > ---
> > android/hal_bluetooth.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++-
> > 1 file changed, 53 insertions(+), 1 deletion(-)
> > 
> > diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
> > index 5298618..036091e 100644
> > --- a/android/hal_bluetooth.c
> > +++ b/android/hal_bluetooth.c
> > @@ -23,11 +23,16 @@
> > #include <hardware/bluetooth.h>
> > #include <hardware/bt_sock.h>
> > 
> > +#include <cutils/sockets.h>
> > +#include <cutils/properties.h>
> > +
> > #define LOG_TAG "BlueZ"
> > #include <cutils/log.h>
> > 
> > #include "hal.h"
> > 
> > +#define ANDROID_BLUEZ "bluezd"
> > +
> 
> the name changes to either "btd" or "bluetoothd". We need to pick one, but it is not suppose to be "bluezd".

this is the name of the service as it named in init.rc, so if bluetoothd
is the name of the daemon executable then I name service as btd.

Maybe I change ANDROID_BLUEZ to ANDROID_BLUEZ_SVC ?

> 
> > bt_callbacks_t *bt_hal_cbacks = NULL;
> 
> This needs to be public?

Yes, they would be called from callback thread and, possibly, from here.

Best regards 
Andrei Emeltchenko 
