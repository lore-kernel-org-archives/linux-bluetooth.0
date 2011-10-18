Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1318953068.15441.124.camel@aeonflux>
References: <1318925545-4128-1-git-send-email-luiz.dentz@gmail.com>
	<1318953068.15441.124.camel@aeonflux>
Date: Wed, 19 Oct 2011 01:04:41 +0300
Message-ID: <CABBYNZK5zgFWkQa3nuGWjMXQqYL59aBseFFrPa0zy8M01OBwgA@mail.gmail.com>
Subject: Re: [PATCH obexd] gobex: add missing checks for config.h
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 18, 2011 at 6:51 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>> =A0gobex/gobex-defs.c =A0 | =A0 =A04 ++++
>> =A0gobex/gobex-header.c | =A0 =A04 ++++
>> =A0gobex/gobex-packet.c | =A0 =A04 ++++
>> =A03 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/gobex/gobex-defs.c b/gobex/gobex-defs.c
>> index f1f3b38..beb773d 100644
>> --- a/gobex/gobex-defs.c
>> +++ b/gobex/gobex-defs.c
>> @@ -19,6 +19,10 @@
>> =A0 *
>> =A0 */
>>
>> +#ifdef HAVE_CONFIG_H
>> +# include "config.h"
>
> what is this space between # and include doing here. Please remove that.
>
> And it is <config.h> and not "config.h".

Copy/paste, well I guess while Im at it I can change all other places
to be consistent with what you are saying.

--=20
Luiz Augusto von Dentz
