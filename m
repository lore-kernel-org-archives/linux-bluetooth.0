Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1290602554.13641.13.camel@aeonflux.mpl.access-company.com>
References: <1290423434-2920-1-git-send-email-anderson.lizardo@openbossa.org>
	<1290602554.13641.13.camel@aeonflux.mpl.access-company.com>
Date: Wed, 24 Nov 2010 11:13:30 -0400
Message-ID: <AANLkTi=pwDA5JQCoz4QNO=mLAHuW+moNOEO4Nqz3jQrJ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix error handling for l2cap_init()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Nov 24, 2010 at 8:42 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index 18a802c..7980e24 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -4875,8 +4875,10 @@ static int __init l2cap_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>
>> =A0 =A0 =A0 _busy_wq =3D create_singlethread_workqueue("l2cap");
>> - =A0 =A0 if (!_busy_wq)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>> + =A0 =A0 if (!_busy_wq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_busy_wq;
>> + =A0 =A0 }
>
> aren't these returning PTR_ERR etc.?

No, create_singlethread_workqueue() is just a wrapper around
__alloc_workqueue_key(), which returns eiter a kzalloc()'ed pointer,
or NULL on error. There is no way to get the actual reason of the
error, but by taking a look at the function we can see most (if not
all) errors are -ENOMEM. Thus why I used it here.

Padovan: so how to proceed here: keep the patch as is and keep
semantics, of make your proposed changes (with a slightly risk of a
race condition and having _busy_wq NULL) ?

Regards,
--=20
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
