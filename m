Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMudyAujJUfE9w10FxCgXTjex2oX-9PFpmJE8+wQ+4TsGixBsw@mail.gmail.com>
References: <1403131286-15028-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1403131286-15028-5-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZJjdpohiQ62qwsrkmg-FqLcDtrTMeYhe__fLf2LO=UaEg@mail.gmail.com>
	<CAMudyAujJUfE9w10FxCgXTjex2oX-9PFpmJE8+wQ+4TsGixBsw@mail.gmail.com>
Date: Fri, 20 Jun 2014 08:18:19 +0200
Message-ID: <CAMudyAuxrwet5iZKzQk59iVs7PN_X7skNbY99PhNSiWaxc74rw@mail.gmail.com>
Subject: Re: [PATCH 4/4] android/hidhost: Start encryption for HOG when bonded
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 20 June 2014 01:18, Lukasz Rymanowski <lukasz.rymanowski@tieto.com> wrote:
> HI Luiz,
>
> On 19 June 2014 15:25, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> Hi Lukasz,
>>
>> On Thu, Jun 19, 2014 at 1:41 AM, Lukasz Rymanowski
>> <lukasz.rymanowski@tieto.com> wrote:
>>> HOG requires encryption on connection, so make sure it is on.
>>>
>>> On the other hand we don't need medium security always when
>>> connecting LE device even device are bonded. It depends on permissions
>>> on characteristics. That's why we want security low in connect_le()
>>> ---
>>>  android/gatt.c    | 6 +-----
>>>  android/hidhost.c | 4 ++++
>>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/android/gatt.c b/android/gatt.c
>>> index 9471eaf..746316d 100644
>>> --- a/android/gatt.c
>>> +++ b/android/gatt.c
>>> @@ -1419,7 +1419,6 @@ reply:
>>>
>>>  static int connect_le(struct gatt_device *dev)
>>>  {
>>> -       BtIOSecLevel sec_level;
>>>         GIOChannel *io;
>>>         GError *gerr = NULL;
>>>         char addr[18];
>>> @@ -1434,9 +1433,6 @@ static int connect_le(struct gatt_device *dev)
>>>
>>>         DBG("Connection attempt to: %s", addr);
>>>
>>> -       sec_level = bt_device_is_bonded(&dev->bdaddr) ? BT_IO_SEC_MEDIUM :
>>> -                                                               BT_IO_SEC_LOW;
>>> -
>>>         /*
>>>          * This connection will help us catch any PDUs that comes before
>>>          * pairing finishes
>>> @@ -1448,7 +1444,7 @@ static int connect_le(struct gatt_device *dev)
>>>                         BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
>>>                         BT_IO_OPT_DEST_TYPE, dev->bdaddr_type,
>>>                         BT_IO_OPT_CID, ATT_CID,
>>> -                       BT_IO_OPT_SEC_LEVEL, sec_level,
>>> +                       BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
>>>                         BT_IO_OPT_INVALID);
>>>         if (!io) {
>>>                 error("gatt: Failed bt_io_connect(%s): %s", addr,
>>> diff --git a/android/hidhost.c b/android/hidhost.c
>>> index 846dd57..1f66454 100644
>>> --- a/android/hidhost.c
>>> +++ b/android/hidhost.c
>>> @@ -777,6 +777,10 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
>>>                 bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTING);
>>>         }
>>>
>>> +       /* If device is bonded lets enable encryption */
>>> +       if (bt_device_is_bonded(addr))
>>> +               bt_gatt_set_security(addr, BT_SECURITY_MEDIUM);
>>> +
>>
>> Don't we need to wait the encryption change to only then start sending
>> commands? Actually this gets more complicate since the specs says the
>> following:
>>
>> "If the HID Host receives the L2CAP Connection Parameter Update
>> request but has not
>> yet completed service discovery or has not completed encryption, the
>> HID Host may
>> send the L2CAP Connection Parameter Update Response with the Result field
>> indicating that the request has been rejected."
>>
> As far as I understand, socket will stop flow until the security level
> is updated.
>
>> So it seems HoG may have some requirements on L2CAP as well so it is
>> not per characteristics, so perhaps connect_le should take the initial
>> security level then we can add some security requirement to
>> bt_gatt_connect_app or something like that. Btw, Im not aware of any
>> drawback regarding encryption even if is not mandatory it will just
>> make the connection more secure, but perhaps this is fixing another
>> problem?
>
> One of the drawback is GATT PTS testcase TC_GAW_CL_BV_02_C which test
> signed wrtie. Scenario is that device do bonding and exchange CSRK,
> then disconnect and connect again. Once their are reconnected signed
> write should be performed. Note that signed write is no allowed on
> encrypted link.
>
Just to be clear here, LTK is also exchange during bonding. So you
might argue that PTS should request CSRK only, but would be not sure
about that. I saw devices which request LTK and CSRK in the same time,
even though don't know if CSRK is used.

>>
>>>         if (!dev->hog) {
>>>                 /* TODO: Get device details and primary */
>>>                 dev->hog = bt_hog_new("bluez-input-device", dev->vendor,
>>> --
>>> 1.8.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
> BR
> Lukasz

\Lukasz
