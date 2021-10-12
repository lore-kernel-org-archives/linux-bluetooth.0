Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E72C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 15:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8AA96103D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 15:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhJLP6h convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:58:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56225 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbhJLP6g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 11:58:36 -0400
Received: from smtpclient.apple (p4fefcb73.dip0.t-ipconnect.de [79.239.203.115])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5D9C2CECE1;
        Tue, 12 Oct 2021 17:56:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v1] Bluetooth: btintel: Fix bdaddress comparison with
 garbage value
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <DM8PR11MB557322FB90F730BDE853E742F5B19@DM8PR11MB5573.namprd11.prod.outlook.com>
Date:   Tue, 12 Oct 2021 17:56:32 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "An, Tedd" <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <23272CA9-FEE5-4E66-942F-E66FA1E513ED@holtmann.org>
References: <20211005042613.9946-1-kiran.k@intel.com>
 <79B0A1CF-17D0-473C-A321-39E1BC291A89@holtmann.org>
 <CABBYNZL9f1j6sEcNm6B9ONg6yV=Pt=msuOd3Urb-0d-5vmm7qw@mail.gmail.com>
 <DM8PR11MB557322FB90F730BDE853E742F5B19@DM8PR11MB5573.namprd11.prod.outlook.com>
To:     "K, Kiran" <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

>>>> Intel Read Verision(TLV) data is parsed into a local structure
>>>> variable and it contains a field for bd address. Bd address is
>>>> returned only in bootloader mode and hence bd address in TLV
>>>> structure needs to be validated only if controller is present in boot loader
>> mode.
>>>> 
>>>> Signed-off-by: Kiran K <kiran.k@intel.com>
>>>> ---
>>>> drivers/bluetooth/btintel.c | 19 +++++++++++--------
>>>> 1 file changed, 11 insertions(+), 8 deletions(-)
>>>> 
>>>> diff --git a/drivers/bluetooth/btintel.c
>>>> b/drivers/bluetooth/btintel.c index 9359bff47296..d1703cc99705
>>>> 100644
>>>> --- a/drivers/bluetooth/btintel.c
>>>> +++ b/drivers/bluetooth/btintel.c
>>>> @@ -2081,14 +2081,16 @@ static int
>> btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
>>>>      if (ver->img_type == 0x03) {
>>>>              btintel_clear_flag(hdev, INTEL_BOOTLOADER);
>>>>              btintel_check_bdaddr(hdev);
>>>> -     }
>>>> -
>>>> -     /* If the OTP has no valid Bluetooth device address, then there will
>>>> -      * also be no valid address for the operational firmware.
>>>> -      */
>>>> -     if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
>>>> -             bt_dev_info(hdev, "No device address configured");
>>>> -             set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
>>>> +     } else {
>>>> +             /*
>>>> +              * Check for valid bd address in boot loader mode. Device
>>>> +              * will be marked as unconfigured if empty bd address is
>>>> +              * found.
>>>> +              */
>>>> +             if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
>>>> +                     bt_dev_info(hdev, "No device address configured");
>>>> +                     set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
>>>> +             }
>>>>      }
>>>> 
>>>>      btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
>>>> @@ -2466,6 +2468,7 @@ static int btintel_setup_combined(struct
>> hci_dev *hdev)
>>>>              goto exit_error;
>>>>      }
>>>> 
>>>> +     memset(&ver_tlv, 0, sizeof(ver_tlv));
>>> 
>>> this change is not described in the commit message. Why is that now out of
>> a sudden needed?
>> 
>> I guess this is just to make sure the ver_tlv is initialized so its otp_bd_addr be
>> set to all zeros (BDADDR_ANY) otherwise the code above doesn't work as it
>> attempts to compare to BDADDR_ANY.
> 
> Yes. If not memset, then garbage value is compared against BDADDR_ANY.

since that is not obviously clear, the takeaway from my review should have been that you either describe this properly in the commit message or you add a comment.

Regards

Marcel

