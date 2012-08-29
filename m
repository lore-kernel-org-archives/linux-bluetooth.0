Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v4t_KVBW6dJXracXmKEyCcs3Jg3M82mEwJDvorTt2hV8Q@mail.gmail.com>
References: <1346164127-22102-1-git-send-email-anderson.lizardo@openbossa.org>
	<CAMOw1v4t_KVBW6dJXracXmKEyCcs3Jg3M82mEwJDvorTt2hV8Q@mail.gmail.com>
Date: Tue, 28 Aug 2012 20:55:32 -0400
Message-ID: <CAJdJm_Ng=92JbYvZHkMnvBJssRERqCsE3_bDwx+ZoymE7_B7ZQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] input: Fix build error due to O_CLOEXEC
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Aug 28, 2012 at 8:15 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>> +#define _GNU_SOURCE
>
> this should be already in our config.h. It seems like we are missing
> the following in our configure.ac:
>
> AC_USE_SYSTEM_EXTENSIONS.
>
> Btw, we should remove the other definitions of _GNU_SOURCE

Nice, I wasn't aware of this feature. Does it require any newer
autoconf version?

I can try this tomorrow and send a new patch set removing the
_GNU_SOURCE defines.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
