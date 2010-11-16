Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101116225418.GA15101@vigoh>
References: <1289394446-14021-1-git-send-email-pavan_savoy@ti.com>
	<20101116225418.GA15101@vigoh>
Date: Wed, 17 Nov 2010 00:20:43 +0100
Message-ID: <AANLkTi=TxKKxjLdK-6Jwu9oBCiGHXJ8UxrAQH+C82wNK@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: btwilink driver
From: Vitaly Wool <vitalywool@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: pavan_savoy@ti.com, marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

>> + =A0 =A0 /* Registration with ST layer is successful,
>> + =A0 =A0 =A0* hardware is ready to accept commands from HCI core.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (test_and_set_bit(HCI_RUNNING, &hdev->flags)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(HCI_RUNNING, &hdev->flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D st_unregister(ST_BT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("st_unregister() failed=
 with error %d", err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 hst->st_write =3D NULL;
>> + =A0 =A0 }
>
>
> What are you trying to do here? test_and_set_bit() result doesn't say
> nothing about error and you shall put test_and_set_bit should be in the
> beginning, to know if your device is already opened or not and then
> clear_bit if some error ocurrs during the function.
>

Yeap, this piece of code beats me is well. Why is it an error if this
bit wasn't already set?

~Vitaly
