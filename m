Return-Path: <Volker.Christian@fh-hagenberg.at>
From: Volker Christian <Volker.Christian@fh-hagenberg.at>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bug in hcid prevents naming of devices by =?iso-8859-1?q?means=09of_the_bluetooth-address_of_a?= device
Date: Mon, 16 Apr 2007 23:26:44 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <200704162036.15543.Volker.Christian@fh-hagenberg.at> <1176756867.30191.6.camel@aeonflux.holtmann.net>
In-Reply-To: <1176756867.30191.6.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704162326.45143.Volker.Christian@fh-hagenberg.at>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On Monday 16 April 2007 22:54, Marcel Holtmann wrote:
> Hi Volker,
>
> > the man-page of hcid.conf describes how to configure more than one
> > bluetooth devices installed on one machine.
> > It says:
> > ----------------------
> > nn:nn:nn:nn:nn:nn
> >
> >               Parameters  specified  within  this  section  will  be
> >               applied  to  the  device  with  this  device bluetooth
> >               address. All other parameters  are  applied  from  the
> >               default section.
> > ----------------------
> > This is broken in the current (3.9) and previous version of the
> > bluez-utils. The current debian-package is also affected.
> >
> > Following patch to main.c of the hcid fixis this problem:
> >
> > --- main.c-orig 2007-04-16 20:23:41.000000000 +0200
> > +++ main.c      2007-04-16 20:22:30.000000000 +0200
> > @@ -124,7 +124,7 @@
> >         struct hci_dev_info di;
> >
> >         /* First try to get BD_ADDR based settings ... */
> > -       if (!hci_devinfo(hdev, &di) < 0) {
> > +       if (!(hci_devinfo(hdev, &di) < 0)) {
> >                 char addr[18];
> >                 ba2str(&di.bdaddr, addr);
> >                 device_opts = find_device_opts(addr);
>
> does "if (hci_devinfo(hdev, &di) == 0) {" also work for you?
Yes, it also works, and it has to work. As i remember correctly, the return 
value of hci_devinfo is the return value of an ioctl-call which succeeds 
(return value 0). So hci_devinfo(...) == 0 does the job also.

regards
voc


>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
