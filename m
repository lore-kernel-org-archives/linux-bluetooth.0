Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357685187.1806.40.camel@aeonflux>
References: <1357670608-19081-1-git-send-email-anderson.lizardo@openbossa.org>
	<1357672215.1806.32.camel@aeonflux>
	<CAJdJm_Nij11_3FdUaCD7s4Z6B3wnncVrKHg8YaF2wHHbEd1-1g@mail.gmail.com>
	<1357685187.1806.40.camel@aeonflux>
Date: Wed, 9 Jan 2013 11:14:40 -0400
Message-ID: <CAJdJm_PTS1yXBTS3MjvNniSqD_=xkx9S_fEYCGto-ghvQumqDg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] unit: Add initial tests for sdp_extract_attr()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jan 8, 2013 at 6:46 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> A better test case data could look like this:
>
>         struct test_data {
>                 const void *input_data;
>                 size_t input_size;
>                 uint8_t dtd;
>         };
>
> And we can add combinations of structs and unions here to represent the
> different testes.
>
> Also I would create a nice helper define like I did with define_ssa()
> for example to create the test data and the test with a nice name.

I just sent a v2 of the SDP DE tests based on your suggestions (the 2
other patches are just refactoring of existing code).

Let me know if this new format is fine, so I can proceed with adding
other tests.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
