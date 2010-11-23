Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101122164623.GB8882@bicker>
References: <1290424125-2717-1-git-send-email-pavan_savoy@ti.com>
	<20101122164623.GB8882@bicker>
Date: Tue, 23 Nov 2010 18:07:11 +0530
Message-ID: <AANLkTik0WAK9QvDeXWb7n07TPAadXn6fYsYgjjfUE0uJ@mail.gmail.com>
Subject: Re: [PATCH v6] Bluetooth: btwilink driver
From: Pavan Savoy <pavan_savoy@sify.com>
To: Dan Carpenter <error27@gmail.com>, pavan_savoy@ti.com, marcel@holtmann.org,
	padovan@profusion.mobi, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Dan, Marcel, Gustavo,

On Mon, Nov 22, 2010 at 10:16 PM, Dan Carpenter <error27@gmail.com> wrote:
> On Mon, Nov 22, 2010 at 06:08:45AM -0500, pavan_savoy@ti.com wrote:
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
>> + =C2=A0 =C2=A0 hdev->owner =3D THIS_MODULE;
>> +
>> + =C2=A0 =C2=A0 err =3D hci_register_dev(hdev);
>> + =C2=A0 =C2=A0 if (err < 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BT_ERR("Can't register HCI d=
evice error %d", err);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hci_free_dev(hdev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Should there be a kfree(hst); here? =C2=A0That=
's how it's done in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bpa10x_probe() from drivers/bluetooth/bpa10x.c
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 BT_DBG(" HCI device registered (hdev %p)", hdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Quite a few places have an extra space at the =
start.
>
>> +
>> + =C2=A0 =C2=A0 dev_set_drvdata(&pdev->dev, hst);
>> + =C2=A0 =C2=A0 return err;
>> +}
>
> regards,
> dan carpenter

Thanks Dan for the comments,
Marcel, Gustavo - Please provide your comments too... So I can bundle
them all and post a v7 ....

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
