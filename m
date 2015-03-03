Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1425286928-31479-1-git-send-email-gowtham.ab@samsung.com>
 <1425286928-31479-2-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZL5SLpWiEtgcODd3r=cdZL2Erp9iQMSR2GGoM6V8oOqOA@mail.gmail.com>
In-reply-to: <CABBYNZL5SLpWiEtgcODd3r=cdZL2Erp9iQMSR2GGoM6V8oOqOA@mail.gmail.com>
Subject: RE: [PATCH 1/3] unit/test-gatt: Add TP/GAW/SR/BV-03-C test
Date: Tue, 03 Mar 2015 11:40:28 +0530
Message-id: <000701d05578$c034b2e0$409e18a0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Monday, March 02, 2015 8:09 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Bharat Panda; cpgs@samsung.com
> Subject: Re: [PATCH 1/3] unit/test-gatt: Add TP/GAW/SR/BV-03-C test
> 
> Hi Gowtham,
> 
> On Mon, Mar 2, 2015 at 11:02 AM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Verify that a Generic Attribute Profile server can support writing a
> > Characteristic Value selected by handle.
> >
> > The GATT server test cases are supposed to be tested against
> > ts_small_db and ts_large_db_1. So, Fixed these changes too.
> 
> I guess you did not understand, I meant that you should send 3 patches, one
> for each test with the fixes not just squash the first.
> 

I have sent v1 addressing the comments.

Regards,
Gowtham Anandha Babu

> > ---
> >  unit/test-gatt.c | 26 ++++++++++----------------
> >  1 file changed, 10 insertions(+), 16 deletions(-)
> >
> > diff --git a/unit/test-gatt.c b/unit/test-gatt.c index
> > 69654f1..104f415 100644
> > --- a/unit/test-gatt.c
> > +++ b/unit/test-gatt.c
> > @@ -1101,8 +1101,7 @@ static struct gatt_db
> *make_service_data_1_db(void)
> >                                                                 "Device Name"),
> >                 PRIMARY_SERVICE(0x0005, HEART_RATE_UUID, 4),
> >
> CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
> > -                                               BT_ATT_PERM_READ |
> > -                                               BT_ATT_PERM_WRITE,
> > +                                               BT_ATT_PERM_READ,
> >                                                 BT_GATT_CHRC_PROP_READ |
> >                                                 BT_GATT_CHRC_PROP_WRITE, ""),
> >                 DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID,
> > BT_ATT_PERM_READ, @@ -1133,7 +1132,8 @@ static struct gatt_db
> *make_test_spec_small_db(void)
> >         const struct att_handle_spec specs[] = {
> >                 SECONDARY_SERVICE(0x0001, DEVICE_INFORMATION_UUID, 16),
> >
> CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
> > -                                               BT_ATT_PERM_READ,
> > +                                               BT_ATT_PERM_READ |
> > +                                               BT_ATT_PERM_WRITE,
> >                                                 BT_GATT_CHRC_PROP_READ |
> >                                                 BT_GATT_CHRC_PROP_NOTIFY |
> >
> > BT_GATT_CHRC_PROP_INDICATE, @@ -3051,23 +3051,17 @@ int main(int
> argc, char *argv[])
> >                         raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
> >                         raw_pdu(0x01, 0x12, 0x07, 0x00, 0x0c));
> >
> > -       define_test_server("/TP/GAW/SR/BV-03-C", test_server,
> > -                       service_db_1, NULL,
> > +       define_test_server("/TP/GAW/SR/BV-03-C/small", test_server,
> > +                       ts_small_db, NULL,
> >                         raw_pdu(0x03, 0x00, 0x02),
> > -                       raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
> > +                       raw_pdu(0x12, 0x03, 0x00, 0x01, 0x02, 0x03),
> >                         raw_pdu(0x13));
> >
> > -       define_test_server("/TP/GAW/SR/BI-02-C", test_server,
> > -                       service_db_1, NULL,
> > -                       raw_pdu(0x03, 0x00, 0x02),
> > -                       raw_pdu(0x12, 0x00, 0x00, 0x01, 0x02, 0x03),
> > -                       raw_pdu(0x01, 0x12, 0x00, 0x00, 0x01));
> > -
> > -       define_test_server("/TP/GAW/SR/BI-03-C", test_server,
> > -                       service_db_1, NULL,
> > +       define_test_server("/TP/GAW/SR/BV-03-C/large-1", test_server,
> > +                       ts_large_db_1, NULL,
> >                         raw_pdu(0x03, 0x00, 0x02),
> > -                       raw_pdu(0x12, 0x03, 0x00, 0x01, 0x02, 0x03),
> > -                       raw_pdu(0x01, 0x12, 0x03, 0x00, 0x03));
> > +                       raw_pdu(0x12, 0x82, 0x00, 0x01, 0x02, 0x03),
> > +                       raw_pdu(0x13));
> >
> >         return tester_run();
> >  }
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

