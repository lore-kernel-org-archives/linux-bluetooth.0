Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120320173640.GA16092@x220.amr.corp.intel.com>
References: <1332147523-9984-1-git-send-email-arik@wizery.com>
 <1332147523-9984-2-git-send-email-arik@wizery.com> <20120320173640.GA16092@x220.amr.corp.intel.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Tue, 20 Mar 2012 19:48:20 +0200
Message-ID: <CA+XVXffkOx_m11LouHnxqJp4AWNS9jLuUM-JcjgnEi68XWRs2w@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] att: add remote btd_device to ATT read/write callbacks
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 20, 2012 at 19:36, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Arik,
>
> On Mon, Mar 19, 2012, Arik Nemtsov wrote:
>> -     uint8_t (*read_cb)(struct attribute *a, gpointer user_data);
>> -     uint8_t (*write_cb)(struct attribute *a, gpointer user_data);
>> +     uint8_t (*read_cb)(struct attribute *a, gpointer user_data,
>> +                             gpointer device);
>> +     uint8_t (*write_cb)(struct attribute *a, gpointer user_data,
>> +                             gpointer device);
>
> Why is device a gpointer and not a struct btd_device *?

Well att.h is a self contained include file (also used in gatttool for
example). That means there would have to be at least a forward
declaration for btd_device.
If we go down that road, it gets tricky, since we depend on the
include order of att.h and device.h. This can maybe be solved with
ifdef tricks, but I thinking leaving att.h self contained is the
better option here.

Thoughts?

>
> Also, user_data should be the last parameter as per GLib conventions.

Sure. I can change this.

Arik
