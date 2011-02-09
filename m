Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: pavan_savoy@sify.com
In-Reply-To: <20110209101940.GG874@null>
References: <1297237177-5555-1-git-send-email-pavan_savoy@ti.com>
	<20110209101940.GG874@null>
Date: Wed, 9 Feb 2011 16:05:17 +0530
Message-ID: <AANLkTik+1BqGetDH0K=PU-DxigztuVZc3ki7746-oJZ9@mail.gmail.com>
Subject: Re: [PATCH v10] Bluetooth: btwilink driver
From: Pavan Savoy <pavan_savoy@ti.com>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 9, 2011 at 3:49 PM, Ville Tervo <ville.tervo@nokia.com> wrote:
> Hi Pavan,
>
> On Wed, Feb 09, 2011 at 01:39:37AM -0600, ext pavan_savoy@ti.com wrote:
>> From: Pavan Savoy <pavan_savoy@ti.com>
>>
>> Gustavo,
>>
>> v10,
>> fixing the really long goto label.
>>
>> Find below the patch version v9.
>> Have taken care of Ville's comments.
>> In addition fixed the issue seen when built as module, with
>> repeated probe/remove of the platform driver.
>>
>> patch v8 comments taken care,
>>
>> As suggested, the modifications to TI ST driver to remove the bluetooth
>> references have been made and the changes have been merged to the
>> linux-next tree.
>>
>> Find below the patch for the btwilink driver,
>> I have taken care of your following comments,
>> 1. channel IDs and the offsets are now being taken from the
>> header file hci.h.
>> 2. removed the un-necessary BT_ERR.
>> 3. changed the order during return from st_register.
>> 4. continue to unregister even if 1st unregister fails.
>>
>> Please review and provide comments,
>
> One more comment.
>
>> +/* Called from HCI core to initialize the device */
>> +static int ti_st_open(struct hci_dev *hdev)
>> +{
>> + =C2=A0 =C2=A0 unsigned long timeleft;
>> + =C2=A0 =C2=A0 struct ti_st *hst;
>> + =C2=A0 =C2=A0 int err, i;
>> +
>> + =C2=A0 =C2=A0 BT_DBG("%s %p", hdev->name, hdev);
>> +
>> + =C2=A0 =C2=A0 if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;
>> +
>> + =C2=A0 =C2=A0 /* provide contexts for callbacks from ST */
>> + =C2=A0 =C2=A0 hst =3D hdev->driver_data;
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < MAX_BT_CHNL_IDS; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ti_st_proto[i].priv_data =3D=
 hst;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ti_st_proto[i].max_frame_siz=
e =3D HCI_MAX_FRAME_SIZE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ti_st_proto[i].recv =3D st_r=
eceive;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ti_st_proto[i].reg_complete_=
cb =3D st_reg_completion_cb;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Prepare wait-for-completi=
on handler */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 init_completion(&hst->wait_r=
eg_completion);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D st_register(&ti_st_p=
roto[i]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!err)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
goto done;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err !=3D -EINPROGRESS) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
clear_bit(HCI_RUNNING, &hdev->flags);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
BT_ERR("st_register failed %d", err);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return err;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ST is busy with either pr=
otocol
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* registration or firm=
ware download.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reset ST registration cal=
lback status flag,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* this value will be u=
pdated in
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* st_reg_completion_cb=
()
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* function whenever it=
 called from ST driver.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hst->reg_status =3D -EINPROG=
RESS;
>
> reg_status initialization should be moved also before st_register(). Reas=
on is
> again the same as for init_completion.

You under-estimate the time taken for firmware download :)
Yes alright, I agree it makes more sense to put it up there.

Will fix up and resend....


> --
> Ville
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
