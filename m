Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MaTBC+bT-aTbKPPDQrziq4WJArow_ERbzRiq54pp+ZJg@mail.gmail.com>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1368073016-28434-5-git-send-email-lucas.demarchi@profusion.mobi> <CAJdJm_MaTBC+bT-aTbKPPDQrziq4WJArow_ERbzRiq54pp+ZJg@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 9 May 2013 09:15:26 -0300
Message-ID: <CAMOw1v5GdFxwmNJX9U+9HTmSRi-FkOhLaSFSU0YQ9WKeosvvMw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 05/26] attrib: Get rid of guint* types
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Thu, May 9, 2013 at 7:55 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Lucas,
>
> On Thu, May 9, 2013 at 12:16 AM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> diff --git a/attrib/gatt.h b/attrib/gatt.h
>> index 305b4c6..d5758b7 100644
>> --- a/attrib/gatt.h
>> +++ b/attrib/gatt.h
>> @@ -22,6 +22,7 @@
>>   *
>>   */
>>
>> +#include <inttypes.h>
>>  #include <bluetooth/sdp.h>
>
> We used to avoid adding includes into headers, and instead add them on
> the .c files only. (The existing include above is a unfortunate
> exception). Not sure if this convention has changed since.

Sure, but when you use a certain type in header you need the header
(or if it's a pointer you have the option to do a forward declaration,
but it's not the case here). If you don't do this you depend on the
include order in each .c, risking to break the build, which is way
worse.

Lucas De Marchi
