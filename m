Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774113086F7@SHSMSX104.ccr.corp.intel.com>
References: <1410426586-9075-1-git-send-email-chao.jie.gu@intel.com>
	<CAHrH25RxdmTDMxEYmUm75fJOt-oU5cLibNOhE3UASPhdHoO24A@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774113086F7@SHSMSX104.ccr.corp.intel.com>
Date: Tue, 16 Sep 2014 09:25:05 -0700
Message-ID: <CAHrH25T4b6qMMOXnG-UJO6ELy6UR3WMKQapzieAL+QYroCD6UQ@mail.gmail.com>
Subject: Re: [PATCH] ATT signed write command
From: Arman Uguray <armansito@chromium.org>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,

>> > +               pdu_len += BT_ATT_SIGNATURE_LEN;
>> > +               att = op->user_data;
>>
>> I don't think that this code here works. op->user_data refers to user data provided in
>> bt_att_send and not the bt_att structure. Instead, I would just add a "struct bt_att
>> *att" field to struct att_send_op and remove the local variable "att".
>
> In my implementation , op->user_data in the signed write command code path refer to
> the bt_att structure because struct bt_att provided in bt_att_send parameter user_data.
> So it could be work.

What would happen to the user passed user_data then? :)


> But your proposal make more sense if extend the att_send_op struct to store struct bt_att *att
> Because user_data should be provided for callback , current implementation style is ugly indeed.
>

Yep, sounds better.


> This point is my major purpose for this patch discussion. We can see in android/gatt.c,
> Csrk and sign counter get from struct device in new_csrk_callback by mgmt_register
> event from kernel. And we can get att->csrk from struct device. However, in
> btgatt-client tool, there is no struct device and no event notification handler.
> So if we have to implemetnt bt_att_set_csrk, how can we get csrk ?

We want a generic way to obtain the CSRK and the sign count.
Eventually bluetoothd will do exactly that where src/device.c (which
will own a struct bt_gatt_client instance) will give us the CSRK and
initialize the sign count. For testing purposes you're welcome to add
this functionality to tools/btgatt-client by directly hooking into
shared/mgmt.


> And for the lifecycle of sign_counter, it should be updated to store in files after signed write.
> Btgatt-client need to create special file to do that?

This is a good question. I think as far as btgatt-client is concerned,
I wouldn't worry about persisting the sign count. btgatt-client is
meant to be a simple tool and not maintain state the way the daemon
does. So, keep it simple there. Maybe somehow reset the count to 0
every time btgatt-client restarts?


Cheers,
Arman
