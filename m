Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3242273.GzTXxxgRO7@uw000953>
References: <1411713077-19757-1-git-send-email-jakub.tyszkowski@tieto.com>
	<8408756.jLWkblRn5T@uw000953>
	<CABBYNZ+fbRy1uzFQW_46q=hDG4=H7=YrH2-+POLU3VJf8aio=A@mail.gmail.com>
	<3242273.GzTXxxgRO7@uw000953>
Date: Tue, 30 Sep 2014 13:10:53 +0300
Message-ID: <CABBYNZLzkmjHZLksMRBCK7x8jnkYF+O6XmvLOd=ntGNDgTqBuQ@mail.gmail.com>
Subject: Re: [PATCHv2 05/16] android/tester: Make HidHost tests use generic
 pdu struct
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Sep 30, 2014 at 1:00 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Luiz,
>
> On Tuesday 30 of September 2014 12:54:54 Luiz Augusto von Dentz wrote:
>> Hi,
>>
>> On Tue, Sep 30, 2014 at 12:40 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> > Hi Jakub,
>> >
>> > On Friday 26 of September 2014 08:31:06 Jakub Tyszkowski wrote:
>> >> ---
>> >>  android/tester-hidhost.c | 41 +++++++++++++++++------------------------
>> >>  1 file changed, 17 insertions(+), 24 deletions(-)
>> >>
>> >> diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
>> >> index c7e3a67..0fe9c0a 100644
>> >> --- a/android/tester-hidhost.c
>> >> +++ b/android/tester-hidhost.c
>> >> @@ -21,6 +21,7 @@
>> >>  #include "tester-main.h"
>> >>
>> >>  #include "android/utils.h"
>> >> +#include "src/shared/util.h"
>> >
>> > Is this needed?
>> >
>> >>  #define HID_GET_REPORT_PROTOCOL              0x60
>> >>  #define HID_GET_BOOT_PROTOCOL                0x61
>> >> @@ -59,14 +60,16 @@ struct emu_cid_data {
>> >>
>> >>  static struct emu_cid_data cid_data;
>> >>
>> >> -static const uint8_t did_req_pdu[] = { 0x06, /* PDU id */
>> >> +static struct pdu did_req_pdu = raw_pdu(
>> >> +                     0x06, /* PDU id */
>> >>                       0x00, 0x00, /* Transaction id */
>> >>                       0x00, 0x0f, /* Req length */
>> >>                       0x35, 0x03, /* Attributes length */
>> >>                       0x19, 0x12, 0x00, 0xff, 0xff, 0x35, 0x05, 0x0a, 0x00,
>> >> -                     0x00, 0xff, 0xff, 0x00 }; /* no continuation */
>> >> +                     0x00, 0xff, 0xff, 0x00); /* no continuation */
>> >>
>> >> -static const uint8_t did_rsp_pdu[] = { 0x07, /* PDU id */
>> >> +static struct pdu did_rsp_pdu = raw_pdu(
>> >> +                     0x07, /* PDU id */
>> >>                       0x00, 0x00, /* Transaction id */
>> >>                       0x00, 0x4f, /* Response length */
>> >>                       0x00, 0x4c, /* Attributes length */
>> >> @@ -79,9 +82,10 @@ static const uint8_t did_rsp_pdu[] = { 0x07, /* PDU id */
>> >>                       0x02, 0x02, 0x09, 0x02, 0x46, 0x09, 0x02, 0x03, 0x09,
>> >>                       0x05, 0x0e, 0x09, 0x02, 0x04, 0x28, 0x01, 0x09, 0x02,
>> >>                       0x05, 0x09, 0x00, 0x02,
>> >> -                     0x00 }; /* no continuation */
>> >> +                     0x00); /* no continuation */
>> >>
>> >> -static const uint8_t hid_rsp_pdu[] = { 0x07, /* PDU id */
>> >> +static struct pdu hid_rsp_pdu = raw_pdu(
>> >> +                     0x07, /* PDU id */
>> >>                       0x00, 0x01, /* Transaction id */
>> >>                       0x01, 0x71, /* Response length */
>> >>                       0x01, 0x6E, /* Attributes length */
>> >> @@ -126,7 +130,7 @@ static const uint8_t hid_rsp_pdu[] = { 0x07, /* PDU id */
>> >>                       0x28, 0x01, 0x09, 0x02, 0x0b, 0x09, 0x01, 0x00, 0x09,
>> >>                       0x02, 0x0c, 0x09, 0x0c, 0x80, 0x09, 0x02, 0x0d, 0x28,
>> >>                       0x00, 0x09, 0x02, 0x0e, 0x28, 0x01,
>> >> -                     0x00 }; /* no continuation */
>> >> +                     0x00); /* no continuation */
>> >>
>> >>  static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>> >>  {
>> >> @@ -134,14 +138,14 @@ static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>> >>       struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
>> >>       struct emu_cid_data *cid_data = user_data;
>> >>
>> >> -     if (!memcmp(did_req_pdu, data, len)) {
>> >> +     if (!memcmp(did_req_pdu.data, data, len)) {
>> >>               bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
>> >> -                                     did_rsp_pdu, sizeof(did_rsp_pdu));
>> >> +                                     did_rsp_pdu.data, did_rsp_pdu.size);
>> >>               return;
>> >>       }
>> >>
>> >>       bthost_send_cid(bthost, cid_data->sdp_handle, cid_data->sdp_cid,
>> >> -                                     hid_rsp_pdu, sizeof(hid_rsp_pdu));
>> >> +                                     hid_rsp_pdu.data, hid_rsp_pdu.size);
>> >>  }
>> >>  static void hid_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
>> >>  {
>> >> @@ -159,31 +163,20 @@ static void hid_prepare_reply_protocol_mode(struct emu_cid_data *cid_data)
>> >>  {
>> >>       struct test_data *t_data = tester_get_data();
>> >>       struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
>> >> -     uint8_t pdu[2] = { 0, 0 };
>> >> -     uint16_t pdu_len = 0;
>> >> -
>> >> -     pdu_len = 2;
>> >> -     pdu[0] = 0xa0;
>> >> -     pdu[1] = 0x00;
>> >> +     const struct pdu pdu = raw_pdu(0xa0, 0x00);
>> >>
>> >>       bthost_send_cid(bthost, cid_data->ctrl_handle, cid_data->ctrl_cid,
>> >> -                                                     (void *)pdu, pdu_len);
>> >> +                                                     pdu.data, pdu.size);
>>
>> Something is not quite right if you have to cast to void *, it looks
>> like we should pass a reference e.g. &pdu not the value itself.
>
> That line with (void *) is removed in this patch :)

Nevermind then, I must be seeing the opposite today.

>>
>> >>  }
>> >>
>> >>  static void hid_prepare_reply_report(struct emu_cid_data *cid_data)
>> >>  {
>> >>       struct test_data *t_data = tester_get_data();
>> >>       struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
>> >> -     uint8_t pdu[3] = { 0, 0, 0 };
>> >> -     uint16_t pdu_len = 0;
>> >> -
>> >> -     pdu_len = 3;
>> >> -     pdu[0] = 0xa2;
>> >> -     pdu[1] = 0x01;
>> >> -     pdu[2] = 0x00;
>> >> +     const struct pdu pdu = raw_pdu(0xa2, 0x01, 0x00);
>> >>
>> >>       bthost_send_cid(bthost, cid_data->ctrl_handle, cid_data->ctrl_cid,
>> >> -                                                     (void *)pdu, pdu_len);
>> >> +                                                     pdu.data, pdu.size);
>> >>  }
>> >>
>> >>  static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
>> >>
>> >
>> > --
>> > Best regards,
>> > Szymon Janc
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
>
> --
> Best regards,
> Szymon Janc



-- 
Luiz Augusto von Dentz
