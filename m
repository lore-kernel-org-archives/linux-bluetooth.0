Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 1/7] android: Add flags parameter to register service command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1615014.kasN2TjSTh@leonov>
Date: Sun, 2 Mar 2014 09:56:15 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EC40658F-2ED8-42B0-8682-375DE769B78A@holtmann.org>
References: <1393709289-6395-1-git-send-email-szymon.janc@tieto.com> <A4A690E8-D8B1-4459-99B6-24A5D49B253F@holtmann.org> <1615014.kasN2TjSTh@leonov>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> This will allow to configure daemon services.
>>> ---
>>> android/hal-a2dp.c      | 1 +
>>> android/hal-avrcp.c     | 1 +
>>> android/hal-bluetooth.c | 1 +
>>> android/hal-handsfree.c | 1 +
>>> android/hal-hidhost.c   | 1 +
>>> android/hal-ipc-api.txt | 7 +++++++
>> 
>> please do not mix code with API docs updates.
> 
> OK.
> 
>> 
>>> android/hal-msg.h       | 1 +
>>> android/hal-pan.c       | 1 +
>>> 8 files changed, 14 insertions(+)
>>> 
>>> diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
>>> index c898995..87d89a2 100644
>>> --- a/android/hal-a2dp.c
>>> +++ b/android/hal-a2dp.c
>>> @@ -109,6 +109,7 @@ static bt_status_t init(btav_callbacks_t *callbacks)
>>> 
>>> 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
>>> 	
>>> 	cmd.service_id = HAL_SERVICE_ID_A2DP;
>>> 
>>> +	cmd.flags = 0;
>>> 
>>> 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
>>> 	
>>> 					sizeof(cmd), &cmd, 0, NULL, NULL);
>>> 
>>> diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
>>> index 46e25a0..4907f4a 100644
>>> --- a/android/hal-avrcp.c
>>> +++ b/android/hal-avrcp.c
>>> @@ -220,6 +220,7 @@ static bt_status_t init(btrc_callbacks_t *callbacks)
>>> 
>>> 				sizeof(ev_handlers) / sizeof(ev_handlers[0]));
>>> 	
>>> 	cmd.service_id = HAL_SERVICE_ID_AVRCP;
>>> 
>>> +	cmd.flags = 0;
>>> 
>>> 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
>>> 	
>>> 					sizeof(cmd), &cmd, 0, NULL, NULL);
>>> 
>>> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
>>> index 6871f5d..4b31ff1 100644
>>> --- a/android/hal-bluetooth.c
>>> +++ b/android/hal-bluetooth.c
>>> @@ -442,6 +442,7 @@ static int init(bt_callbacks_t *callbacks)
>>> 
>>> 	}
>>> 	
>>> 	cmd.service_id = HAL_SERVICE_ID_SOCKET;
>>> 
>>> +	cmd.flags = 0;
>>> 
>>> 	status = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
>>> 	
>>> 					sizeof(cmd), &cmd, NULL, NULL, NULL);
>>> 
>>> diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
>>> index 1b150c3..422f52c 100644
>>> --- a/android/hal-handsfree.c
>>> +++ b/android/hal-handsfree.c
>>> @@ -212,6 +212,7 @@ static bt_status_t init(bthf_callbacks_t *callbacks)
>>> 
>>> 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
>>> 	
>>> 	cmd.service_id = HAL_SERVICE_ID_HANDSFREE;
>>> 
>>> +	cmd.flags = 0;
>>> 
>>> 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
>>> 	
>>> 					sizeof(cmd), &cmd, 0, NULL, NULL);
>>> 
>>> diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
>>> index c758d2a..fe1b4df 100644
>>> --- a/android/hal-hidhost.c
>>> +++ b/android/hal-hidhost.c
>>> @@ -354,6 +354,7 @@ static bt_status_t init(bthh_callbacks_t *callbacks)
>>> 
>>> 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
>>> 	
>>> 	cmd.service_id = HAL_SERVICE_ID_HIDHOST;
>>> 
>>> +	cmd.flags = 0;
>>> 
>>> 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
>>> 	
>>> 					sizeof(cmd), &cmd, 0, NULL, NULL);
>>> 
>>> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
>>> index 1a19c80..f68324d 100644
>>> --- a/android/hal-ipc-api.txt
>>> +++ b/android/hal-ipc-api.txt
>>> @@ -124,12 +124,16 @@ Core Service (ID 0)
>>> 
>>> 	Opcode 0x01 - Register module command/response
>>> 	
>>> 		Command parameters: Service id (1 octet)
>>> 
>>> +		                    Flags (1 octet)
>> 
>> We might better go with a Flags (4 octets) here. Otherwise you only have 8
>> options which might be enough or not. Your choice.
>> 
>> Or instead of a bit mask, we do a Configuration (1 octet) were we have the
>> default configuration with 0x00 and then alternatives with all other
>> values. That might be actually a bit better.
> 
> I'll see how it goes with configuration options, but flags could be used also 
> to enable eg. debug options which might be clumsy without flags.

what debug options are you thinking about?

I also think we should just call it Mode (1 octet). Keep it simple.

>>> 		Response parameters: <none>
>>> 		
>>> 		In case a command is sent for an undeclared service ID, it will
>>> 		be rejected. Also there will be no notifications for undeclared
>>> 		service ID.
>>> 
>>> +		Flags parameter values should be defined as needed by
>>> +		respective services.
>>> +
>>> 
>>> 		In case of an error, the error response will be returned.
>>> 	
>>> 	Opcode 0x02 - Unregister module command/response
>>> 
>>> @@ -749,6 +753,9 @@ Bluetooth Handsfree HAL (ID 5)
>>> 
>>> Android HAL name: "handsfree" (BT_PROFILE_HANDSFREE_ID)
>>> 
>>> +	Service flags:               0x01 = Disable HSP AG
>>> +	                             0x02 = Disable HFP AG
>>> +
>> 
>> If you do not want HSP and HFP, then there is no point in registering
>> handsfree ID at all. I am tending currently towards the configuration
>> option.
> 
>> 	0x00 = Provide Handsfree profile
>> 	0x01 = Provide Headset profile
>> 
>> There is really no point in providing both? Or is there a case where you
>> would provide both?
> 
> Android on phones provides both. On tablets HSP only. So we could go with
> 0x00 = Provide HFP and HSP
> 0x01 = Provide HSP only
> 
> or just with single flag to disable HFP.

Do we really want to expose HSP gateway when HFP is available. I am not even sure this makes sense. With Bluedroid, are they using the same RFCOMM channel or how does that actually work. You can not connect them at the same time anyway.

I would really go for the simple case of either Handsfree or Headset profile, but not both.

Regards

Marcel

