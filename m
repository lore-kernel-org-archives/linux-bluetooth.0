Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412637149-2966-1-git-send-email-fons@spotify.com>
References: <1412637149-2966-1-git-send-email-fons@spotify.com>
From: Alfonso Acosta <fons@spotify.com>
Date: Tue, 7 Oct 2014 01:14:02 +0200
Message-ID: <CAHF=Y4riYZOVmi6QQ5LidL4dNznbox4t0T9M73LZipn0LetzNg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Include ADV_IND report in Device Connected event
To: Alfonso Acosta <fons@spotify.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,


> On Fri, Oct 03, 2014, Alfonso Acosta wrote:
>>  void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
>> -                        u32 flags, u8 *name, u8 name_len);
>> +                        u32 flags, u8 *name, u8 name_len,
>> +                        u8 *adv, u8 adv_len);
>
> Now that you're already passing the full hci_conn to this function I
> guess it's a bit pointless to add new parameters to it which would
> anyway come from that same hci_conn object.

True, I didn't think about it when merging the second patch.


>> +     /* We must ensure that the EIR Data fields are ordered and
>> +      * unique. Keep it simple for now and avoid the problem by not
>> +      * adding any BR/EDR data to the LE adv.
>> +      */
>> +     if (adv) {
>
> And once you do the earlier fix I suppose this check becomes:
>
>         if (conn->le_adv_data_len > 0) {


Both remarks have been taken care of in version 4.

Thanks,

Fons



-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
