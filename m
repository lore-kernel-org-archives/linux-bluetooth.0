Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110208181659.GB2160@joana>
References: <1297080737-21032-1-git-send-email-pavan_savoy@ti.com>
	<20110208181659.GB2160@joana>
Date: Wed, 9 Feb 2011 11:48:30 +0530
Message-ID: <AANLkTimV3ojyTqgvBnpN8+xgMTYpVeJn2+OriGW3Bed0@mail.gmail.com>
Subject: Re: [PATCH v9] Bluetooth: btwilink driver
From: Pavan Savoy <pavan_savoy@sify.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Gustavo,

On Tue, Feb 8, 2011 at 11:46 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Pavan,
>
> * pavan_savoy@ti.com <pavan_savoy@ti.com> [2011-02-07 06:12:17 -0600]:
>
>> From: Pavan Savoy <pavan_savoy@ti.com>
>>
>> Gustavo,
>>
>> Find below the patch version v9.
>> Have taken care of Ville's comments.
>> In addition fixed the issue seen when built as module, with
>> repeated probe/remove of the platform driver.

> Then remove this function...

hci_core fails the register if the destruct function is not set.
So I had kept the function.....

I will shorten the goto label and re-submit.
I hope that should be fine...


>> +static int bt_ti_probe(struct platform_device *pdev)
>> +{
>> + =C2=A0 =C2=A0 static struct ti_st *hst;
>> + =C2=A0 =C2=A0 struct hci_dev *hdev;
>> + =C2=A0 =C2=A0 int err;
>> +
>> + =C2=A0 =C2=A0 hst =3D kzalloc(sizeof(struct ti_st), GFP_KERNEL);
>> + =C2=A0 =C2=A0 if (!hst)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> +
>> + =C2=A0 =C2=A0 /* Expose "hciX" device to user space */
>> + =C2=A0 =C2=A0 hdev =3D hci_alloc_dev();
>> + =C2=A0 =C2=A0 if (!hdev) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(hst);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 BT_DBG("hdev %p", hdev);
>> +
>> + =C2=A0 =C2=A0 hst->hdev =3D hdev;
>> + =C2=A0 =C2=A0 hdev->bus =3D HCI_UART;
>> + =C2=A0 =C2=A0 hdev->driver_data =3D hst;
>> + =C2=A0 =C2=A0 hdev->open =3D ti_st_open;
>> + =C2=A0 =C2=A0 hdev->close =3D ti_st_close;
>> + =C2=A0 =C2=A0 hdev->flush =3D NULL;
>> + =C2=A0 =C2=A0 hdev->send =3D ti_st_send_frame;
>> + =C2=A0 =C2=A0 hdev->destruct =3D ti_st_destruct;
>
> ...and also the line that sets it.
>
> --
> Gustavo F. Padovan
> http://profusion.mobi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
