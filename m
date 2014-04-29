Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140429081329.GH21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1398734107-4793-27-git-send-email-lukasz.rymanowski@tieto.com>
	<20140429081329.GH21742@t440s.lan>
Date: Tue, 29 Apr 2014 14:12:54 +0200
Message-ID: <CAN_7+Yb4ZgRYHSZUfjkGz7bEdvuyt7GDUS6w5y7Aurq8E0+xgw@mail.gmail.com>
Subject: Re: [PATCH 25/36] android/gatt: Add support to read request
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 29, 2014 at 10:13 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
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
>> +             return ATT_ECODE_UNLIKELY;
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
>> +     if (!gatt_db_read(gatt_db, handle, offset, req_data)) {
>> +             free(req_data);
>> +             return ATT_ECODE_UNLIKELY;
>> +     }
>> +
>> +     return 0;
>> +}
>
> Where is req_data freed in the case that gatt_db_read succeeds?

It is freed later in the callback. Will put comment about that.

>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
Lukasz
