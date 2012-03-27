Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120327115530.GJ14481@x220>
References: <1332782979-27081-1-git-send-email-anderson.lizardo@openbossa.org>
	<20120327115530.GJ14481@x220>
Date: Tue, 27 Mar 2012 08:17:56 -0400
Message-ID: <CAJdJm_NtQftxpNer08aHw-5F4et+URNMe-UULakrQYvRL_ECgA@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ] event: Remove unused dev_class parameter from btd_event_conn_complete()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Mar 27, 2012 at 7:55 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Mon, Mar 26, 2012, Anderson Lizardo wrote:
>> This parameter is not being used by hciops nor mgmtops.
>> ---
>>  plugins/hciops.c  |    5 ++---
>>  plugins/mgmtops.c |    3 +--
>>  src/event.c       |    2 +-
>>  src/event.h       |    2 +-
>>  4 files changed, 5 insertions(+), 7 deletions(-)
>
> The right fix is to make use of this parameter instead of removing it.
> If btd_device has a variable for it, it should be updated and we should
> also write it to storage.

Ok, I'll follow this approach and send another patch. You can discard this one.

>
> Johan

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
