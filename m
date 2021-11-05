Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8851AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AFA61183
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhKEVug (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhKEVub (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 17:50:31 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98194C061570;
        Fri,  5 Nov 2021 14:47:51 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id b3so19641016uam.1;
        Fri, 05 Nov 2021 14:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNdos9POwx5teo6slctN6D5d4noCRiJaTJnZmu9nuXI=;
        b=R47IGUQE1gMa0l78gVRe+t64y9HO/incrm3swHBtIjj7ajLTsjtDzkMsn5Q2beJrOm
         meebDsXtNI6ZAZIZcDCdShOqe5q5PUszDbAkL+em0U2cPpUbKZjubYC4rCi32oAqYBcy
         UK+4mrkD7Aflzt6cgRKVpaEa/RW9T1uJ1jvb85jCa5Paxup+Q72MEJVPc7kc5corqcgh
         ALLQvf3CmtYRJx/csNH3ZSY/QzncXXM92ezrkAjO9uychQSsrxn/r6wWIvoeJT98Uf6r
         hvV4pylNRWeLiijqIAEGib4KKi3ffDUivTPvH5r2d32wFdUMCnNi06LD9LMXNM5KE2EJ
         NLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNdos9POwx5teo6slctN6D5d4noCRiJaTJnZmu9nuXI=;
        b=KStwJ+clvsa+Ee1BOZHyo8Z2/LxNqRHeExQGkiqlijwGo3uqPDwmqqJMTkeifBpfe9
         eep9lAlm8CDbTyQiHWOSwkLmgEEQLqfgGj9QuY0J1we3HTaXHee2twCqfx43niojkhtk
         6osCjnmCmM5wZsewU35ZHbaM667UpDS5lZ01pV3Kt53cD6iXZL8TbcnHmZ+URgt6edmu
         su7g4YwWZt28kCkPKEIu+G3wupmRKp/0ouqMJ99hm/UB+z3GeVgRCy0uaenPHQU/k4Tl
         +wiFP/t+bYiY4MBjf1tYCQzEYnD5LRpsHNwo331aT3PKLHVpdT0HcWSyU58vifvBHv9A
         Iu7Q==
X-Gm-Message-State: AOAM53102SEMNpmDXnOIjrx7mGRRbzwUN7EgoyrXW9RulQPpgOnGIz9W
        brgHMODejl7PixkvQfxo1UEhoKfpPyyGe/G7Pgg=
X-Google-Smtp-Source: ABdhPJzhELxTPB/pFC8B/UNNCEbqqjXZJj3tlQEvW7XvJ/D/6pGVtHZfeP19aqSYIWCZXuIv40o//Bc6G7Z+1MB/jHM=
X-Received: by 2002:a05:6102:390f:: with SMTP id e15mr53003720vsu.10.1636148870674;
 Fri, 05 Nov 2021 14:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com>
 <20210930063106.19881-1-redecorating@protonmail.com> <20210930141256.19943-1-redecorating@protonmail.com>
 <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org> <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com>
 <20211001083412.3078-1-redecorating@protonmail.com>
In-Reply-To: <20211001083412.3078-1-redecorating@protonmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Nov 2021 14:47:39 -0700
Message-ID: <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        regressions@lists.linux.dev,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Orlando,

On Fri, Oct 1, 2021 at 1:56 AM Orlando Chamberlain
<redecorating@protonmail.com> wrote:
>
> The LE Read Transmit Power command is Advertised on some Broadcom
> controlers, but not supported. Using this command breaks Bluetooth
> on the MacBookPro16,1 and iMac20,1. Added a quirk disabling LE Read
> Transmit Power for these devices, based off their common chip id 150.
>
> Link: https://lore.kernel.org/r/4970a940-211b-25d6-edab-21a815313954@protonmail.com
> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> ---
> v1->v2: Clarified quirk description
>
>  drivers/bluetooth/btbcm.c   |  4 ++++
>  include/net/bluetooth/hci.h | 11 +++++++++++
>  net/bluetooth/hci_core.c    |  3 ++-
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index e4182acee488..4ecc50d93107 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -353,6 +353,10 @@ static int btbcm_read_info(struct hci_dev *hdev)
>                 return PTR_ERR(skb);
>
>         bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
> +
> +       if (skb->data[1] == 150)
> +               set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
> +
>         kfree_skb(skb);
>
>         /* Read Controller Features */
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index b80415011dcd..6da9bd6b7259 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -246,6 +246,17 @@ enum {
>          * HCI after resume.
>          */
>         HCI_QUIRK_NO_SUSPEND_NOTIFIER,
> +
> +       /* When this quirk is set, LE Read Transmit Power is disabled.
> +        * This is mainly due to the fact that the HCI LE Read Transmit
> +        * Power command is advertised, but not supported; these
> +        * controllers often reply with unknown command and need a hard
> +        * reset.
> +        *
> +        * This quirk can be set before hci_register_dev is called or
> +        * during the hdev->setup vendor callback.
> +        */
> +       HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
>  };
>
>  /* HCI device flags */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8a47a3017d61..9a23fe7c8d67 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -742,7 +742,8 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>                         hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
>                 }
>
> -               if (hdev->commands[38] & 0x80) {
> +               if (hdev->commands[38] & 0x80 &&
> +                       !test_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks)) {
>                         /* Read LE Min/Max Tx Power*/
>                         hci_req_add(req, HCI_OP_LE_READ_TRANSMIT_POWER,
>                                     0, NULL);
> --
> 2.33.0

Nowadays it is possible to treat errors such like this on a per
command basis (assuming it is not essential for the init sequence):

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 979da5179ff4..f244f42cc609 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -551,6 +551,7 @@ enum {
 #define HCI_LK_AUTH_COMBINATION_P256   0x08

 /* ---- HCI Error Codes ---- */
+#define HCI_ERROR_UNKNOWN_CMD          0x01
 #define HCI_ERROR_UNKNOWN_CONN_ID      0x02
 #define HCI_ERROR_AUTH_FAILURE         0x05
 #define HCI_ERROR_PIN_OR_KEY_MISSING   0x06
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bb88d31d2212..9c697e058974 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3325,11 +3325,18 @@ static int
hci_le_read_adv_tx_power_sync(struct hci_dev *hdev)
 /* Read LE Min/Max Tx Power*/
 static int hci_le_read_tx_power_sync(struct hci_dev *hdev)
 {
+       int status;
+
        if (!(hdev->commands[38] & 0x80))
                return 0;

-       return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_TRANSMIT_POWER,
-                                    0, NULL, HCI_CMD_TIMEOUT);
+       status = __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_TRANSMIT_POWER,
+                                      0, NULL, HCI_CMD_TIMEOUT);
+       /* Ignore if command is not really supported */
+       if (status == HCI_ERROR_UNKNOWN_CMD)
+               return 0;
+
+       return status;
 }

 /* Read LE Accept List Size */

Anyway, it would probably be worth pointing out to the vendor they
have a broken firmware if they do mark the command as supported but
return such error.

-- 
Luiz Augusto von Dentz
