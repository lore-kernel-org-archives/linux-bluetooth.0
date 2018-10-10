Return-Path: <SRS0=lCj9=MW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287EAC43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Oct 2018 10:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD91214DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Oct 2018 10:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7T+Hr7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD91214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJJR6N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:58:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33888 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeJJR6M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Oct 2018 13:58:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id v69-v6so3685388oif.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Oct 2018 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldB468kEB8x127psC9haVWAkSt9bQwoeRN1kSoCS3Y0=;
        b=N7T+Hr7gPCJnUZ6/a7KLP0c+uPhqUGdA0cd8L4exf0VuqiLXwoolv/Y7IfZ4j1okAT
         t0YKjh/u5rj+d2icXfaaEPhvnr5OMXPMbWxlbRpHz4d3x2yHDfwwNeagaOh0m4a2CCTh
         YTFE40/lixjWmQ+7jqNnZ/HBsHp4rFgdYv6ByIoYQe2V7Qrzma8nXO+OdwxiS4Hb5PZj
         vEwl2rBO0P+LzZBrjbvRZcy+cF5a2Jjxsr79Ot3qdobLV8L/V2llUBLYOcWvkMhEEVDl
         FfVZaVrpZkCRlmqnFmOp1UIkkbLecZksiwH2iWFdK0xQtoGYErBsf20cNXgm30HYP+nJ
         nRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldB468kEB8x127psC9haVWAkSt9bQwoeRN1kSoCS3Y0=;
        b=O1iePY2fxSzYgMrXDT0W77CPUTSWPtBYVP58L/YjToTWGeQhQyNVbHVFh5XZNKwkMR
         j5eNxU8+kFImrEQ2DDDC8rYSc+lwRe3ph8FyWELx5irMQHthMIIOLf9fPTWm+ardmMig
         AY7ic5DrWWoKyTP2+Fp3AX3Yfuzb3gYYm5eyfcYlSoIqZoVFPOuUU1ltltVagWRxMqR5
         he7g/rrk8H+BhJgcCti8bSok3TZcvZIVdKNo4hOfUoZ7fGkuFCbmJ2ox1Pu6owfl/liY
         AGM1oWMEUwnUoUtX/lKJII1VFe6F2BjTGX1cITX6bifzMTdJwvhvG7/IUlWkGGcwNPk/
         fFrA==
X-Gm-Message-State: ABuFfohQDyEmLILofeUiYlsV5tiZYKKtTustPmTDiXnGy64IAxyPyD1/
        fi92JdUAO32MV0lbtCJq4WEAW3eGBxZoCMqFW3qqUmIl
X-Google-Smtp-Source: ACcGV60bcnkw4Em9CLydB3j3xy2pUsu8DkleGDQUnELDsV1EaQKGSBAlcce4lJcs9i4nvoKsL/cwYbHkq2FsKCz7vxA=
X-Received: by 2002:a54:4e0f:: with SMTP id a15-v6mr1279896oiy.346.1539167799863;
 Wed, 10 Oct 2018 03:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAO9gXyQNtt7x15sEsNo-2qb2xLOC_8OB_wkti1_d8tvq8fysNQ@mail.gmail.com>
In-Reply-To: <CAO9gXyQNtt7x15sEsNo-2qb2xLOC_8OB_wkti1_d8tvq8fysNQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Oct 2018 13:36:27 +0300
Message-ID: <CABBYNZ+k2KqhynyXCqWoNMwJXR=r+9UFPpy8A-0UXtUdOde0=A@mail.gmail.com>
Subject: Re: How to enable "util_debug" function in att.c
To:     Calvin Yoo <choongbeom@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Calvin,


On Wed, Oct 10, 2018 at 12:58 PM Calvin Yoo <choongbeom@gmail.com> wrote:
>
> Hello,
> How to see output log from "util_debug" function in att.c
> I searched it for few days but I don't have any clue yet.
> How can I see the logs in console?
> (Env. - linux and bluez5.41.)
>
> I found enabling daemon log by adding "-d" flag in bluetooth.service
> file but it's not what I want.

Usually the code linking with bt_att needs to call bt_att_set_debug:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/shared/att.h#n51

This is done for example by test-gatt:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/unit/test-gatt.c#n661

-- 
Luiz Augusto von Dentz
