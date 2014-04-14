Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
Date: Mon, 14 Apr 2014 11:10:07 -0300
Message-ID: <CAKT1EBejHQfJZtqWu1+fBeCja_JwSSSnHrbERu4ufQSfyvXaWA@mail.gmail.com>
Subject: Re: [RFC 00/16] Gatt database initial implementation
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Apr 9, 2014 at 4:06 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> This is proposal how gatt database implementation could look and
> how it can be used in Android. Current implementation contains:
>  - create/destroy gatt_db
>  - adding services, with given number of handles. This function returns
>         service attribute andle
>  - adding characteristics, descriptors and included services
>  - function to start/stop service - it will be used when we expose services
>         to client
>
> Next steps in gatt_db implementation should be:
>  - handling read/write callbacks
>  - handling attribute's permissions
>  - now we just increment available handle. We should check if we have free handles
>         between existing services
>
> Comments are welcome
> Marcin Kraglak

IMO, the database could be used to represent both: local and remote. I
am not familiar with Android BlueZ storage, does it make sense to have
a common storage for attributes declarations (remote attribute
caching)?

When the GATT service is local, we need to store the mapping between
handles and applications(or UUIDs). Remember that CCC storage is per
device. For remote attribute caching, we will need to store the
declarations only.

Regards,
Claudio
