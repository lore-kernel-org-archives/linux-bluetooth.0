Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BD6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 20:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiEXU40 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 16:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241806AbiEXU4M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 16:56:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AB2FF9
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 13:56:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 31so17258630pgp.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdi/vKcE87Pn1T9vSZGob5WI/QmgE/x6j/MAZIw2t7o=;
        b=ar1kmL+gOfe5Blkdb6Uv875I5W6+4PS1jLIg80Di7jCmlScBQab5QFN/UurpMGW3Ez
         UxFtkSFySutx1MkIcFITpHjTtjNWPeNbvWsYhR1SlgGamPayI630Hb0PrqjtDvYWOg8O
         gulrmSzUaobOTtUvI1TYUtIR9dr67CvJnjgZf1XGVc4yRbr4tmpBqurbnL6d6eypcNju
         cnHGK247BgQLIH5x/yAdLQknucGwAKLFKRXmmMLFEAtSUp849b3X7SwZ80hgDHh237u/
         TqEZviGSKAgagz2wwdl17F58h2GutSni2tTSTZP3dHho+EnBkOzzgSuseBxC8K/w7IAr
         /L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdi/vKcE87Pn1T9vSZGob5WI/QmgE/x6j/MAZIw2t7o=;
        b=W4C9uyzSZjp6tOF7HI6idmEqSDdVZthfSSM1BIS2YjkcwzRTLWBmO5WUqTGNAxmpfW
         +Ot1sr35LM9SD+5SKcRbEUa/UqXFI5DBz57MjethDMzNJhTrkAy0OWv+2A5E1cE1px7g
         6bXwdkSnvveJ+ZO+TJ89WfgLQoezT5E8zlhOZ7pZcCtbNqHnUp+je2Rga4UD3lpmsm8e
         X/72oI2eMFOMlzIQ0h89AIFLCFJBS+RtQtOr1ckngw0cMDkl58QUdygepzErSP15B0GK
         Zjasq/GckGkdsn7myehe2ZL+RmGao/M8KMw/2RctmXLHPf8jnjn2y1zTpGPPxwE7IQ40
         rqJA==
X-Gm-Message-State: AOAM531NdahAr+BzqIpGD76ugWaAxpHjcvES8P53Mw/UiY4OxV/FOaOU
        RCnqIPc958104XAFIRxq66SJr1LmCCszo2tIO5+K02pP6gU=
X-Google-Smtp-Source: ABdhPJzv7TboglGqxwJWrQNhN8Ug/kCmCXWgVV1lZuzI0xPQeDZLInPsVLEYZnjEizBRjynIZ0YeTcFnW75yBW9CD58=
X-Received: by 2002:a65:6d08:0:b0:3c6:8a08:3b9f with SMTP id
 bf8-20020a656d08000000b003c68a083b9fmr25697350pgb.147.1653425769092; Tue, 24
 May 2022 13:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220524202630.3569412-1-luiz.dentz@gmail.com>
In-Reply-To: <20220524202630.3569412-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 May 2022 13:55:57 -0700
Message-ID: <CABBYNZKZajJyuenwyv+1T6Gt1SYyLz39yMJF9_LYdTubk+e_rw@mail.gmail.com>
Subject: Re: [PATCH-stable] Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stephen,

On Tue, May 24, 2022 at 1:26 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Both dev_name and short_name are not guaranteed to be NULL terminated so
> this instead use strnlen and then attempt to determine if the resulting
> string needs to be truncated or not.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216018
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/eir.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
> index 7e930f77ecab..4171edee88e4 100644
> --- a/net/bluetooth/eir.c
> +++ b/net/bluetooth/eir.c
> @@ -13,6 +13,20 @@
>
>  #define PNP_INFO_SVCLASS_ID            0x1200
>
> +static u8 eir_append_name(u8 *eir, u16 eir_len, u8 type, u8 *data, u8 data_len)
> +{
> +       u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
> +
> +       /* If data is already NULL terminated just pass it directly */
> +       if (data[data_len - 1] == '\0')
> +               return eir_append_data(eir, eir_len, type, data, data_len);
> +
> +       memcpy(name, data, HCI_MAX_SHORT_NAME_LENGTH);
> +       name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
> +
> +       return eir_append_data(eir, eir_len, type, name, sizeof(name));
> +}
> +
>  u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
>  {
>         size_t short_len;
> @@ -23,29 +37,26 @@ u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
>                 return ad_len;
>
>         /* use complete name if present and fits */
> -       complete_len = strlen(hdev->dev_name);
> +       complete_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
>         if (complete_len && complete_len <= HCI_MAX_SHORT_NAME_LENGTH)
> -               return eir_append_data(ptr, ad_len, EIR_NAME_COMPLETE,
> +               return eir_append_name(ptr, ad_len, EIR_NAME_COMPLETE,
>                                        hdev->dev_name, complete_len + 1);
>
>         /* use short name if present */
> -       short_len = strlen(hdev->short_name);
> +       short_len = strnlen(hdev->short_name, sizeof(hdev->short_name));
>         if (short_len)
> -               return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
> -                                      hdev->short_name, short_len + 1);
> +               return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
> +                                      hdev->short_name,
> +                                      short_len == HCI_MAX_SHORT_NAME_LENGTH ?
> +                                      short_len : short_len + 1);
>
>         /* use shortened full name if present, we already know that name
>          * is longer then HCI_MAX_SHORT_NAME_LENGTH
>          */
> -       if (complete_len) {
> -               u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
> -
> -               memcpy(name, hdev->dev_name, HCI_MAX_SHORT_NAME_LENGTH);
> -               name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
> -
> -               return eir_append_data(ptr, ad_len, EIR_NAME_SHORT, name,
> -                                      sizeof(name));
> -       }
> +       if (complete_len)
> +               return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
> +                                      hdev->dev_name,
> +                                      HCI_MAX_SHORT_NAME_LENGTH);
>
>         return ad_len;
>  }
> @@ -168,7 +179,7 @@ void eir_create(struct hci_dev *hdev, u8 *data)
>         u8 *ptr = data;
>         size_t name_len;
>
> -       name_len = strlen(hdev->dev_name);
> +       name_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
>
>         if (name_len > 0) {
>                 /* EIR Data type */
> --
> 2.35.1

Here is a tentative fix, I do wonder though why you were trying to set
the name directly and not using the likes of bluetoothctl/btmgmt?
bluetoothd don't seem to bother setting a shortname so it is probably
not reproducible with it but btmgmt does:

[mgmt]# name "This is a long name" "Short Name"
[mgmt]# @ MGMT Command: Set Local... (0x000f) plen 260  {0x0001}
[hci0] 13:37:27.052763
        Name: This is a long name
        Short name: Short Name
@ MGMT Event: Command Comp.. (0x0001) plen 263  {0x0001} [hci0] 13:37:27.053224
      Set Local Name (0x000f) plen 260
        Status: Success (0x00)
        Name: This is a long name
        Short name: Short Name

Anyway it looks like one needs to be advertising in order to trigger
the problem but with the above changes it doesn't crash anymore:

@ MGMT Command: Add Extende.. (0x0055) plen 14  {0x0001} [hci0] 13:53:28.130215
        Instance: 1
        Advertising data length: 3
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Scan response length: 0
< HCI Command: LE Set Exten.. (0x08|0x0037) plen 7  #119 [hci0] 13:53:28.130215
        Handle: 0x01
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x03
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
> HCI Event: Command Complete (0x0e) plen 4         #120 [hci0] 13:53:28.130215
      LE Set Extended Advertising Data (0x08|0x0037) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Exte.. (0x08|0x0038) plen 17  #121 [hci0] 13:53:28.130215
        Handle: 0x01
        Operation: Complete scan response data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x0d
        Name (short): Short Name
> HCI Event: Command Complete (0x0e) plen 4         #122 [hci0] 13:53:28.130215
      LE Set Extended Scan Response Data (0x08|0x0038) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Exten.. (0x08|0x0039) plen 6  #123 [hci0] 13:53:28.130215
        Extended advertising: Enabled (0x01)
        Number of sets: 1 (0x01)
        Entry 0
          Handle: 0x01
          Duration: 0 ms (0x00)
          Max ext adv events: 0
> HCI Event: Command Complete (0x0e) plen 4         #124 [hci0] 13:53:28.134215
      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4  {0x0001} [hci0] 13:53:28.134215
      Add Extended Advertising Data (0x0055) plen 1
        Status: Success (0x00)
        Instance: 1

-- 
Luiz Augusto von Dentz
