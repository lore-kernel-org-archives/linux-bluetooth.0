Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F3DC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 10:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B20A2076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRmQMq5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgCRK3j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:29:39 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43567 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCRK3i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 06:29:38 -0400
Received: by mail-il1-f195.google.com with SMTP id d14so22573947ilq.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80pv1GVAxZkJLTFlfZquFenVfCioxh24u7CwKc7q0pA=;
        b=gRmQMq5WqIkMaMcre1pE4HWm23Zm1ADSJI4mlLkF311BDQBCxLlMvnzILdyvuR4Rbu
         4Z/YWWoTjJWjCc1tupsPb/ko0PnyjgMPiwxRcWfHLV4gRoqzZRfaTXRDHIYuzcOfqTJ7
         4DnKzCQr3iEw9sXzxjDJOkrvVY0bQ1UjKxYIrjUWLT12CHFBYuNmM1PheldIXvoRyke7
         +6aBE0drziWv3W7XzufJyqSTYbJPmNW1NUtJg7uCBcS/w7DsIK2V2mAWntGPUTFNPCgG
         aBrDJoMTejAmwvhy2/uqD1kizUlISraMUcx0+BVsxy2PqhYuZebB/7dp/ygxY/eF7taR
         dtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80pv1GVAxZkJLTFlfZquFenVfCioxh24u7CwKc7q0pA=;
        b=gWH4NZDdfOIyvCK+QrH9RgvBlqruK9sItamI63JTiZURw0plRp/3NkYoMkwoJ22mRg
         IOTjaoixsjTQGXEx+G466pqizval94q36bwQYKIqQGs780bErbA4Ky7t2ZrgU6AOJVe7
         UllXh53OYlh3of54bnHupA5KtvsdavxV4sLbUth6v8yh+Pzxd36Gq67c1Qf+zJ0OpBUs
         luBDcIkJoN1eOmmrywDYZdR1aG1fnrIoXFfExMTNJTyUqFH52S55RjnmwXwTHNAagPR/
         OsMt9tVW2XqnDuFQ3hqGrOTJsHZdAaZEADkvU8mEA3YEa1iVDCoU/hSmy4JwuPCiSyba
         gU8g==
X-Gm-Message-State: ANhLgQ3IU2346n8CEMzM9VQiSFLuonA8q0JBpa1VzuRNCRcxs/3quMaY
        qcceoinzsQym6SRylWarLtTIedcKdlQXnh4s91g=
X-Google-Smtp-Source: ADFU+vsT3xcm3MibLeQcTcp1jq4Igp56EdLMKgFFzDmh1G/XCwG0HqJ8i2Pu+5M5Zqzyt4yYJoJaoaS9ihO9ByROAck=
X-Received: by 2002:a92:3b8c:: with SMTP id n12mr3185069ilh.186.1584527377358;
 Wed, 18 Mar 2020 03:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
 <20200312100754.3445-3-sathish.narasimman@intel.com> <3330738.rHcyvYZEMk@ix>
In-Reply-To: <3330738.rHcyvYZEMk@ix>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 18 Mar 2020 15:59:25 +0530
Message-ID: <CAOVXEJLqB=-vG4+vn0n2mUZOzR7jOcDpumUL2A-OaSyWiFFCmg@mail.gmail.com>
Subject: Re: [PATCH 2/7] Bluetooth: Add device to Resolving List
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sathish Narsimman <sathish.narasimman@intel.com>,
        Joy Shermin <shermin.joy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon,

On Wed, Mar 18, 2020 at 3:00 PM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> Hi,
>
> On Thursday, 12 March 2020 11:07:49 CET Sathish Narsimman wrote:
> > The Patch is used to add the device to resolving list. The patch
> > will look for the local IRK list and if the device is present in
> > the local resolving list it will be updated and the same updated
> > w.r.t to BT controller by first deleting the existing and adding
> > the new IRK w.r.t bd_addr.
> >
> > Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> > Signed-off-by: Joy Shermin <shermin.joy@intel.com>
> > ---
> >  include/net/bluetooth/hci_core.h |  2 +
> >  net/bluetooth/hci_request.c      | 80 ++++++++++++++++++++++++++++++++
> >  2 files changed, 82 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h index 5f04ef88da35..e5e09d530ce7 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1657,6 +1657,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le16
> > ediv, __le64 rand,
> >
> >  void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
> >                              u8 *bdaddr_type);
> > +int hci_req_update_resolving_list(struct hci_dev *hdev,  u8 addr_type,
> > +                               bdaddr_t *bdaddr, u8 irk[16]);
> >  void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
> >                                    bdaddr_t *bdaddr);
> >
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index f4bbd3b79210..88225a9ca1f8 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -885,6 +885,86 @@ static void hci_req_start_scan(struct hci_request *req,
> > u8 type, u16 interval, }
> >  }
> >
> > +int hci_req_update_resolving_list(struct hci_dev *hdev, u8 type, bdaddr_t
> > *bdaddr, +                              u8 irk_val[16])
> > +{
> > +     struct hci_request req;
> > +     struct hci_cp_le_add_to_resolv_list cp;
> > +     struct bdaddr_list_with_irk *irk;
> > +     u8 entries;
> > +
> > +     BT_DBG("");
> > +
> > +     /* Nothing to be done if LL privacy is not supported */
> > +     if ( !(hdev->le_features[0] & HCI_LE_LL_PRIVACY) )
> > +             return -EPROTONOSUPPORT;
> > +
> > +     /* Resolving List cannot be updated if address resolution
> > +      * in the controller is enabled and advertisement or scanning
> > +      * or create connection command is ongoing.
> > +      */
> > +     if ( !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
> > +         ( hci_dev_test_flag(hdev, HCI_LE_ADV) ||
> > +           hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
> > +           hci_lookup_le_connect(hdev) ) )
> > +             return -EINVAL;
> > +
> > +     hci_req_init(&req, hdev);
> > +
> > +     irk = hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list, bdaddr,
> > type); +      if (irk) {
> > +             /* Device is present in resolving list.*/
> > +             if (memcmp(irk->peer_irk, irk_val, 16) == 0) {
> > +                     /* Device present in resolving list with same
> IRK.
> > +                      * No HCI communication is required.Sort the
> > +                      * Kernel list.
> > +                      */
> > +                     hci_bdaddr_list_add_with_irk(&irk->list, bdaddr,
> type, irk_val, NULL);
> > +                     return 0;
> > +
> > +             }
> > +             /* IRK has changed for the device in resolving list
> > +              * Queue up commands to delete the existing entry and
> > +              * add new one. Sorting will be done when command complete
> > +              * for add command is receieved.
> > +              */
> > +             goto remote;
> > +     }
> > +     /* Device is not present in resolving list.If resolving list
> > +      * is not full add the device to resolving list.
> > +      */
> > +     entries = 0;
> > +     list_for_each_entry(irk, &hdev->le_resolv_list, list) {
> > +             entries++;
> > +     }
> > +
> > +     if (entries < hdev->le_resolv_list_size)
> > +             goto add;
> > +
> > +     /* If the resolving list is full, queue up HCI command to delete
> > +      * the entry that was used least recently to make space for the
> > +      * new device. Kernel list will be updated when command complete
> > +      * is received.
> > +      */
> > +     irk = list_first_entry_or_null(&hdev->le_resolv_list, struct
> > bdaddr_list_with_irk, list); +
> > +     if (!irk)
> > +             return -1;
>
> I'm not sure about this... we should have some fallback mechanism when HW RL
> is full. Maybe some rotation of devies on list or simply disable address
> resolution in controller? Otherwise we won't be able to connect to some of
> paired devices.
What I understood was
if (HW RL is full) {
don't delete the device from the kernel resolving list.
delete the device from HW RL list(least used)
but we have to use a method to denote that it is deleted from HW RL list.
}
from the above method at what scenario we need to add the deleted
device back to the HW RL list?

And yes disabling HW RL list much simpler.
>
> > +
> > +remote:
> > +     hci_req_del_from_resolving_list(hdev, irk->bdaddr_type, &irk-
> >bdaddr);
> > +
> > +add:
> > +     cp.bdaddr_type = type;
> > +     bacpy(&cp.bdaddr, bdaddr);
> > +     memcpy(cp.peer_irk, irk_val, 16);
> > +     memcpy(cp.local_irk, hdev->irk, 16);
> > +
> > +     hci_req_add(&req, HCI_OP_LE_ADD_TO_RESOLV_LIST, sizeof(cp), &cp);
> > +     hci_req_run(&req, NULL);
> > +     return 0;
> > +}
> > +
> >  void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
> > bdaddr_t *bdaddr) {
> >       struct hci_cp_le_del_from_resolv_list cp;
>
>
> --
> pozdrawiam
> Szymon Janc
>
>
Regards
Sathish N
