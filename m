Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCHv3 07/15] android: Create HAL API header skeleton
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131010122911.GJ23879@aemeltch-MOBL1>
Date: Thu, 10 Oct 2013 14:35:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <56EFB0C2-81B7-4E25-B1ED-B61465248141@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-8-git-send-email-Andrei.Emeltchenko.news@gmail.com> <69ADBAAE-9261-4C56-9779-5708DE897CBA@holtmann.org> <20131010122911.GJ23879@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>> Header describes the protocol between Android HAL threads and BlueZ
>>> daemon.
>>> ---
>>> android/hal_msg.h |  255 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 255 insertions(+)
>>> create mode 100644 android/hal_msg.h
>>> 
>>> diff --git a/android/hal_msg.h b/android/hal_msg.h
>>> new file mode 100644
>>> index 0000000..c6bc883
>>> --- /dev/null
>>> +++ b/android/hal_msg.h
>>> @@ -0,0 +1,255 @@
>>> +/*
>>> + *
>>> + *  BlueZ - Bluetooth protocol stack for Linux
>>> + *
>>> + *  Copyright (C) 2013  Intel Corporation. All rights reserved.
>>> + *
>>> + *
>>> + *  This library is free software; you can redistribute it and/or
>>> + *  modify it under the terms of the GNU Lesser General Public
>>> + *  License as published by the Free Software Foundation; either
>>> + *  version 2.1 of the License, or (at your option) any later version.
>>> + *
>>> + *  This library is distributed in the hope that it will be useful,
>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + *  Lesser General Public License for more details.
>>> + *
>>> + *  You should have received a copy of the GNU Lesser General Public
>>> + *  License along with this library; if not, write to the Free Software
>>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>>> + *
>>> + */
>>> +
>>> +#ifndef __packed
>>> +#define __packed __attribute__((packed))
>>> +#endif
> 
> you want different style from lib/mgmt.h ?

no idea why that is in there. It should not be.

>> 
>> nowhere in the code we are using __packed. That is more a kernel thing. Just use the gcc style directly.
>> 
>>> +
>>> +typedef struct {
>>> +	uint8_t b[6];
>>> +} __packed __bdaddr_t;
>> 
>> Just use a uint8_t bdaddr[6] instead.
>> 
>>> +
>>> +struct hal_msg_hdr {
>>> +	uint8_t service_id;
>>> +	uint8_t opcode;
>>> +	uint16_t len;
>>> +	uint8_t payload[0];
>> 
>> I would not include the payload[0] here.
> 
> I know that the current approach is to magically add to pointer header
> size, but doesn't it looks better?

Not to me.

> 
>> 
>>> +} __packed;
>>> +
>>> +#define HAL_SERVICE_ID_CORE		0
>>> +#define HAL_SERVICE_ID_BLUETOOTH	1
>>> +#define HAL_SERVICE_ID_SOCK		2
>>> +#define HAL_SERVICE_ID_HIDHOST		3
>>> +#define HAL_SERVICE_ID_PAN		4
>>> +#define HAL_SERVICE_ID_HANDSFREE	5
>>> +#define HAL_SERVICE_ID_AD2P		6
>>> +#define HAL_SERVICE_ID_HEALTH		7
>>> +#define HAL_SERVICE_ID_AVRCP		8
>>> +#define HAL_SERVICE_ID_GATT		9
>>> +
>>> +/* Core Service */
>>> +
>>> +#define HAL_MSG_OP_ERROR		0x00
>>> +struct hal_msg_rp_error {
>>> +	uint8_t status;
>>> +} __packed;
>> 
>> using RSP, rsp, CMD, cmd, EVT and EVT seems to be clearer I think.
> 
> So I want to be sure that I understand this right:
> 
> hal_msg_rp_error => hal_msg_rsp_error
> 
> hal_msg_cp_register_module => hal_msg_cmd_register_module
> 
> this would be different from lib/mgmt.h

Since this is not a mgmt.h API, it does not need to follow it. mgmt is a kernel API and that is where some its parts are coming from. This is not a kernel API.

> 
>>> +
>>> +#define HAL_MSG_OP_REGISTER_MODULE	0x01
>>> +struct hal_msg_cp_register_module {
>>> +	uint8_t service_id;
>>> +} __packed;
>>> +struct hal_msg_rp_register_module {
>>> +	uint8_t service_id;
>>> +} __packed;
>>> +
>>> +#define HAL_MSG_OP_UNREGISTER_MODULE	0x02
>>> +struct hal_msg_cp_unregister_module {
>>> +	uint8_t service_id;
>>> +} __packed;
>>> +
>>> +/* Bluetooth Core HAL API */
>>> +
>>> +#define HAL_MSG_OP_BT_ENABLE		0x01
>>> +
>>> +#define HAL_MSG_OP_BT_DISABLE		0x02
>>> +
>>> +#define HAL_MSG_OP_BT_GET_ADAPTER_PROPS	0x03
>>> +
>>> +#define HAL_MSG_OP_BT_GET_ADAPTER_PROP	0x04
>>> +struct hal_msg_cp_bt_get_adapter_prop {
>>> +	uint8_t type;
>>> +} __packed;
>>> +
>>> +#define HAL_MSG_OP_BT_SET_ADAPTER_PROP	0x05
>>> +struct hal_msg_cp_bt_set_adapter_prop {
>>> +	uint8_t type;
>>> +	uint16_t len;
>>> +	uint8_t val[0];
>>> +} __packed;
>>> +
>>> +#define HAL_MSG_OP_BT_GET_REMOTE_DEVICE_PROPS	0x06
>>> +struct hal_msg_cp_bt_get_remote_device_props {
>>> +	__bdaddr_t bdaddr;
>>> +} __packed;
>>> +
>>> +#define HAL_MSG_OP_BT_GET_REMOTE_DEVICE_PROP	0x07
>>> +struct hal_msg_cp_bt_get_remote_device_prop {
>>> +	__bdaddr_t bdaddr;
>>> +	uint8_t type;
>>> +} __packed;
>>> +
>>> +#define HAL_MSG_OP_BT_SET_REMOTE_DEVICE_PROP	0x08
>>> +struct hal_msg_cp_bt_set_remote_device_prop {
>>> +	__bdaddr_t bdaddr;
>>> +	uint8_t type;
>>> +	uint16_t len;
>> 
>> Lets make these all align properly.
> 
> Align with tabs? So this will be very different from lib/mgmt.h ?

In monitor/bt.h, I did align them with spaces.

Regards

Marcel

