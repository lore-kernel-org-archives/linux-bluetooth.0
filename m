Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000b01d05035$4880be30$d9823a90$@samsung.com>
References: <1424776660-27719-1-git-send-email-gowtham.ab@samsung.com>
	<1424776660-27719-2-git-send-email-gowtham.ab@samsung.com>
	<CABBYNZ+sr67_kGMOHLSNXQ=AyQAgY8Fr+EXKjC==Y9m9gfhXjA@mail.gmail.com>
	<000b01d05035$4880be30$d9823a90$@samsung.com>
Date: Tue, 24 Feb 2015 15:27:04 +0200
Message-ID: <CABBYNZK+whJd2wh89-_+okdR+1-CVLQjYmtQ_69MN+ivxw2sNQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] unit/test-gatt: Add TP/GAW/CL/BV-03-C test
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Tue, Feb 24, 2015 at 3:24 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Hi Luiz,
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
>> Sent: Tuesday, February 24, 2015 6:40 PM
>> To: Gowtham Anandha Babu
>> Cc: linux-bluetooth@vger.kernel.org; Bharat Panda; cpgs@samsung.com
>> Subject: Re: [PATCH 1/6] unit/test-gatt: Add TP/GAW/CL/BV-03-C test
>>
>> Hi Gowtham,
>>
>> On Tue, Feb 24, 2015 at 1:17 PM, Gowtham Anandha Babu
>> <gowtham.ab@samsung.com> wrote:
>> > Verify that a Generic Attribute Profile client can write a
>> > Characteristic Value selected by handle.
>> > ---
>> >  unit/test-gatt.c | 38 ++++++++++++++++++++++++++++++++++++--
>> >  1 file changed, 36 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/unit/test-gatt.c b/unit/test-gatt.c index
>> > 3ab5340..66b5794 100644
>> > --- a/unit/test-gatt.c
>> > +++ b/unit/test-gatt.c
>> > @@ -141,7 +141,7 @@ struct context {
>> >                 raw_pdu(0x04, 0x04, 0x00, 0x04, 0x00),                  \
>> >                 raw_pdu(0x05, 0x01, 0x04, 0x00, 0x01, 0x29),            \
>> >                 raw_pdu(0x08, 0x05, 0x00, 0x08, 0x00, 0x03, 0x28),      \
>> > -               raw_pdu(0x09, 0x07, 0x06, 0x00, 0x02, 0x07, 0x00, 0x29, \
>> > +               raw_pdu(0x09, 0x07, 0x06, 0x00, 0x0a, 0x07, 0x00,
>> > + 0x29, \
>> >                                 0x2a),                                  \
>>
>> Is this a bug or something else that you need to change from 0x02 to 0x0a?
>
> This is to change the characteristic properties from 0x02 (BT_GATT_CHRC_PROP_READ)
> to 0x0a (BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_WRITE), so that we are able to write a value
> to that characteristic.
>
> BT_GATT_CHRC_PROP_READ - 0x02
> BT_GATT_CHRC_PROP_WRITE - 0x08
> (BT_GATT_CHRC_PROP_READ | BT_GATT_CHRC_PROP_WRITE) - 0x0a

Well then it should be fine.

>
> Regards,
> Gowtham Anandha Babu
>
>>
>> >                 raw_pdu(0x08, 0x07, 0x00, 0x08, 0x00, 0x03, 0x28),      \
>> >                 raw_pdu(0x01, 0x08, 0x07, 0x00, 0x0a),                  \
>> > @@ -759,6 +759,34 @@ static const struct test_step test_read_12 = {
>> >         .expected_att_ecode = 0x80,
>> >  };
>> >
>> > +static void test_write_cb(bool success, uint8_t att_ecode, void
>> > +*user_data) {
>> > +       struct context *context = user_data;
>> > +       const struct test_step *step = context->data->step;
>> > +
>> > +       g_assert(att_ecode == step->expected_att_ecode);
>> > +
>> > +       context_quit(context);
>> > +}
>> > +
>> > +static void test_write(struct context *context) {
>> > +       const struct test_step *step = context->data->step;
>> > +
>> > +       g_assert(bt_gatt_client_write_value(context->client, step->handle,
>> step->value,
>> > +                               step->length, test_write_cb, context,
>> > +NULL)); }
>> > +
>> > +static const uint8_t write_data_1[] = {0x01, 0x02, 0x03};
>> > +
>> > +static const struct test_step test_write_1 = {
>> > +       .handle = 0x0007,
>> > +       .func = test_write,
>> > +       .expected_att_ecode = 0,
>> > +       .value = write_data_1,
>> > +       .length = 0x03
>> > +};
>> > +
>> >  static void att_write_cb(struct gatt_db_attribute *att, int err,
>> >                                                                 void
>> > *user_data)  { @@ -957,7 +985,7 @@ static struct gatt_db
>> > *make_service_data_1_db(void)
>> >                 PRIMARY_SERVICE(0x0005, HEART_RATE_UUID, 4),
>> >
>> CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
>> >                                                 BT_ATT_PERM_READ,
>> > -                                               BT_GATT_CHRC_PROP_READ, ""),
>> > +                                               BT_GATT_CHRC_PROP_READ
>> > + | BT_GATT_CHRC_PROP_WRITE, ""),
>> >                 DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID,
>> BT_ATT_PERM_READ,
>> >                                                         "Manufacturer Name"),
>> >                 { }
>> > @@ -2845,5 +2873,11 @@ int main(int argc, char *argv[])
>> >                         raw_pdu(0x0a, 0x03, 0x00),
>> >                         raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x80));
>> >
>> > +       define_test_client("/TP/GAW/CL/BV-03-C", test_client, service_db_1,
>> > +                       &test_write_1,
>> > +                       SERVICE_DATA_1_PDUS,
>> > +                       raw_pdu(0x12, 0x07, 0x00, 0x01, 0x02, 0x03),
>> > +                       raw_pdu(0x13));
>> > +
>> >         return tester_run();
>> >  }
>> > --
>> > 1.9.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
