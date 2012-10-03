Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121003193921.GA32176@x220.P-661HNU-F1>
References: <1349209490-31830-2-git-send-email-anderson.lizardo@openbossa.org>
	<1349268398-14620-1-git-send-email-anderson.lizardo@openbossa.org>
	<20121003193921.GA32176@x220.P-661HNU-F1>
Date: Wed, 3 Oct 2012 16:17:01 -0400
Message-ID: <CAJdJm_OtyC-Et9C0Cva3mej=3P9qq1823NdUdcyWT-pxrs7JWQ@mail.gmail.com>
Subject: Re: [PATCH v4 BlueZ 01/27] doc: Introduce Alert API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Oct 3, 2012 at 3:39 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Wed, Oct 03, 2012, Anderson Lizardo wrote:
>> This API will be implemented and initially used by Phone Alert Status
>> and Alert Notification GATT profiles (server role).
>> ---
>>
>> v4: Modify enumeration strings to use "-" as word separator.
>>
>>  Makefile.am       |    2 +-
>>  doc/alert-api.txt |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 110 insertions(+), 1 deletion(-)
>>  create mode 100644 doc/alert-api.txt
>
> Thanks. All patches from this set are now upstream. I also pushed one
> additional coding style patch since I didn't want to bother with another
> review round for such a large patch set (and please don't do these huge
> sets in the future - keep them under 10 or so).

Thanks! We'll try to keep future series under a reasonable size.
Unfortunately, this one aggregated features too fast while the API was
being defined, but we could have split at least the skeleton GATT
server stuff to send earlier.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
