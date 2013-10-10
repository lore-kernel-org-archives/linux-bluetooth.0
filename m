Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCHv3 07/15] android: Create HAL API header skeleton
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131010124839.GN23879@aemeltch-MOBL1>
Date: Thu, 10 Oct 2013 15:02:46 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2B3E99AA-FBEB-4BF4-9D11-3BDEBEDE38AB@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-8-git-send-email-Andrei.Emeltchenko.news@gmail.com> <69ADBAAE-9261-4C56-9779-5708DE897CBA@holtmann.org> <20131010122911.GJ23879@aemeltch-MOBL1> <56EFB0C2-81B7-4E25-B1ED-B61465248141@holtmann.org> <20131010124839.GN23879@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>>>> +#define HAL_MSG_OP_BT_SET_REMOTE_DEVICE_PROP	0x08
>>>>> +struct hal_msg_cp_bt_set_remote_device_prop {
>>>>> +	__bdaddr_t bdaddr;
>>>>> +	uint8_t type;
>>>>> +	uint16_t len;
>>>> 
>>>> Lets make these all align properly.
>>> 
>>> Align with tabs? So this will be very different from lib/mgmt.h ?
>> 
>> In monitor/bt.h, I did align them with spaces.
> 
> Just to be sure: align structures with spaces always?

between uint16_t and len uses spaces to make them align. For everything else use tabs. This only applies to protocol data structures. See monitor/bt.h for how it is suppose to be done.

Regards

Marcel

