Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJLTA8iTaq00tHsoLz891M7zz-Tt54NZqnxzd-NztAuH9RDqoA@mail.gmail.com>
References: <1425028415-1190-1-git-send-email-gowtham.ab@samsung.com>
	<CAJLTA8iTaq00tHsoLz891M7zz-Tt54NZqnxzd-NztAuH9RDqoA@mail.gmail.com>
Date: Fri, 27 Feb 2015 07:15:37 -0800
Message-ID: <CAJLTA8hXGHySBUAArio8aXpJXCWkMgSRFkRge1hz+n4+vhuBxg@mail.gmail.com>
Subject: Fwd: [PATCH 0/3] Add Write Characteristic Value server TC
From: Michael Janssen <jamuraa@google.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Fri, Feb 27, 2015 at 1:13 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Adds the below server test cases:
> 1) Write Characteristic Value - to Server
> 2) Write Characteristic Value – Invalid Handle Response
> 3) Write Characteristic Value – Write Not Permitted Response
>
> Bharat Panda (2):
>   unit/test-gatt: Add TP/GAW/SR/BI-02-C test
>   unit/test-gatt: Add TP/GAW/SR/BI-03-C test
>
> Gowtham Anandha Babu (1):
>   unit/test-gatt: Add TP/GAW/SR/BV-03-C test
>
>  unit/test-gatt.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Server tests should be written against all of the databases which are
in the test suite - the small (make_test_spec_small_db, available in
the test area as ts_small_db) and first large
(make_test_spec_large_db_1, ts_large_db_1) should be used for these
tests.

--
Michael Janssen
