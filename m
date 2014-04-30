Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140429182025.GA21895@t440s.P-661HNU-F1>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1398790049-30303-30-git-send-email-lukasz.rymanowski@tieto.com>
	<20140429182025.GA21895@t440s.P-661HNU-F1>
Date: Wed, 30 Apr 2014 11:16:47 +0200
Message-ID: <CAN_7+YYN9sU1LVmRNHP9RhKdb+HtQar=9=KkS_kVx4s3YRDtWQ@mail.gmail.com>
Subject: Re: [PATCH v2 29/40] android/gatt: Add support to read request
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 29, 2014 at 8:20 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lukasz,
>
> On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
>> +static void gatt_request_complete(void *data, const uint8_t *pdu, uint16_t len)
>> +{
>> +     struct req_data *d = data;
>> +
>> +     if (pdu)
>> +             g_attrib_send(d->dev->attrib, 0, pdu, len, NULL, NULL, NULL);
>> +     else
>> +             error("gatt: gatt_request_complete: pdu not present ?!");
>> +
>> +     free(d);
>> +}
>> +
>> +static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
>> +                                     struct gatt_device *dev)
>> +{
>> +     uint16_t handle;
>> +     uint16_t len;
>> +     uint16_t offset = 0;
>> +     struct req_data *req_data;
>> +
>> +     DBG("");
>> +
>> +     req_data = new0(struct req_data, 1);
>> +     if (!req_data)
>> +             return ATT_ECODE_INSUFF_RESOURCES;
>> +
>> +     switch (cmd[0]) {
>> +     case ATT_OP_READ_BLOB_REQ:
>> +             len = dec_read_blob_req(cmd, cmd_len, &handle, &offset);
>> +             if (!len) {
>> +                     free(req_data);
>> +                     return ATT_ECODE_INVALID_PDU;
>> +             }
>> +             req_data->long_read = true;
>> +             break;
>> +     case ATT_OP_READ_REQ:
>> +             len = dec_read_req(cmd, cmd_len, &handle);
>> +             if (!len) {
>> +                     free(req_data);
>> +                     return ATT_ECODE_INVALID_PDU;
>> +             }
>> +             break;
>> +     default:
>> +             error("gatt: Unexpected read type 0x%02x", cmd[0]);
>> +             free(req_data);
>> +             return ATT_ECODE_REQ_NOT_SUPP;
>> +     }
>> +
>> +     req_data->dev = dev;
>> +     req_data->opcode = cmd[0];
>> +
>> +     if (!gatt_db_read(gatt_db, handle, offset, req_data, gatt_request_complete)) {
>> +             free(req_data);
>> +             return ATT_ECODE_UNLIKELY;
>> +     }
>
> I don't understand the need to have so many levels of callback passing
> instead of having simple direct calls, especially since all functions
> are in the same c-file anyway. I.e. why can't the characteristic
> read/write callbacks be responsible themselves for sending the response
> PDU (if that's all your gatt_request_complete function is needed for).
>
> This passing a callback (gatt_request_complete in this case) as a
> parameter to another callback (the read/write callback) doesn't really
> help in keeping things simple and understandable.
>

in v4 it should me simpler as I  present you on IRC.

> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Lukasz
