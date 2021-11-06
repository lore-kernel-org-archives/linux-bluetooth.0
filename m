Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC91BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Nov 2021 11:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D3D6124F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Nov 2021 11:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhKFLwb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Nov 2021 07:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhKFLwb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Nov 2021 07:52:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD8CF60E05;
        Sat,  6 Nov 2021 11:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636199390;
        bh=cdpSPlGsEnb/lcSvrJVtwq6HXa4Y0hRruNA1ZcaG6l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AcQuTszFmER9joRbKeCxXpKF80wWwSxUOsWVvybGHalmz8PwcC3BSt6XRpzYM5pdl
         Lvk1qkRFbhFJd796pyJL5OdZpZiRIR793YQ8siSeN8w63U9WKKBbHuiKh7iTRHVgfH
         VCoj4YmmFplgFEP2ecCr4WEMBB+NRwy16FpI81Jc=
Date:   Sat, 6 Nov 2021 12:49:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Message-ID: <YYZr14zwHnd52rQ7@kroah.com>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com>
 <20210930063106.19881-1-redecorating@protonmail.com>
 <20210930141256.19943-1-redecorating@protonmail.com>
 <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org>
 <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com>
 <20211001083412.3078-1-redecorating@protonmail.com>
 <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
 <972034A8-4B22-4FEE-9B37-C0A7C7ADD60C@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <972034A8-4B22-4FEE-9B37-C0A7C7ADD60C@live.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, Nov 06, 2021 at 09:41:28AM +0000, Aditya Garg wrote:
> 
> 
> > On 06-Nov-2021, at 3:17 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> > 
> > Hi Orlando,
> > 
> > On Fri, Oct 1, 2021 at 1:56 AM Orlando Chamberlain
> > <redecorating@protonmail.com> wrote:
> >> 
> >> The LE Read Transmit Power command is Advertised on some Broadcom
> >> controlers, but not supported. Using this command breaks Bluetooth
> >> on the MacBookPro16,1 and iMac20,1. Added a quirk disabling LE Read
> >> Transmit Power for these devices, based off their common chip id 150.
> >> 
> >> Link: https://lore.kernel.org/r/4970a940-211b-25d6-edab-21a815313954@protonmail.com
> >> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> >> ---
> >> v1->v2: Clarified quirk description
> >> 
> >> drivers/bluetooth/btbcm.c   |  4 ++++
> >> include/net/bluetooth/hci.h | 11 +++++++++++
> >> net/bluetooth/hci_core.c    |  3 ++-
> >> 3 files changed, 17 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> >> index e4182acee488..4ecc50d93107 100644
> >> --- a/drivers/bluetooth/btbcm.c
> >> +++ b/drivers/bluetooth/btbcm.c
> >> @@ -353,6 +353,10 @@ static int btbcm_read_info(struct hci_dev *hdev)
> >>                return PTR_ERR(skb);
> >> 
> >>        bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
> >> +
> >> +       if (skb->data[1] == 150)
> >> +               set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
> >> +
> >>        kfree_skb(skb);
> >> 
> >>        /* Read Controller Features */
> >> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> >> index b80415011dcd..6da9bd6b7259 100644
> >> --- a/include/net/bluetooth/hci.h
> >> +++ b/include/net/bluetooth/hci.h
> >> @@ -246,6 +246,17 @@ enum {
> >>         * HCI after resume.
> >>         */
> >>        HCI_QUIRK_NO_SUSPEND_NOTIFIER,
> >> +
> >> +       /* When this quirk is set, LE Read Transmit Power is disabled.
> >> +        * This is mainly due to the fact that the HCI LE Read Transmit
> >> +        * Power command is advertised, but not supported; these
> >> +        * controllers often reply with unknown command and need a hard
> >> +        * reset.
> >> +        *
> >> +        * This quirk can be set before hci_register_dev is called or
> >> +        * during the hdev->setup vendor callback.
> >> +        */
> >> +       HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
> >> };
> >> 
> >> /* HCI device flags */
> >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> index 8a47a3017d61..9a23fe7c8d67 100644
> >> --- a/net/bluetooth/hci_core.c
> >> +++ b/net/bluetooth/hci_core.c
> >> @@ -742,7 +742,8 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
> >>                        hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
> >>                }
> >> 
> >> -               if (hdev->commands[38] & 0x80) {
> >> +               if (hdev->commands[38] & 0x80 &&
> >> +                       !test_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks)) {
> >>                        /* Read LE Min/Max Tx Power*/
> >>                        hci_req_add(req, HCI_OP_LE_READ_TRANSMIT_POWER,
> >>                                    0, NULL);
> >> --
> >> 2.33.0
> > 
> > Nowadays it is possible to treat errors such like this on a per
> > command basis (assuming it is not essential for the init sequence):
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 979da5179ff4..f244f42cc609 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -551,6 +551,7 @@ enum {
> > #define HCI_LK_AUTH_COMBINATION_P256   0x08
> > 
> > /* ---- HCI Error Codes ---- */
> > +#define HCI_ERROR_UNKNOWN_CMD          0x01
> > #define HCI_ERROR_UNKNOWN_CONN_ID      0x02
> > #define HCI_ERROR_AUTH_FAILURE         0x05
> > #define HCI_ERROR_PIN_OR_KEY_MISSING   0x06
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> This diff cannot be applied to stable 5.15. Could you provide a patch capable of being applied to stable.

That is not needed until a patch is in Linus's tree.  Why do you need it
earlier?

thanks,

greg k-h
