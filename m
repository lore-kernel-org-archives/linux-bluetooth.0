Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOVeLGQe8FF0eGf0M0N2T34KsOK=HvPDDc5j+0TqSjToAdN4vQ@mail.gmail.com>
References: <CAOVeLGQe8FF0eGf0M0N2T34KsOK=HvPDDc5j+0TqSjToAdN4vQ@mail.gmail.com>
Date: Mon, 24 Feb 2014 16:51:40 -0400
Message-ID: <CAJdJm_MDhwB81Qb4aCLj8YJLOffroWqPZLzee6r=nejcoXgepA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix bluetooth.h for inclusion in clang projects
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Donald Carr <sirspudd@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Donald,

On Mon, Feb 24, 2014 at 12:38 PM, Donald Carr <sirspudd@gmail.com> wrote:
> From b12351dacb8e7fc44668ab4011db1d1b2b83e883 Mon Sep 17 00:00:00 2001
> From: Donald Carr <sirspudd@gmail.com>
> Date: Mon, 24 Feb 2014 08:34:46 -0800
> Subject: [PATCH] Move from typeof gcc intrinsic to __typeof__
>
> Change-Id: Ic3aa6ec1446876bfabdcc5e120ec327e177ffc74

I wonder why I'm not having any warnings when compiling BlueZ with
clang. Can you confirm which clang parameters are causing problems?

What I use is (when compiling bluez):

###
CC=clang ./bootstrap-configure
make
###

Regarding your patch, a few comments:

1) you should remove the "Change-Id" field (it is not used on BlueZ).
2) Your e-mail seems badly formatted (like as if you just copied one
email inside another). I suggest using "git send-email" for sending
properly formatted patches to the list.
3) The "Bluetooth:" subject prefix is only used for kernel patches.
For userspace patches, add a prefix which describes which part of the
code is affected (usually the subdirectory name is enough), in this
case:

lib: Move from typeof gcc intrinsic to __typeof__

4) A more verbose commit message would not hurt :)

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
