Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <14AD7057-EAF4-4A7A-A184-B6F3ED487EBE@holtmann.org>
References: <1412338226-7351-1-git-send-email-fons@spotify.com>
 <1412338226-7351-3-git-send-email-fons@spotify.com> <14AD7057-EAF4-4A7A-A184-B6F3ED487EBE@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Fri, 3 Oct 2014 14:27:07 +0200
Message-ID: <CAHF=Y4o1yjM35ck0V22LgXO1fR6OtjP86HbBLuUtgvEsDaQZuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: Include ADV_IND report in Device
 Connected event
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index f1407fe..1d8d734 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -398,6 +398,8 @@ struct hci_conn {
>>       __u16           le_conn_interval;
>>       __u16           le_conn_latency;
>>       __u16           le_supv_timeout;
>> +     __u8            le_adv_data[HCI_MAX_AD_LENGTH];
>> +     __u8            le_adv_len;
>
> le_adv_data_len here to make it consistent with the places we use this variables.

Done in v3.

-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
