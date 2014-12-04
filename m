Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+jw2DoqJU92VLdTWG2Gz5u74eTvXROV+Gy3T3h7XdwOw@mail.gmail.com>
References: <1417615733-7350-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CABBYNZKRXORa_7d+aaFfw7HOHvG8MsNRQNu0gR8wvG3SuGwOPQ@mail.gmail.com>
	<20141204081557.GA5790@aemeltch-MOBL1>
	<CABBYNZ+jw2DoqJU92VLdTWG2Gz5u74eTvXROV+Gy3T3h7XdwOw@mail.gmail.com>
Date: Thu, 4 Dec 2014 14:34:06 +0200
Message-ID: <CABBYNZ+aPRzVuPmA4qjr0VzRRE6vUYGZrU01Kxgnp1DSaYJCcw@mail.gmail.com>
Subject: Re: [PATCH 1/3] unit/gatt: Fix using possible negative return value
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Dec 4, 2014 at 11:19 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Andrei,
>
> On Thu, Dec 4, 2014 at 10:15 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> Hi Luiz,
>>
>> On Wed, Dec 03, 2014 at 08:35:41PM +0200, Luiz Augusto von Dentz wrote:
>>> Hi Andrei,
>>>
>>> On Wed, Dec 3, 2014 at 4:08 PM, Andrei Emeltchenko
>>> <Andrei.Emeltchenko.news@gmail.com> wrote:
>>> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>> >
>>> > ---
>>> >  unit/test-gatt.c | 4 ++--
>>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>>> >
>>> > diff --git a/unit/test-gatt.c b/unit/test-gatt.c
>>> > index 03a66b9..f20da91 100644
>>> > --- a/unit/test-gatt.c
>>> > +++ b/unit/test-gatt.c
>>> > @@ -648,11 +648,11 @@ static void test_server(gconstpointer data)
>>> >
>>> >         len = write(context->fd, pdu.data, pdu.size);
>>> >
>>> > +       g_assert_cmpint(len, ==, pdu.size);
>>> > +
>>> >         if (g_test_verbose())
>>> >                 util_hexdump('<', pdu.data, len, test_debug, "GATT: ");
>>> >
>>> > -       g_assert_cmpint(len, ==, pdu.size);
>>> > -
>>> >         execute_context(context);
>>> >  }
>>> >
>>> > --
>>> > 1.9.1
>>>
>>> What changes does this make?
>>
>> You do not use negative len in case of error in util_hexdump()
>
> Well then I guess this should be part of the path description.

I went ahead and fixed the commit message and applied them, thanks.


-- 
Luiz Augusto von Dentz
