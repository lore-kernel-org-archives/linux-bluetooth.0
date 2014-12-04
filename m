Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RFC v2 5/7] Bluetooth: Add definitions for MGMT_OP_START_SERVICE_DISCOVERY
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8zfKBdu8=ZJj9Z-OLVjyUJoZ3iZ6bVjhPL_sVzU3qZ61w@mail.gmail.com>
Date: Thu, 4 Dec 2014 20:27:13 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <B48B3F23-03FA-46D4-A999-3EF6835FF03E@holtmann.org>
References: <1417689400-128063-5-git-send-email-marcel@holtmann.org> <CAD0=r8zfKBdu8=ZJj9Z-OLVjyUJoZ3iZ6bVjhPL_sVzU3qZ61w@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

>> This patch adds the opcode and structure for Start Service Discovery
>> operation.
>> 
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> include/net/bluetooth/mgmt.h | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>> 
>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>> index 9b382ea34fd9..95c34d5180fa 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -498,6 +498,15 @@ struct mgmt_cp_set_public_address {
>> } __packed;
>> #define MGMT_SET_PUBLIC_ADDRESS_SIZE   6
>> 
>> +#define MGMT_OP_START_SERVICE_DISCOVERY        0x003A
>> +struct mgmt_cp_start_service_discovery {
>> +       __u8 type;
> 
> Maybe we should get rid of type ? service discovery based on
> advertisement content makes sense only for LE

this works perfectly fine for BR/EDR or BR/EDR + LE discovery. It is up to the call to decide what to do. And we have kept the type in place even for commands that are currently only supported on one transport. It allows us to extend the API without breaking it.

Regards

Marcel

