Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7F79038B-2FA8-4DF5-B25A-D7E9AAE922A8@holtmann.org>
References: <1412325293-6651-1-git-send-email-fons@spotify.com> <7F79038B-2FA8-4DF5-B25A-D7E9AAE922A8@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Fri, 3 Oct 2014 14:13:19 +0200
Message-ID: <CAHF=Y4qa5-2sNzS5z1h8uurqaNt2c-ykSbiLxZSGdm6SMKSp0w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Include ADV_IND report in Device Connected event
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> -     if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
>> +     if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
>>               mgmt_device_connected(hdev, &conn->dst, conn->type,
>> -                                   conn->dst_type, 0, NULL, 0, NULL);
>> +                                   conn->dst_type, 0, NULL, 0, NULL,
>> +                                   conn->le_pend_adv_data,
>> +                                   conn->le_pend_adv_len);
>> +             conn->le_pend_adv_len = 0;
>
> The reset to 0 seems like not a good idea. What is this trying to fix.

It just made it consistent with the naming (it's not pending anymore
once you send it). Now that the naming changed it doesn't make sense,
I will remove it.

All your remarks have been taken care of in patch version 2.


-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
