Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NYJ3+j-RNJK60CamCOCKkFHik9mZ4260P95PnQkPoE8A@mail.gmail.com>
References: <1396518234-8375-1-git-send-email-marcin.kraglak@tieto.com>
	<CAJdJm_P+OjFYyggY4g_TTZJ7V1H7a46k45KntCZxnTwFRCE4ZA@mail.gmail.com>
	<CAJdJm_NYJ3+j-RNJK60CamCOCKkFHik9mZ4260P95PnQkPoE8A@mail.gmail.com>
Date: Thu, 3 Apr 2014 21:12:37 +0200
Message-ID: <CABD6X-Jc+CTn3gY4QkbLmRNVVnU47g3=851SfOW-B6+Hunf3bw@mail.gmail.com>
Subject: Re: [RFC] gatt: Add API for creating services
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On 3 April 2014 16:01, Anderson Lizardo <anderson.lizardo@openbossa.org> wrote:
> Hi Marcin,
>
> On Thu, Apr 3, 2014 at 9:34 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> So here is my *personal* proposal: you create an attribute database
>> management API in src/shared (e.g. src/shared/gatt-db.c), which could
>> be shared by src/gatt.c and Android's android/gatt.c. This API would
>> reference attributes and attribute groups (i.e. services and
>> characteristics) by handle.
>>
>> This API needs functions for:
>> [...]
>
> BTW, If you guys agree this attribute database API may work well for
> Android needs, I'll proceed implementing an initial version and send
> patches to the list as RFC (so hopefully it becomes clearer with
> working source code). IMHO it helps both Android and Linux if we have
> code in src/shared that can be useful to both code bases.
>
> Best Regards,
> --
> Anderson Lizardo
> http://www.indt.org/?lang=en
> INdT - Manaus - Brazil

about service changed - we have to manage it in daemon.
descriptors are added to characteristics, but api in android looks like this:
1. reserve handles for service
2. put attributes with reserved handles

Therefore I propose to have method which can "commit" constructed
service to ba available, something like start service. Similar method
is present in android hal API.
About reallocating attributes to new handles - Android doesn't provide
API to inform upper layer that we changed attribute's handle. I think
if we want allocate handles for service, we should first look for
'holes' between existing services, and put it if there is available
space. Therefore I proposed to declare num of handles needed for
service while creating service.
Creating groups looks good, but what will happen if two applications
will start creating services in the same time, without declaring
number of needed handles? We will probably need to 'reallocate' one of
them and assign new handles. And Android won't handle it.

Idea of gatt-db which can be reused in both daemons is fine for me.
Question is if existing skeleton of gatt.h/c is anything more than db?

@Anderson, did it clarify anything about android requirements?

BR
Marcin
