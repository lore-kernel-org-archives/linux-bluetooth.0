Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1357761036.1806.48.camel@aeonflux>
References: <1357744762-5111-1-git-send-email-anderson.lizardo@openbossa.org>
	<1357744762-5111-3-git-send-email-anderson.lizardo@openbossa.org>
	<1357761036.1806.48.camel@aeonflux>
Date: Wed, 9 Jan 2013 16:13:23 -0400
Message-ID: <CAJdJm_N86NVQ0WeyFb+Z-V9s7LQnKgHEki1=UVB9rfGQ8QsDJw@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ 3/3] unit: Implement tests for sdp_extract_attr()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 9, 2013 at 3:50 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> just remove both TODOs from the patch. I assume you will send updates on
> this.

Yes, I will prepare a series with tests for other valid input.

Using this macro for testing sequences is not possible given it is
implemented as a linked list. SEQ*/ALT* stuff need to be tested
separately.

Testing invalid input (and checking for error) is also important,
specially if it triggers some memory leak/corruption. But they will
use a different test function because it should always return a NULL
pointer instead.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
