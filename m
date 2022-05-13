Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 21:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384420AbiEMVNO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 17:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiEMVNN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 17:13:13 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9748369E6
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 14:13:12 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ef5380669cso102610557b3.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=eonf2ZVHysiL4hTDeDclGsY2nu2rdUrA68BKo3IhBpQ=;
        b=ggw53YiXQq6rE1V1jw19A9OJqcr6IY84SYEDm/7wzmlKO0ZsemYmDhwq+5pIiZoQ0P
         WdraDfL0HijkJ7z7I2ABZYQ+4lL9Q/XF8Mn44vleW53QJCtfd/2PGCSpa8MhQIiIgSvb
         7WbNLzIEd+Ofb8y2MmrqMkpE0RyURd7RPfe9aUh3hUg0bpD5m9gGKrHjYeIZAv27RT2U
         RbxGb/yGOX09EDnB3aJSLJ/5RKS//0C51S9VOd4GiMdVRFV4vqluSTeO3fvvsk/6u3X1
         1ODYO3/i+24Aq6qju7TXKNCjDaaBMWbu+TlHhPtaw/b8ICbcxzQ6Cf/e7DVeZU5q4rWW
         R2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eonf2ZVHysiL4hTDeDclGsY2nu2rdUrA68BKo3IhBpQ=;
        b=vEbA2OO31AieqQHLj112pAjmQ6qCaGyW2ZoH40EjIj44XNcChMkDIiO32xD8oClsfF
         cJjWZU0Adn4cbWNApAoxMRquEyEChrFPdebcF809KXuOKT4N8M1JcaXPeQwv2jP19Q+l
         Q3YDogWN6AxCJnsJrqwULAeLx24MUQ/vHe5RITamB4X1vHj38bZDCV/9Fa3ZbgcXRLa/
         T0XB2BEjzSOAVVY0WdWqYcUNkMZn334tuUQoOvD9WMQl4VsJ5ZBbDupLeAPdr/EoBptp
         vBLAo/9AV0YGzWxHe0mnCc7n5yp+0kjvxi3YqSCk8xTafaOjpFCSUXA+S5oHX6HKIL5w
         WkaA==
X-Gm-Message-State: AOAM533fs+I5ZITeG/9t7Sge7IQblUVba/Uh/58TT8Y/tca9lvGar6GI
        u4apBvVT/f611mCbk3KsbNV5pl+LurxHoeKlyZXomXbjQRE=
X-Google-Smtp-Source: ABdhPJx9nT90XBvKbkVCA6dhSmxdzt3gD4rkp5E+D0HS7+6esp1Y1X71kvNmrh52oi3vFLe0PwMdOvLksBSm7slBsBI=
X-Received: by 2002:a81:1585:0:b0:2f4:e1bb:d752 with SMTP id
 127-20020a811585000000b002f4e1bbd752mr7997210ywv.338.1652476391873; Fri, 13
 May 2022 14:13:11 -0700 (PDT)
MIME-Version: 1.0
From:   Mike <puffy.taco@gmail.com>
Date:   Fri, 13 May 2022 16:13:01 -0500
Message-ID: <CAB7rCTi-znCvwk5wPT652yyh8vgKyCORYFF8runEQ5nOM4y9rw@mail.gmail.com>
Subject: LE OOB pairing
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I'm working on getting a prototype together that is intended to use
NFC to pair a Linux tablet with a device that contains a Nordic BLE
chip.  The tablet contains an NFC module with a non-standard host
interface, so at present I'm not able to use neard, but we have some
code running to the extent that we can read the NDEF record from the
Nordic chip.  I've run that through an NDEF parser to get at the EIR
data, which is what bluetoothd would be looking for.

I've looked through the bluez codebase and it appears everything is
set up for BR/EDR pairing for mime-type
application/vnd.bluetooth.ep.oob.  The Nordic NDEF provides the
mimetype application/vnd.bluetooth.le.oob, which is as expected for an
LE device.  Nothing too far looks terrible in terms of modifications
to BlueZ to process this information, but I do note that at present
eir.c doesn't look for LE Secure Connections Confirmation Value, LE
Secure Connections Random Value, or LE Bluetooth Device Address, all
of which are found in the EIR I parsed.

Eventually we get to the point of creating the device and a bonding,
which both are expecting type BDADDR_BREDR.  Before I go too far down
this rabbit hole, what I'm wondering is if anyone has thought through
this implementation and whether this is as simple as I hope, or if
there will be difficult issues ahead?

Thanks!
