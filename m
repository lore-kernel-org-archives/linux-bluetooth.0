Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43968C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 19:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE8120767
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 19:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koV2GwSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgFVT3H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgFVT3G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 15:29:06 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69E5C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 12:29:06 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 25so16660507oiy.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uG7ktmVmHhtH+zZNCHerRHEynF4USMtwuSPvt3ZKgAU=;
        b=koV2GwSqFxX8odhqiduXuq+eMkJQXPNf7fVi5bx9ClkKXvzVwG8fP4A0r+L5um7idO
         KEuff78NN5BQqdAax7Zs4+4OPvUjpQk7stoOOldcMM8jDQ3jGdzfD9d6xJqtu/EQC+tk
         mOt9iZO9H920rKpGMMgSA0NLiX7vRzuEAx6EdyU65qyIBzdDH41FOiK31EAhXMPQXxcT
         +veISPy5Y1E3NYofMg0xPHTlOsT1nvhtAvuWnOcNPMar4WBIKEgJaYQPDraOWCBL4sgR
         szzBE8jY0rnkl00I7QFOxmgnOAl3EP7z4o9inxuwopC+V3fUs+676QXgl9Zw3jQNPgDG
         voWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uG7ktmVmHhtH+zZNCHerRHEynF4USMtwuSPvt3ZKgAU=;
        b=TlcTJ/xk4V8I5VioCBbmPpMh5G6yQC2gxBXkG2v0aV7EdVngVg53blnnRCnuwrYs/i
         jPuFgPb9maEMhGrIFZv7dPUP3UVJv7nRpDkQePAGPXHjZWQ2oFShlsebQhRxiZHM99xv
         3Io4jVep/PRZJA4Flzf71pyeJrhmYE+fSWlnzIJ58dhNnxPSusysE+VBKOEY/9JNu/wO
         5AFy2H7LuuRhvuTBQu4yEz1YJQeqEIxVoKDZuvF2mtEUSP8qqYtBfXf27AqfHLR22o1C
         22S4nVTE3RhmdZyc3nAjzo4C0e7XPOHl5NYLL7ZfQNDDzxQBPc5ktyaUamGiRFQ33EZp
         W8yw==
X-Gm-Message-State: AOAM533HzlIjFG9K4xmpwItZAz5RoWLWtHpmavZPL5UY+SdUwd/fkpT+
        AHGfg0blDDuOQG1CqhnT/k0KXX0xPeMk1k+2L2Q=
X-Google-Smtp-Source: ABdhPJySCICJWvrw3OFT3V6wqz+ahRKJGzpc7xaN7AX85WojxPNQNiTf0lMOpZBHS/a7raJf+aIp0Y1PUW90RHkAQQ4=
X-Received: by 2002:aca:4f4f:: with SMTP id d76mr13059448oib.152.1592854146102;
 Mon, 22 Jun 2020 12:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200619183456.38696-1-tedd.an@linux.intel.com>
In-Reply-To: <20200619183456.38696-1-tedd.an@linux.intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Jun 2020 12:28:54 -0700
Message-ID: <CABBYNZLm9dWkcJ8Kbf=jeyN2VTzuRh2RFvY7iAqeqQ8LwSJ1cA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] midi: Fix SysEx parser in MIDI plugin
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Jun 19, 2020 at 9:27 PM <tedd.an@linux.intel.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> The SysEx end of message parser didn't consider the fact that
> timestampsLow are in the stream and it might have the EOX (F7)
> byte as well.
>
> Fix that by always assuming the first system message byte is
> the timestampLow.
>
> Future work would involve support other type of system message
> bytes, such as real-time.
> ---
>  profiles/midi/libmidi.c | 38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
> index 4b4df799f..7d57e7335 100644
> --- a/profiles/midi/libmidi.c
> +++ b/profiles/midi/libmidi.c
> @@ -331,6 +331,30 @@ static size_t handle_end_of_sysex(struct midi_read_parser *parser,
>         return sysex_length + 1; /* +1 because of timestampLow */
>  }
>
> +/* Searches the end of a SysEx message that contains a timestampLow
> + * before the SysEx end byte. Returns the number of bytes of valid
> + * SysEx payload in the buffer.
> + */
> +static size_t sysex_eox_len(const uint8_t *data, size_t size)
> +{
> +       size_t i = 0;
> +
> +       MIDI_ASSERT(size > 0);
> +
> +       if (data[i] == 0xF0)
> +               i++;
> +
> +       /* Search for timestamp low */
> +       while (i < size) {
> +               if ((data[i] & 0x80)) {
> +                       i++;
> +                       break;
> +               }
> +               i++;
> +       }
> +
> +       return (i < size && data[i] == 0xF7) ? i : 0;
> +}
>
>
>  size_t midi_read_raw(struct midi_read_parser *parser, const uint8_t *data,
> @@ -368,14 +392,14 @@ size_t midi_read_raw(struct midi_read_parser *parser, const uint8_t *data,
>
>                 /* System Common Messages */
>         case 0xF0: /* SysEx Start */ {
> -               uint8_t *pos;
> +               size_t sysex_length;
>
>                 /* cleanup Running Status Message */
>                 parser->rstatus = 0;
>
> -               /* Avoid parsing if SysEx is contained in one BLE packet */
> -               if ((pos = memchr(data + i, 0xF7, size - i))) {
> -                       const size_t sysex_length = pos - (data + i);
> +               sysex_length = sysex_eox_len(data + i, size - i);
> +               /* Search for End of SysEx message in one BLE message */
> +               if (sysex_length > 0) {
>                         midi_size = handle_end_of_sysex(parser, ev, data + i,
>                                                         sysex_length);
>                 } else {
> @@ -424,10 +448,10 @@ size_t midi_read_raw(struct midi_read_parser *parser, const uint8_t *data,
>
>                 /* Check for SysEx messages */
>                 if (parser->sysex_stream.len > 0) {
> -                       uint8_t *pos;
> +                       size_t sysex_length;
>
> -                       if ((pos = memchr(data + i, 0xF7, size - i))) {
> -                               const size_t sysex_length = pos - (data + i);
> +                       sysex_length = sysex_eox_len(data + i, size - i);
> +                       if (sysex_length > 0) {
>                                 midi_size = handle_end_of_sysex(parser, ev, data + i,
>                                                                 sysex_length);
>                         } else {
> --
> 2.25.4
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
