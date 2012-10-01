Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAEd0BX9Mhz_SobzniiqXaXhEFC4gEaPfepubkY59TOpiCA+3ug@mail.gmail.com>
References: <5069401d.e758420a.0377.6163@mx.google.com>
	<CAEd0BX9Mhz_SobzniiqXaXhEFC4gEaPfepubkY59TOpiCA+3ug@mail.gmail.com>
Date: Mon, 1 Oct 2012 11:22:44 +0300
Message-ID: <CABBYNZJLgciDDAjppOYZpeQRrtX7zWyePRyg7Jr3sCGJ=9xz_g@mail.gmail.com>
Subject: Re: [PATCH] client: Add Message.MarkAsRead and Message.MarkAsDeleted
 implementation and documentation.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Venkateswaran, Srinivasa Ragavan"
	<srinivasa.ragavan.venkateswaran@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Srinivasa,

On Mon, Oct 1, 2012 at 10:14 AM, Venkateswaran, Srinivasa Ragavan
<srinivasa.ragavan.venkateswaran@intel.com> wrote:
> On Mon, Oct 1, 2012 at 12:33 PM,
> <srinivasa.ragavan.venkateswaran@intel.com> wrote:
>> From: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
>>
>> ---
>>  client/map.c       |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  client/transfer.c  |    3 +-
>>  doc/client-api.txt |   11 +++++
>>  3 files changed, 127 insertions(+), 2 deletions(-)
>
> Ignore this patch, this has a partial patch I was trying from Luiz.
> Sorry for the mess, sent an updated one.
>
> -Srini.

I just merged some fix last week so you would have to rebase your
changes, but I got some suggestions:

1. Use properties, so for setting delete/read the application should
use SetProperty method and it can get the values with GetProperties
and PropertyChanged to signal when the values has changed. (Note this
may change if we add support to standard D-Bus Properties interface
but the idea is the same just the interface change)
2. What is this filler byte and lseek for?
3. We probably need to add support for non-body/apparam only PUT so we
can pass NULL to filename. (maybe this is the reason for 2?)

-- 
Luiz Augusto von Dentz
