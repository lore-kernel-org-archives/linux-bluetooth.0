Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357672215.1806.32.camel@aeonflux>
References: <1357670608-19081-1-git-send-email-anderson.lizardo@openbossa.org>
	<1357672215.1806.32.camel@aeonflux>
Date: Tue, 8 Jan 2013 16:45:59 -0400
Message-ID: <CAJdJm_Nij11_3FdUaCD7s4Z6B3wnncVrKHg8YaF2wHHbEd1-1g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] unit: Add initial tests for sdp_extract_attr()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jan 8, 2013 at 3:10 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> can we make this a bit more generic with a bit more details on what you
> are testing.
>
> Also having a separate test case for str8, str16 and also str32 of
> course would be a good idea. Same for url8, url16 and url32. In addition
> checking empty strings and really long strings is a good idea.
> Especially long strings that match the max len size.

This was supposed to be a set of initial tests, specially to validate
the fix I sent on the other patch. I was going to improve the test
coverage as I read more of the code.

But I can work on a set of tests which cover all reachable cases for
sdp_extract_attr() (I want to focus on this function for now because
it is less used than others and could hide other bugs.) and send them
at once, including corner cases.

> What I actually like to see is that we can specific element sequences in
> raw and also what they are suppose to match. So we need to ensure that
> we also extract the right string value and types. And not just the size.

The "match" data could be raw bytes which I get by converting the
returned sdp_data_t to PDU format using sdp_gen_pdu(). What do you
think?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
