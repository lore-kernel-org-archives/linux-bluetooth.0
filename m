Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC00C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 21:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C765F64F7C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 21:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhBDVDf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBDVDc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Feb 2021 16:03:32 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BB3C061786;
        Thu,  4 Feb 2021 13:02:52 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a9so7988887ejr.2;
        Thu, 04 Feb 2021 13:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QM4H+AOas/ZTy6sjkxPDpMs06k7xsx9Ag86HzbisD/s=;
        b=t7bAOfG9L1hfW8+U/sXI6TTV51MXxM7GIKim3muln2dxUXGfSCjq0wc/cOXeX5FNoV
         Um2nreccGtzYdruUKiokkxMK4BaftyfKb4uPPcqRe4qAoh/Oi1qiyaUv2WaZ6UrEc4H4
         w/Y+BBfcEXOz8UH+iwU6Izl7YpDelBBNEMk25KqeQF93tKER8vSPfPsUiFQwuo2sRqpz
         D4TXAIdJqJEu9Dfx4KnDwanp7QDjORcT1HkQ/Bfdt6GMU6e+RUZH4+YkwfyLKY7YhM7t
         pU5RfjM1/cjtqEch+dzqgKzVxdKim8BT2QWO3D/d1qhz7WMeytS4gRgJxW386U+qe3Re
         CKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QM4H+AOas/ZTy6sjkxPDpMs06k7xsx9Ag86HzbisD/s=;
        b=dYel6g3PwuAPVCmmAMRXZqQ0l4YRwgVLLsac8DS+tOVBv2A6rwZGPgxxsvu/A+7XsM
         IEaCQJyWSZSR4y3N33tlZPhMFiEyblDtV8N+9bqSBroUN60h7BQ2ofqEkjUTJ59dG2/n
         KHWXA/BuwQ86kpKs6nJj5UlmhyNe2snBA2FLekTc8vqE9jF67df0nHNBRMF6GE0618N4
         TOE4EO8cNCXTR8auWZ9fNJjAVc1MkRyJVlmctjvE63sdCAe4/nJUebfvvxBlZbprKPze
         Vl1ZZyNy5pQyyjZTNusUz5t/RmHSaOkR3XXqT4o/tcG3rzHIml/x84HSOItsdjgi5i/Q
         esSA==
X-Gm-Message-State: AOAM53106uGlr0UjvGS81QMe06sjq5K0wYgSchWfYha/L5tY0Ggcvru/
        TJJ4XOw/m0FTLhtzElrHf80u9eXMtWO13WnwfC4=
X-Google-Smtp-Source: ABdhPJz48/Zvb8jOqshxuPl7OAhtiddClB2itrWe0Ka+BpWHWkCP6Zwb95XKwOR73Ng3MHnXus3YQXdrm8x52RuT3wk=
X-Received: by 2002:a17:906:958f:: with SMTP id r15mr915426ejx.360.1612472571112;
 Thu, 04 Feb 2021 13:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20210204154716.1823454-1-arnd@kernel.org>
In-Reply-To: <20210204154716.1823454-1-arnd@kernel.org>
From:   Trent Piepho <tpiepho@gmail.com>
Date:   Thu, 4 Feb 2021 13:02:39 -0800
Message-ID: <CA+7tXii4h+GPp-+qG3m+zhDORLtU_ZS=eer_wCkxrWs6sZqT5A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: fix excessive stack usage
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mark Chen <Mark-YW.Chen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Kiran K <kiran.k@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sathish Narasimman <nsathish41@gmail.com>,
        Rocky Liao <rjliao@codeaurora.org>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Hilda Wu <hildawu@realtek.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Feb 4, 2021 at 7:47 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Enlarging the size of 'struct btmtk_hci_wmt_cmd' makes it no longer
>
> Unfortunately, I could not figure out why the message size is
> increased in the previous patch. Using dynamic allocation means

That patch appears to be have been split out of fc342c4dc40
"Bluetooth: btusb: Add protocol support for MediaTek MT7921U USB
devices".  But there is no clear reason why those changes were split
out, which is not helped by vague patch description, and size increase
appears to be a totally random change to unrelated code.  This struct
is used by that latter commit to download firmware with a new format
for mt7921.

But new firmware download function uses code that is just copied from
existing fw download function (should be refactored to share code),
which has a max packet data size of "dlen = min_t(int, 250,
dl_size);", so there was no need to increase size at all.  I'd guess
someone experimented with larger chunks for firmware download, but
then did not use them, but left the larger max size in because it was
a separate commit.

It looks like the new firmware download function will crash if the
firmware file is not consistent:

sectionmap = (struct btmtk_section_map *)(fw_ptr +
MTK_FW_ROM_PATCH_HEADER_SIZE +
              MTK_FW_ROM_PATCH_GD_SIZE + MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
section_offset = sectionmap->secoffset;
dl_size = sectionmap->bin_info_spec.dlsize;
...
fw_ptr += section_offset;
/* send fw_ptr[0] to fw_ptr[dl_size] via wmt_cmd(s) */

Both section_offset and dl_size are used unsanitized from the firmware
blob and could point outside the blob.

And the manually calculated struct sizes aren't necessary, if the
structs for the firmware were correct, it could just be:

struct btmtk_firmware {
       struct btmtk_patch_header header;
       struct btmtk_global_desc desc;
       struct btmtk_section_map sections[];
} __packed;

struct btmtk_firmware* fw_ptr = fw->data;

sectionmap = &fw_ptr->sections[i];
