Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Michael Janssen' <jamuraa@google.com>
Cc: 'Bharat Bhusan Panda' <bharat.panda@samsung.com>,
	linux-bluetooth@vger.kernel.org
References: <1425028415-1190-1-git-send-email-gowtham.ab@samsung.com>
 <CAJLTA8iTaq00tHsoLz891M7zz-Tt54NZqnxzd-NztAuH9RDqoA@mail.gmail.com>
 <CAJLTA8hXGHySBUAArio8aXpJXCWkMgSRFkRge1hz+n4+vhuBxg@mail.gmail.com>
In-reply-to: <CAJLTA8hXGHySBUAArio8aXpJXCWkMgSRFkRge1hz+n4+vhuBxg@mail.gmail.com>
Subject: RE: [PATCH 0/3] Add Write Characteristic Value server TC
Date: Mon, 02 Mar 2015 11:04:27 +0530
Message-id: <000301d054aa$9133f7e0$b39be7a0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Michael Janssen
> Sent: Friday, February 27, 2015 8:46 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: Fwd: [PATCH 0/3] Add Write Characteristic Value server TC
> 
> Hi Gowtham,
> 
> On Fri, Feb 27, 2015 at 1:13 AM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Adds the below server test cases:
> > 1) Write Characteristic Value - to Server
> > 2) Write Characteristic Value – Invalid Handle Response
> > 3) Write Characteristic Value – Write Not Permitted Response
> >
> > Bharat Panda (2):
> >   unit/test-gatt: Add TP/GAW/SR/BI-02-C test
> >   unit/test-gatt: Add TP/GAW/SR/BI-03-C test
> >
> > Gowtham Anandha Babu (1):
> >   unit/test-gatt: Add TP/GAW/SR/BV-03-C test
> >
> >  unit/test-gatt.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Server tests should be written against all of the databases which are in the
> test suite - the small (make_test_spec_small_db, available in the test area as
> ts_small_db) and first large (make_test_spec_large_db_1, ts_large_db_1)
> should be used for these tests.
> 

Thanks for pointing it out. I will send the patches to revert this set and 
test these test cases against ts_small_db and ts_large_db_1 databases and send those patches too.

Regards,
Gowtham Anandha Babu

> --
> Michael Janssen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

