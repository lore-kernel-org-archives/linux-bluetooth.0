Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABD6X-Jc+CTn3gY4QkbLmRNVVnU47g3=851SfOW-B6+Hunf3bw@mail.gmail.com>
References: <1396518234-8375-1-git-send-email-marcin.kraglak@tieto.com>
	<CAJdJm_P+OjFYyggY4g_TTZJ7V1H7a46k45KntCZxnTwFRCE4ZA@mail.gmail.com>
	<CAJdJm_NYJ3+j-RNJK60CamCOCKkFHik9mZ4260P95PnQkPoE8A@mail.gmail.com>
	<CABD6X-Jc+CTn3gY4QkbLmRNVVnU47g3=851SfOW-B6+Hunf3bw@mail.gmail.com>
Date: Thu, 3 Apr 2014 16:04:52 -0400
Message-ID: <CAJdJm_NgGpr-DGHt8uNBx9doNL5U4zk5YFHLr7rHex3La1gWKQ@mail.gmail.com>
Subject: Re: [RFC] gatt: Add API for creating services
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

I'll split your answers to make sure I got everything addressed.

On Thu, Apr 3, 2014 at 3:12 PM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> about service changed - we have to manage it in daemon.

I could not find on the GATT server HAL API anything that is specific
do Service Changed notifications. So what I expect is that Android HAL
is implementing this internally after the app that implements a
service is closed/uninstalled.

> descriptors are added to characteristics, but api in android looks like this:
> 1. reserve handles for service
> 2. put attributes with reserved handles
>
> Therefore I propose to have method which can "commit" constructed
> service to ba available, something like start service. Similar method
> is present in android hal API.

So you are referring to the separate Add Service and Start Service
commands right? I agree we can have a separate commit procedure, at
least to allow concurrent applications registering services at the
same time. I'll include that on my RFC (should send tomorrow).

> About reallocating attributes to new handles - Android doesn't provide
> API to inform upper layer that we changed attribute's handle. I think
> if we want allocate handles for service, we should first look for
> 'holes' between existing services, and put it if there is available
> space. Therefore I proposed to declare num of handles needed for
> service while creating service.

This is aligned with the need for a "commit" operation so we allow
concurrent construction of services (see above). So I agree with you
on the need to pre-allocate a number of handles.

Regarding finding holes on the database, we can make it more efficient
if we keep track of free ranges in a separate structure, so we don't
need to traverse the attribute list every time.

> Creating groups looks good, but what will happen if two applications
> will start creating services in the same time, without declaring
> number of needed handles? We will probably need to 'reallocate' one of
> them and assign new handles. And Android won't handle it.

The attribute group concept is just a fancy generic name for services
and characteristics (taken from the Spec). So you can do the following
operations with the same gatt_db_add():

- Add a new service
- Add a characteristic to a service
- Add a descriptor to a characteristic

The other option is to have separate functions for these operations
(and a gatt_db_remove_service()).

I'll drop the "resize_group" function as it is unnecessary for now (if
we pre-allocate the range like described above).

>
> Idea of gatt-db which can be reused in both daemons is fine for me.
> Question is if existing skeleton of gatt.h/c is anything more than db?

The current upstream code indeed has only DB handling functions. But
we will introduce other code on that file that is not usable for
Android, so that's why I'm proposing factoring the database management
part to src/shared/gatt-db.{c,h}. You can think of src/gatt.c (in
future) as the equivalent to android/gatt.c (but in Linux we need to
do a lot more than in Android).

>
> @Anderson, did it clarify anything about android requirements?

I still have a few specific questions on Android side:

1) How is the "permissions" parameters for add characteristic/descriptor define?
2) How these permissions should be checked?
3) If you look at the "Add Descriptor" command, you do not provide a
characteristic declaration handle to it, only a service declaration
handle. How does it know to which characteristic to add the
descriptor?

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
