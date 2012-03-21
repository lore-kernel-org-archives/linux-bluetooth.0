Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Mar 2012 09:43:34 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/6] att: add remote btd_device to ATT read/write
 callbacks
Message-ID: <20120321124334.GA8888@x220>
References: <1332147523-9984-1-git-send-email-arik@wizery.com>
 <1332147523-9984-2-git-send-email-arik@wizery.com>
 <20120320173640.GA16092@x220.amr.corp.intel.com>
 <CA+XVXffkOx_m11LouHnxqJp4AWNS9jLuUM-JcjgnEi68XWRs2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+XVXffkOx_m11LouHnxqJp4AWNS9jLuUM-JcjgnEi68XWRs2w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Tue, Mar 20, 2012, Arik Nemtsov wrote:
> On Tue, Mar 20, 2012 at 19:36, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Arik,
> >
> > On Mon, Mar 19, 2012, Arik Nemtsov wrote:
> >> -     uint8_t (*read_cb)(struct attribute *a, gpointer user_data);
> >> -     uint8_t (*write_cb)(struct attribute *a, gpointer user_data);
> >> +     uint8_t (*read_cb)(struct attribute *a, gpointer user_data,
> >> +                             gpointer device);
> >> +     uint8_t (*write_cb)(struct attribute *a, gpointer user_data,
> >> +                             gpointer device);
> >
> > Why is device a gpointer and not a struct btd_device *?
> 
> Well att.h is a self contained include file (also used in gatttool for
> example).

How then could any of these callbacks receive a pointer to btd_device
when used in gatttool? And if they're not used in gatttool it seems like
some refactoring may be in place here (i.e. there should be be a
library-like .h file and then something else for stuff which is bound to
bluetoothd-internal constructs (like btd_device).

> That means there would have to be at least a forward declaration for
> btd_device.  If we go down that road, it gets tricky, since we depend
> on the include order of att.h and device.h. This can maybe be solved
> with ifdef tricks, but I thinking leaving att.h self contained is the
> better option here.

In general we try to avoid double-include protections in internal .h
files. The convention is that .c files just have to include the
dependencies.

Johan
