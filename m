Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110207105453.GZ874@null>
References: <1297075132-4694-1-git-send-email-pavan_savoy@ti.com>
	<20110207105453.GZ874@null>
Date: Mon, 7 Feb 2011 16:30:40 +0530
Message-ID: <AANLkTinfHt8FppFnVTtvX8qqjrEQU_VYY96_d=Xy3oPh@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btwilink driver
From: Pavan Savoy <pavan_savoy@sify.com>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Feb 7, 2011 at 4:24 PM, Ville Tervo <ville.tervo@nokia.com> wrote:
> Hi Pavan,
>
> On Mon, Feb 07, 2011 at 04:38:52AM -0600, ext pavan_savoy@ti.com wrote:
>> From: Pavan Savoy <pavan_savoy@ti.com>
>>
>> Gustavo,
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
> Will do. Some comment
>
>> +/* Called from HCI core to initialize the device */
>> +static int ti_st_open(struct hci_dev *hdev)
>> +{
>> +     unsigned long timeleft;
>> +     struct ti_st *hst;
>> +     int err, i;
>> +
>> +     BT_DBG("%s %p", hdev->name, hdev);
>> +
>> +     if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
>> +             return -EBUSY;
>> +
>> +     /* provide contexts for callbacks from ST */
>> +     hst = hdev->driver_data;
>> +
>> +     for (i = 0; i < MAX_BT_CHNL_IDS; i++) {
>> +             ti_st_proto[i].priv_data = hst;
>> +             ti_st_proto[i].max_frame_size = HCI_MAX_FRAME_SIZE;
>> +
>> +             err = st_register(&ti_st_proto[i]);
>> +             if (!err)
>> +                     goto done_downloading_firmware;
>> +
>> +             if (err != -EINPROGRESS) {
>> +                     clear_bit(HCI_RUNNING, &hdev->flags);
>> +                     BT_ERR("st_register failed %d", err);
>> +                     return err;
>> +             } else {
>
> No need for else. Less indentation looks better to me at least.

OK, can do this.

>> +                     /* ST is busy with either protocol
>> +                      * registration or firmware download.
>> +                      */
>> +                     /* Prepare wait-for-completion handler data structures.
>> +                     */
>> +                     init_completion(&hst->wait_reg_completion);
>
> init_completion should be done before startin action which executes complete().
> IOW this should be before st_register if I understood this correctly.
>
> Otherwise the started action might call complete before init_completion and
> wait_for_completion_timeout will just time even everything went fine.

Humn, May be, However I would want to wait only when I am supposed to,
As in if EINPROGRESS happens (i.e firmware is already being downloaded because
of say FM or GPS..) then I would want to wait, Or else - I continue.

But Yes, may be having the INIT_COMPLETION before would not hurt in
that case either. (Haven't seen it fail though !! - even after testing
FM/GPS with BT multiple times..)

> --
> Ville
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
