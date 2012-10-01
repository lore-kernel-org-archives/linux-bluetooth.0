Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349073517.13371.43.camel@aeonflux>
References: <1348861411-31555-1-git-send-email-anderson.lizardo@openbossa.org>
	<1349073517.13371.43.camel@aeonflux>
Date: Mon, 1 Oct 2012 06:50:18 -0400
Message-ID: <CAJdJm_PpVLw6vC4Bf9gkjtpv9Fsx48-QFBoDAtWiBK9j47qE+w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Fix out-of-tree builds
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 1, 2012 at 2:38 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>  profiles/sap/sap.c: profiles/sap/@SAP_DRIVER@
>> -     $(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
>> +     $(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
>>
>>  profiles/input/suspend.c: profiles/input/@HOG_SUSPEND_DRIVER@
>>       $(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
>
> personally I am no longer a big fan of these selection of a specific
> driver. We should be able to build all of them and make the selection at
> runtime. So there is more work needed here.

I agree, this could also help on testing as well (actually, all
drivers are built, regardless of which one was selected by configure,
but only the selected object is linked).

What do you propose? a config file option, e.g. "sap_driver=u8500" ,
"hog_suspend_driver=dummy" , etc (this could fit of the INI config
format proposal).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
