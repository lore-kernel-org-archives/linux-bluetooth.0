Return-Path: <cyrus@holtmann.org>
Message-ID: <1357685187.1806.40.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/2] unit: Add initial tests for sdp_extract_attr()
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 08 Jan 2013 14:46:27 -0800
In-Reply-To: <CAJdJm_Nij11_3FdUaCD7s4Z6B3wnncVrKHg8YaF2wHHbEd1-1g@mail.gmail.com>
References: <1357670608-19081-1-git-send-email-anderson.lizardo@openbossa.org>
	 <1357672215.1806.32.camel@aeonflux>
	 <CAJdJm_Nij11_3FdUaCD7s4Z6B3wnncVrKHg8YaF2wHHbEd1-1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> > can we make this a bit more generic with a bit more details on what you
> > are testing.
> >
> > Also having a separate test case for str8, str16 and also str32 of
> > course would be a good idea. Same for url8, url16 and url32. In addition
> > checking empty strings and really long strings is a good idea.
> > Especially long strings that match the max len size.
> 
> This was supposed to be a set of initial tests, specially to validate
> the fix I sent on the other patch. I was going to improve the test
> coverage as I read more of the code.
> 
> But I can work on a set of tests which cover all reachable cases for
> sdp_extract_attr() (I want to focus on this function for now because
> it is less used than others and could hide other bugs.) and send them
> at once, including corner cases.

I want to make our life easier in the long term. Otherwise you end up
with copy&paste all over the place.

> > What I actually like to see is that we can specific element sequences in
> > raw and also what they are suppose to match. So we need to ensure that
> > we also extract the right string value and types. And not just the size.
> 
> The "match" data could be raw bytes which I get by converting the
> returned sdp_data_t to PDU format using sdp_gen_pdu(). What do you
> think?

A better test case data could look like this:

	struct test_data {
		const void *input_data;
		size_t input_size;
		uint8_t dtd;
	};

And we can add combinations of structs and unions here to represent the
different testes.

Also I would create a nice helper define like I did with define_ssa()
for example to create the test data and the test with a nice name.

Regards

Marcel


