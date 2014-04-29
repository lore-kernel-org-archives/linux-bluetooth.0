Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ8dbpwE7Ofrr6akcXgGbxi7YVi0TKC9Z6NYb8-6ivjdQ@mail.gmail.com>
References: <1397610266-20894-1-git-send-email-armansito@chromium.org>
	<1397610266-20894-2-git-send-email-armansito@chromium.org>
	<CABBYNZJ8dbpwE7Ofrr6akcXgGbxi7YVi0TKC9Z6NYb8-6ivjdQ@mail.gmail.com>
Date: Tue, 29 Apr 2014 11:30:36 +0300
Message-ID: <CABBYNZ+vmmS7xfmdUHJ2qupqonyS3zxmSPEaf-HVU7qHGoHcRQ@mail.gmail.com>
Subject: Re: [RFC 1/2] src/shared/att: Introduce struct bt_att.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Apr 29, 2014 at 11:25 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
>> +/* Error response */
>> +#define ATT_OP_ERROR_RESP              0x01
>> +struct bt_att_error_rsp_param {
>> +       uint8_t request_opcode;
>> +       uint16_t handle;
>> +       uint8_t error_code;
>> +};
>> +
>> +/* Exchange MTU */
>> +#define ATT_OP_EXCHANGE_MTU_REQ                0x02
>> +struct bt_att_exchange_mtu_req_param {
>> +       uint16_t client_rx_mtu;
>> +};
>> +
>> +#define ATT_OP_EXCHANGE_MTU_RESP       0x03
>> +struct bt_att_exchange_mtu_rsp_param {
>> +       uint16_t server_rx_mtu;
>> +};
>
> I would keep the PDU internally and have functions for that e.g.
> bt_att_error_rsp, btw you can probably drop the _param suffix since it
> is quite obvious what it is for.
>
>> +/* Error codes for Error response PDU */
>> +#define ATT_ERROR_INVALID_HANDLE                       0x01
>> +#define ATT_ERROR_READ_NOT_PERMITTED                   0x02
>> +#define ATT_ERROR_WRITE_NOT_PERMITTED                  0x03
>> +#define ATT_ERROR_INVALID_PDU                          0x04
>> +#define ATT_ERROR_AUTHENTICATION                       0x05
>> +#define ATT_ERROR_REQUEST_NOT_SUPPORTED                        0x06
>> +#define ATT_ERROR_INVALID_OFFSET                       0x07
>> +#define ATT_ERROR_AUTHORIZATION                                0x08
>> +#define ATT_ERROR_PREPARE_QUEUE_FULL                   0x09
>> +#define ATT_ERROR_ATTRIBUTE_NOT_FOUND                  0x0A
>> +#define ATT_ERROR_ATTRIBUTE_NOT_LONG                   0x0B
>> +#define ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE     0x0C
>> +#define ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN          0x0D
>> +#define ATT_ERROR_UNLIKELY                             0x0E
>> +#define ATT_ERROR_INSUFFICIENT_ENCRYPTION              0x0F
>> +#define ATT_ERROR_UNSUPPORTED_GROUP_TYPE               0x10
>> +#define ATT_ERROR_INSUFFICIENT_RESOURCES               0x11
>> +/* Application defined errors */
>> +#define ATT_ERROR_IO                                   0x80
>> +#define ATT_ERROR_TIMEOUT                              0x81
>> +#define ATT_ERROR_ABORTED                              0x82
>
> Perhaps we could map errno to ATT errors, that way this can also be
> made internal to the library.
>
>> +typedef void (*bt_att_destroy_func_t)(void *user_data);
>> +
>> +struct bt_att;
>> +
>> +struct bt_att *bt_att_new(int fd);
>> +
>> +struct bt_att *bt_att_ref(struct bt_att *att);
>> +void bt_att_unref(struct bt_att *att);
>> +
>> +typedef void (*bt_att_debug_func_t)(const char *str, void *user_data);
>> +
>> +bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
>> +                               void *user_data, bt_att_destroy_func_t destroy);
>> +
>> +bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);
>> +
>> +uint16_t bt_att_get_mtu(struct bt_att *att);
>> +bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu);
>> +
>> +typedef void (*bt_att_request_func_t)(uint8_t opcode, const void *param,
>> +                                       uint16_t length, void *user_data);
>
> I think we should make the callback receive the bt_att session as well.
>
>> +unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
>> +                               const void *param, uint16_t length,
>> +                               bt_att_request_func_t callback, void *user_data,
>> +                               bt_att_destroy_func_t destroy);

I forget to mention, but it is probably a good idea to start using
iovec instead of a void * so the caller doesn't have to pack
everything together (which probably mean memcpy), this obviously has
to be handled internally and you probably should end up using writev
or sendmsg, but perhaps bt_att_send can be static as well if you have
proper functions mapping the PDUs as I suggested in the previous
email.

>> +bool bt_att_cancel(struct bt_att *att, unsigned int id);
>> +bool bt_att_cancel_all(struct bt_att *att);
>> --
>> 1.9.1.423.g4596e3a
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
