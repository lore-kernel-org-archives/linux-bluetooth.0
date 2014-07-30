Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 4/5] android/gatt: Always connect with BT_SEC_LOW security
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+PNtNLVFQX87=+1T9kTqV=YsZmmR00P6M-KNwwR-CUpw@mail.gmail.com>
Date: Wed, 30 Jul 2014 09:34:11 -0700
Cc: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	Marcin Kraglak <marcin.kraglak@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <9D1D8CC7-3D15-4A46-8269-018F84F7A90A@holtmann.org>
References: <1406713130-3825-1-git-send-email-marcin.kraglak@tieto.com> <1406713130-3825-4-git-send-email-marcin.kraglak@tieto.com> <CABBYNZ+c8MEoyUnA540yibdkvgJpi2c+-ZHUjNyALqiTsx2WXw@mail.gmail.com> <CAN_7+Yagfpk4CCPeFxVLfsmekZS1r9sV1DnPcq635Ji0PtBEZA@mail.gmail.com> <CABBYNZ+PNtNLVFQX87=+1T9kTqV=YsZmmR00P6M-KNwwR-CUpw@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>>> Set BT_SEC_LOW for all LE connections. Only specific profiles need
>>>> higher security, now it is possible to elevate security with public
>>>> GATT API.
>>>> ---
>>>> android/gatt.c | 6 +-----
>>>> 1 file changed, 1 insertion(+), 5 deletions(-)
>>>> 
>>>> diff --git a/android/gatt.c b/android/gatt.c
>>>> index 49ca2b6..11d7a2c 100644
>>>> --- a/android/gatt.c
>>>> +++ b/android/gatt.c
>>>> @@ -1433,7 +1433,6 @@ reply:
>>>> 
>>>> static int connect_le(struct gatt_device *dev)
>>>> {
>>>> -       BtIOSecLevel sec_level;
>>>>        GIOChannel *io;
>>>>        GError *gerr = NULL;
>>>>        char addr[18];
>>>> @@ -1450,9 +1449,6 @@ static int connect_le(struct gatt_device *dev)
>>>> 
>>>>        DBG("Connection attempt to: %s", addr);
>>>> 
>>>> -       sec_level = bt_device_is_bonded(&dev->bdaddr) ? BT_IO_SEC_MEDIUM :
>>>> -                                                               BT_IO_SEC_LOW;
>>>> -
>>>>        /*
>>>>         * If address type is random it might be that IRK was received and
>>>>         * random is just for faking Android Framework. ID address should be
>>>> @@ -1478,7 +1474,7 @@ static int connect_le(struct gatt_device *dev)
>>>>                        BT_IO_OPT_DEST_BDADDR, bdaddr,
>>>>                        BT_IO_OPT_DEST_TYPE, bdaddr_type,
>>>>                        BT_IO_OPT_CID, ATT_CID,
>>>> -                       BT_IO_OPT_SEC_LEVEL, sec_level,
>>>> +                       BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
>>>>                        BT_IO_OPT_INVALID);
>>>>        if (!io) {
>>>>                error("gatt: Failed bt_io_connect(%s): %s", addr,
>>>> --
>>>> 1.9.3
>>> 
>>> This does not work for HoG:
>>> 
>>> "If the HID Host receives the L2CAP Connection Parameter Update
>>> request but has not
>>> yet completed service discovery or has not completed encryption, the
>>> HID Host may
>>> send the L2CAP Connection Parameter Update Response with the Result field
>>> indicating that the request has been rejected."
>>> 
>> 
>> I think that with "[PATCH 3/5] anroid/hidhost: Set security to MEDUIM
>> after connect"  there is no issue with HOG.
>> That patch basically triggers pairing or enable encryption (if device
>> are bonded) just after LE link is created.
> 
> It depends when the connection parameter update is sent, if it is
> before the userspace can upgrade the security requirement and the
> remote device rejects it then it might never update. Anyway, the
> argument bellow still stand, why would you have LTK distributed and
> not encrypt?
> 
> Id say the very purpose of signed writes is meant for when you don't
> have LTK, but perhaps Im missing something.

the signed write is designed for the case where you only have to do a single/minimal write operation. It is also important to note that the value origin can only be authenticated. It is not encrypted. So if you are worried that someone will see your data, then signed write is not what you want.

For LE HID devices, the only option is to enable encryption right after connection. There is really no point to let a HID device start unencrypted.

Regards

Marcel

