Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_Ng=92JbYvZHkMnvBJssRERqCsE3_bDwx+ZoymE7_B7ZQ@mail.gmail.com>
References: <1346164127-22102-1-git-send-email-anderson.lizardo@openbossa.org>
	<CAMOw1v4t_KVBW6dJXracXmKEyCcs3Jg3M82mEwJDvorTt2hV8Q@mail.gmail.com>
	<CAJdJm_Ng=92JbYvZHkMnvBJssRERqCsE3_bDwx+ZoymE7_B7ZQ@mail.gmail.com>
Date: Thu, 30 Aug 2012 09:16:49 -0400
Message-ID: <CAJdJm_MFeU1z2RaTiv1c5FeOs_RDZaLp8w6iG5Tmqhb_QZJTYw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: Fix build error due to O_CLOEXEC
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Aug 28, 2012 at 8:55 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> On Tue, Aug 28, 2012 at 8:15 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>>> +#define _GNU_SOURCE
>>
>> this should be already in our config.h. It seems like we are missing
>> the following in our configure.ac:
>>
>> AC_USE_SYSTEM_EXTENSIONS.
>>
>> Btw, we should remove the other definitions of _GNU_SOURCE
>
> Nice, I wasn't aware of this feature. Does it require any newer
> autoconf version?
>
> I can try this tomorrow and send a new patch set removing the
> _GNU_SOURCE defines.

I just sent a new patch using this macro (it exists since autoconf
2.60). Thanks for the heads up.

Johan: please apply the new patch "build: Use AC_USE_SYSTEM_EXTENSIONS
for POSIX/C extensions" instead of this one.

Thanks,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
