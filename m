Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Apr 2014 15:56:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: Re: [PATCH 25/36] android/gatt: Add support to read request
Message-ID: <20140429125652.GA18942@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1398734107-4793-27-git-send-email-lukasz.rymanowski@tieto.com>
 <20140429081329.GH21742@t440s.lan>
 <CAN_7+Yb4ZgRYHSZUfjkGz7bEdvuyt7GDUS6w5y7Aurq8E0+xgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAN_7+Yb4ZgRYHSZUfjkGz7bEdvuyt7GDUS6w5y7Aurq8E0+xgw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
> On Tue, Apr 29, 2014 at 10:13 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
> >> +static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
> >> +                                     struct gatt_device *dev)
> >> +{
> >> +     uint16_t handle;
> >> +     uint16_t len;
> >> +     uint16_t offset = 0;
> >> +     struct req_data *req_data;
> >> +
> >> +     DBG("");
> >> +
> >> +     req_data = new0(struct req_data, 1);
> >> +     if (!req_data)
> >> +             return ATT_ECODE_UNLIKELY;
> >> +
> >> +     switch (cmd[0]) {
> >> +     case ATT_OP_READ_BLOB_REQ:
> >> +             len = dec_read_blob_req(cmd, cmd_len, &handle, &offset);
> >> +             if (!len) {
> >> +                     free(req_data);
> >> +                     return ATT_ECODE_INVALID_PDU;
> >> +             }
> >> +             req_data->long_read = true;
> >> +             break;
> >> +     case ATT_OP_READ_REQ:
> >> +             len = dec_read_req(cmd, cmd_len, &handle);
> >> +             if (!len) {
> >> +                     free(req_data);
> >> +                     return ATT_ECODE_INVALID_PDU;
> >> +             }
> >> +             break;
> >> +     default:
> >> +             error("gatt: Unexpected read type 0x%02x", cmd[0]);
> >> +             free(req_data);
> >> +             return ATT_ECODE_REQ_NOT_SUPP;
> >> +     }
> >> +
> >> +     req_data->dev = dev;
> >> +     req_data->opcode = cmd[0];
> >> +
> >> +     if (!gatt_db_read(gatt_db, handle, offset, req_data)) {
> >> +             free(req_data);
> >> +             return ATT_ECODE_UNLIKELY;
> >> +     }
> >> +
> >> +     return 0;
> >> +}
> >
> > Where is req_data freed in the case that gatt_db_read succeeds?
> 
> It is freed later in the callback. Will put comment about that.

Which callback is that? E.g. in 13/36 the gap_read_cb function does not
free req_data.

In general this kind of API design seems quite strange to me. Probably
the information contained in struct req_data can be made fixed for the
gatt-db API instead of something chosen by the user (in this case
android/gatt.c), and probably doesn't have to be dynamically allocated
to begin with.

Johan
