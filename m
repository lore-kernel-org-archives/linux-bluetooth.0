Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130107082734.GA8075@x220.ger.corp.intel.com>
References: <1357501558-3457-1-git-send-email-anderson.lizardo@openbossa.org>
	<1357501558-3457-4-git-send-email-anderson.lizardo@openbossa.org>
	<20130107082734.GA8075@x220.ger.corp.intel.com>
Date: Mon, 7 Jan 2013 07:59:04 -0400
Message-ID: <CAJdJm_O8NE-GVsHJ4B84EHJD3DWpiOnoR8HJeC6nYy9+9xPBXg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] input: Validate SDP HIDDescriptorList subattributes
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Jan 7, 2013 at 4:27 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> +     if (d->dtd < SDP_SEQ8 || d->dtd > SDP_SEQ32)
>> +             goto invalid_desc;
>
> Please always be explicit on what values you're checking for instead of
> assuming that the reader of the code knows what's contained within some
> range. In this case there's already a convenient SDP_IS_SEQ() macro you
> could use.
>
>> +     if (d->dtd < SDP_SEQ8 || d->dtd > SDP_SEQ32)
>> +             goto invalid_desc;
>
> Same here.
>
>> +     if (!d || d->dtd < SDP_TEXT_STR8 || d->dtd > SDP_TEXT_STR32)
>> +             goto invalid_desc;
>
> I suppose the best way to handle this one is to add a SDP_IS_STR() macro
> (in a separate patch) to lib/sdp.h and then use it in this patch.

Just sent a couple of patches fixing these problems and similar ones
in lib/sdp.c and health plugin source.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
