Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413450936.29366.1.camel@linux-0dmf.site>
References: <Pine.LNX.4.44L0.1410151207020.1210-100000@iolanthe.rowland.org>
	<1413450936.29366.1.camel@linux-0dmf.site>
Date: Thu, 16 Oct 2014 16:24:02 +0530
Message-ID: <CAG0bkv+bu23Fm_thq7A5AOrCEXaaWmcKNaX-193GqFh=W0S8xA@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 16, 2014 at 2:45 PM, Oliver Neukum <oneukum@suse.de> wrote:
>
> On Wed, 2014-10-15 at 12:11 -0400, Alan Stern wrote:
> > > If the hub is the problem… what will be the better solution? Is it
> > > possible to change internal hub?
> >
> > No, it is not possible.
>
> Indeed. However, it is possible to use an additional in between your
> devices and the internal hub.
>
>         Regards
>                 Oliver
>
>


Tested with this configuration(external hubs Dev 3, Dev 4, Dev 17, Dev
10) and got the same result.

/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M

/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/2p, 480M

    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M

        |__ Port 5: Dev 3, If 0, Class=hub, Driver=hub/7p, 12M

            |__ Port 1: Dev 4, If 0, Class=hub, Driver=hub/7p, 12M

                |__ Port 1: Dev 11, If 0, Class=vend., Driver=, 12M

                |__ Port 2: Dev 12, If 0, Class=vend., Driver=, 12M

                |__ Port 3: Dev 13, If 0, Class=vend., Driver=, 12M

                |__ Port 4: Dev 14, If 0, Class=vend., Driver=, 12M

                |__ Port 5: Dev 15, If 0, Class=vend., Driver=, 12M

                |__ Port 6: Dev 16, If 0, Class=vend., Driver=, 12M

                |__ Port 7: Dev 17, If 0, Class=hub, Driver=hub/2p, 12M

                    |__ Port 1: Dev 21, If 0, Class=vend., Driver=, 12M

                    |__ Port 2: Dev 22, If 0, Class=vend., Driver=, 12M

            |__ Port 2: Dev 5, If 0, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 2: Dev 5, If 1, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 2: Dev 5, If 2, Class=app., Driver=, 12M

            |__ Port 3: Dev 6, If 0, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 3: Dev 6, If 1, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 3: Dev 6, If 2, Class=app., Driver=, 12M

            |__ Port 4: Dev 7, If 0, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 4: Dev 7, If 1, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 4: Dev 7, If 2, Class=app., Driver=, 12M

            |__ Port 5: Dev 8, If 0, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 5: Dev 8, If 1, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 5: Dev 8, If 2, Class=app., Driver=, 12M

            |__ Port 6: Dev 9, If 0, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 6: Dev 9, If 1, Class='bInterfaceClass 0xe0 not
yet handled', Driver=btusb, 12M

            |__ Port 6: Dev 9, If 2, Class=app., Driver=, 12M

            |__ Port 7: Dev 10, If 0, Class=hub, Driver=hub/3p, 12M

                |__ Port 1: Dev 18, If 0, Class='bInterfaceClass 0xe0
not yet handled', Driver=btusb, 12M

                |__ Port 1: Dev 18, If 1, Class='bInterfaceClass 0xe0
not yet handled', Driver=btusb, 12M

                |__ Port 1: Dev 18, If 2, Class=app., Driver=, 12M

                |__ Port 2: Dev 19, If 0, Class='bInterfaceClass 0xe0
not yet handled', Driver=btusb, 12M

                |__ Port 2: Dev 19, If 1, Class='bInterfaceClass 0xe0
not yet handled', Driver=btusb, 12M

                |__ Port 2: Dev 19, If 2, Class=app., Driver=, 12M

                |__ Port 3: Dev 20, If 0, Class='bInterfaceClass 0xe0
not yet handled', Driver=btusb, 12M

                |__ Port 3: Dev 20, If 1, Class='bInterfaceClass 0xe0
not yet handled', Driver=btusb, 12M

                |__ Port 3: Dev 20, If 2, Class=app., Driver=, 12M
