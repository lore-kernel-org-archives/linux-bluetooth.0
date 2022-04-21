Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8A7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 21:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442234AbiDUVym (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387986AbiDUVyl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 17:54:41 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614EC4E382
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:51:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v12-20020a9d7d0c000000b006054b51c3d4so4173119otn.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYTHPceTX5qHeo6cl26z2+CQI9915fzGclNjwBHEaMM=;
        b=dJfKDFd0xGGrWJ7IqyfhfBenkpfAMSKFNUEEHWQD1XTg807WDEeopqPcNRuTRtber4
         DE0vRMipvFI5VDsTm5L5LMevMrdm8orLQFMrNt9KcU+Bl8T3+Wa4ZMOfZmXJNzbj2LEy
         WAb8RYknJ4e3XvBdF6hzSWAuAsPDXHphTzvM7zlyPfF1et2DnN4h3p2+2okXGzawGr5s
         WN+i5xjCy7ve4buAE0905znIi6zDzbkxV4yS0/OSLQG2H3sRNGGnZyiQhvZWmB9odwaH
         NzhHZ1J83NQIIhL7+mGXv2+61h16pHw0mBaBCq7g3/HrM7Szuu1EHOwsRDX8icUzn0H6
         L+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYTHPceTX5qHeo6cl26z2+CQI9915fzGclNjwBHEaMM=;
        b=5LSRkIfTT4bmJ90k1r0IurDMHpJeed8BalcA6xsZvD66lCuLelRXN7F9MqZ5N4lOuw
         pIAsf5pVEAm3UZ8j7Wq5LHQbH6fPnsP+IPqf2oiE1iwrC3uCUkR17aFIGPe//0hGp9lF
         5yHcGxo4fkvHLR2l6bgezPChhzuUnkSDn1yF89A9oQ+RPxGcgnvU6ws7+rtR2HXdvEyI
         IWTOUGLhCNtQqF0SzKItdxHN/zVvEdaa1qiYqJODjCH7wAGBkhugXuO//QydvWEwBGTb
         XqiyuWZr0gXgimMqBuFG1V4a+gddg8tvX85WKiBkrDwGjwr8V/eeG6Wh2y9UvOo1eb2m
         de/w==
X-Gm-Message-State: AOAM531ReRUEZcBErp9o7VQvIjIX8F0HwKD3NO3xM4SuXx6n3xBE3U6K
        AzknGGOgZWZd/Mz2EViArP2f0WoEEq0mNl0rn8OUo8CA
X-Google-Smtp-Source: ABdhPJzvWZfAF6RXiRyhgfYQDhixOQxoa5Dhzwc1B03eDq4UN2/xYi7yfOrY5ksGdiC6gFSIPIZ0XqYvCqx9zJhsiF0=
X-Received: by 2002:a9d:5a19:0:b0:5cd:9ca0:898b with SMTP id
 v25-20020a9d5a19000000b005cd9ca0898bmr701182oth.318.1650577909268; Thu, 21
 Apr 2022 14:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220405215207.1415731-1-luiz.dentz@gmail.com>
In-Reply-To: <20220405215207.1415731-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 Apr 2022 14:51:37 -0700
Message-ID: <CABBYNZKAjfPY_g+OirbPFaxCRf4VDjxyxjG+gFEPFxRJ7P==Cw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Split hci_dev_open_sync
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Apr 5, 2022 at 2:52 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This splits hci_dev_open_sync so each stage is handle by its own
> function so it is easier to identify each stage.
>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_sync.c | 255 ++++++++++++++++++++++-----------------
>  1 file changed, 141 insertions(+), 114 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 5610ec1242d6..2d3b9adbd215 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3849,9 +3849,148 @@ static const struct {
>                          "advertised, but not supported.")
>  };
>
> -int hci_dev_open_sync(struct hci_dev *hdev)
> +/* This function handles hdev setup stage:
> + *
> + * Calls hdev->setup
> + * Setup address if HCI_QUIRK_USE_BDADDR_PROPERTY is set.
> + */
> +static int hci_dev_setup_sync(struct hci_dev *hdev)
>  {
>         int ret = 0;
> +       bool invalid_bdaddr;
> +       size_t i;
> +
> +       if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
> +           !test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks))
> +               return 0;
> +
> +       bt_dev_dbg(hdev, "");
> +
> +       hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> +
> +       if (hdev->setup)
> +               ret = hdev->setup(hdev);
> +
> +       for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
> +               if (test_bit(hci_broken_table[i].quirk, &hdev->quirks))
> +                       bt_dev_warn(hdev, "%s", hci_broken_table[i].desc);
> +       }
> +
> +       /* The transport driver can set the quirk to mark the
> +        * BD_ADDR invalid before creating the HCI device or in
> +        * its setup callback.
> +        */
> +       invalid_bdaddr = test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +
> +       if (!ret) {
> +               if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
> +                       if (!bacmp(&hdev->public_addr, BDADDR_ANY))
> +                               hci_dev_get_bd_addr_from_property(hdev);
> +
> +                       if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
> +                           hdev->set_bdaddr) {
> +                               ret = hdev->set_bdaddr(hdev,
> +                                                      &hdev->public_addr);
> +
> +                               /* If setting of the BD_ADDR from the device
> +                                * property succeeds, then treat the address
> +                                * as valid even if the invalid BD_ADDR
> +                                * quirk indicates otherwise.
> +                                */
> +                               if (!ret)
> +                                       invalid_bdaddr = false;
> +                       }
> +               }
> +       }
> +
> +       /* The transport driver can set these quirks before
> +        * creating the HCI device or in its setup callback.
> +        *
> +        * For the invalid BD_ADDR quirk it is possible that
> +        * it becomes a valid address if the bootloader does
> +        * provide it (see above).
> +        *
> +        * In case any of them is set, the controller has to
> +        * start up as unconfigured.
> +        */
> +       if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
> +           invalid_bdaddr)
> +               hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
> +
> +       /* For an unconfigured controller it is required to
> +        * read at least the version information provided by
> +        * the Read Local Version Information command.
> +        *
> +        * If the set_bdaddr driver callback is provided, then
> +        * also the original Bluetooth public device address
> +        * will be read using the Read BD Address command.
> +        */
> +       if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
> +               return hci_unconf_init_sync(hdev);
> +
> +       return ret;
> +}
> +
> +/* This function handles hdev init stage:
> + *
> + * Calls hci_dev_setup_sync to perform setup stage
> + * Calls hci_init_sync to perform HCI command init sequence
> + */
> +static int hci_dev_init_sync(struct hci_dev *hdev)
> +{
> +       int ret;
> +
> +       bt_dev_dbg(hdev, "");
> +
> +       atomic_set(&hdev->cmd_cnt, 1);
> +       set_bit(HCI_INIT, &hdev->flags);
> +
> +       ret = hci_dev_setup_sync(hdev);
> +
> +       if (hci_dev_test_flag(hdev, HCI_CONFIG)) {
> +               /* If public address change is configured, ensure that
> +                * the address gets programmed. If the driver does not
> +                * support changing the public address, fail the power
> +                * on procedure.
> +                */
> +               if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
> +                   hdev->set_bdaddr)
> +                       ret = hdev->set_bdaddr(hdev, &hdev->public_addr);
> +               else
> +                       ret = -EADDRNOTAVAIL;
> +       }
> +
> +       if (!ret) {
> +               if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
> +                   !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> +                       ret = hci_init_sync(hdev);
> +                       if (!ret && hdev->post_init)
> +                               ret = hdev->post_init(hdev);
> +               }
> +       }
> +
> +       /* If the HCI Reset command is clearing all diagnostic settings,
> +        * then they need to be reprogrammed after the init procedure
> +        * completed.
> +        */
> +       if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
> +           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> +           hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
> +               ret = hdev->set_diag(hdev, true);
> +
> +       if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> +               msft_do_open(hdev);
> +               aosp_do_open(hdev);
> +       }
> +
> +       clear_bit(HCI_INIT, &hdev->flags);
> +
> +       return ret;
> +}
> +
> +int hci_dev_open_sync(struct hci_dev *hdev)
> +{
> +       int ret;
>
>         bt_dev_dbg(hdev, "");
>
> @@ -3904,119 +4043,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
>         set_bit(HCI_RUNNING, &hdev->flags);
>         hci_sock_dev_event(hdev, HCI_DEV_OPEN);
>
> -       atomic_set(&hdev->cmd_cnt, 1);
> -       set_bit(HCI_INIT, &hdev->flags);
> -
> -       if (hci_dev_test_flag(hdev, HCI_SETUP) ||
> -           test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> -               bool invalid_bdaddr;
> -               size_t i;
> -
> -               hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> -
> -               if (hdev->setup)
> -                       ret = hdev->setup(hdev);
> -
> -               for (i = 0; i < ARRAY_SIZE(hci_broken_table); i++) {
> -                       if (test_bit(hci_broken_table[i].quirk, &hdev->quirks))
> -                               bt_dev_warn(hdev, "%s",
> -                                           hci_broken_table[i].desc);
> -               }
> -
> -               /* The transport driver can set the quirk to mark the
> -                * BD_ADDR invalid before creating the HCI device or in
> -                * its setup callback.
> -                */
> -               invalid_bdaddr = test_bit(HCI_QUIRK_INVALID_BDADDR,
> -                                         &hdev->quirks);
> -
> -               if (ret)
> -                       goto setup_failed;
> -
> -               if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
> -                       if (!bacmp(&hdev->public_addr, BDADDR_ANY))
> -                               hci_dev_get_bd_addr_from_property(hdev);
> -
> -                       if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
> -                           hdev->set_bdaddr) {
> -                               ret = hdev->set_bdaddr(hdev,
> -                                                      &hdev->public_addr);
> -
> -                               /* If setting of the BD_ADDR from the device
> -                                * property succeeds, then treat the address
> -                                * as valid even if the invalid BD_ADDR
> -                                * quirk indicates otherwise.
> -                                */
> -                               if (!ret)
> -                                       invalid_bdaddr = false;
> -                       }
> -               }
> -
> -setup_failed:
> -               /* The transport driver can set these quirks before
> -                * creating the HCI device or in its setup callback.
> -                *
> -                * For the invalid BD_ADDR quirk it is possible that
> -                * it becomes a valid address if the bootloader does
> -                * provide it (see above).
> -                *
> -                * In case any of them is set, the controller has to
> -                * start up as unconfigured.
> -                */
> -               if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
> -                   invalid_bdaddr)
> -                       hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
> -
> -               /* For an unconfigured controller it is required to
> -                * read at least the version information provided by
> -                * the Read Local Version Information command.
> -                *
> -                * If the set_bdaddr driver callback is provided, then
> -                * also the original Bluetooth public device address
> -                * will be read using the Read BD Address command.
> -                */
> -               if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
> -                       ret = hci_unconf_init_sync(hdev);
> -       }
> -
> -       if (hci_dev_test_flag(hdev, HCI_CONFIG)) {
> -               /* If public address change is configured, ensure that
> -                * the address gets programmed. If the driver does not
> -                * support changing the public address, fail the power
> -                * on procedure.
> -                */
> -               if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
> -                   hdev->set_bdaddr)
> -                       ret = hdev->set_bdaddr(hdev, &hdev->public_addr);
> -               else
> -                       ret = -EADDRNOTAVAIL;
> -       }
> -
> -       if (!ret) {
> -               if (!hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
> -                   !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> -                       ret = hci_init_sync(hdev);
> -                       if (!ret && hdev->post_init)
> -                               ret = hdev->post_init(hdev);
> -               }
> -       }
> -
> -       /* If the HCI Reset command is clearing all diagnostic settings,
> -        * then they need to be reprogrammed after the init procedure
> -        * completed.
> -        */
> -       if (test_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks) &&
> -           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> -           hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) && hdev->set_diag)
> -               ret = hdev->set_diag(hdev, true);
> -
> -       if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> -               msft_do_open(hdev);
> -               aosp_do_open(hdev);
> -       }
> -
> -       clear_bit(HCI_INIT, &hdev->flags);
> -
> +       ret = hci_dev_init_sync(hdev);
>         if (!ret) {
>                 hci_dev_hold(hdev);
>                 hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
> --
> 2.35.1

Any feedback on these changes?

-- 
Luiz Augusto von Dentz
