Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357615542.1806.22.camel@aeonflux>
References: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
	<1357615542.1806.22.camel@aeonflux>
Date: Tue, 8 Jan 2013 06:52:59 -0400
Message-ID: <CAJdJm_Mvo7VMQ=dQK=oCvXgt1aoH5vZEbfr6nd2qZp+PpeaP+Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] lib: Add SDP_IS_TEXT_STR() macro for
 SDP_TEXT_STR* checking
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 7, 2013 at 11:25 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>>  #define SDP_IS_UUID(x) ((x) == SDP_UUID16 || (x) == SDP_UUID32 || (x) ==SDP_UUID128)
>>  #define SDP_IS_SEQ(x)  ((x) == SDP_SEQ8 || (x) == SDP_SEQ16 || (x) == SDP_SEQ32)
>> +#define SDP_IS_TEXT_STR(x) ((x) == SDP_TEXT_STR8 || (x) == SDP_TEXT_STR16 || \
>> +                                                     (x) == SDP_TEXT_STR32)
>
> can someone please explain to me why we are extending the library. I
> thought I made it clear that it is mostly end of life and we are not
> adding new features. However some people keep adding stuff.

This macro was added simply to be used for the next patches which
simplify/refactor core code. The fact the header is public API was not
the main reason to add it here.

Unless you suggest adding new stuff to another, internal-only header?
If so, please provide some example how to extend SDP library code that
is used by internal BlueZ code.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
