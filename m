Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3645E7C4E6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 17:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbjJDR3p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 13:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243743AbjJDR3k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 13:29:40 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47365111
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 10:29:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a2a3fb0713so4384439f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Oct 2023 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696440561; x=1697045361; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1L4FWPvwgVew6lPUUfYyQMP2rYbXtE+CCXKbC/VV/w0=;
        b=ChjE6ZWRs9hKCqJms9/FoVNM1lTXnDv4z4qoTTAMW447qKxKIcwZjdGzT2nYVyFBkg
         OJqctGCIZ0R9xJ6efWaAGUfkfq+k59AtGqNwOlU7xXI5mOYLfqdrSf6iEcOwyIWMEnQF
         DXIbEF+aAcVF89HFQFrALFwO7JJ98GE7qWOT9krzuDn80xT4KqAWDE3202I1LwczpY5F
         DGaQV4/9eALKPGVXq3t3GoOrxgwjMMcGamh7iJj+5VzY2V2zrEelN5kAI3G+Zy4OO2+D
         Gc2Qap7E7K/hMOtk/E5lJ+TqxPh52Hi8im9SbBw4RL27hOgMYyZkZ9o9fxtYL0/7BpAX
         7whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440561; x=1697045361;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1L4FWPvwgVew6lPUUfYyQMP2rYbXtE+CCXKbC/VV/w0=;
        b=Fc0wq/dzcc2M+DK91rQrvmtQwa5SDjDV6pA9nQ2zGdrfBArQd7tG8x5E665NeG3AvD
         X8NZR1M648GwvMQHDU4RdUup/WsJrKDJzfrTo7KyNk7SN2JMeOFxrUZrvdHWL1qanNen
         IvrwSDDaAmULa2Ioh+L/ing6QydSkeZv+JdvbXC5EO5pURNySoe00cERobQQ6GzfNR7O
         b7x+DnRLh4A+iWsWlwRIVqpCHRUktYlNi2KSVkoK1OKuP9k5SERzMMchFW1hCQfNQLUT
         Wf2UxUgsDNlbV2waZu4jO1bDg82AOncv7jVxSCleE4dFCcJ+Fl2xsBTLvK+Fts9qhvP3
         aVew==
X-Gm-Message-State: AOJu0Yw0AXAANiRVz7sdIhVT8EyrQrBrS/wTGpsShipjkmVNqA4e9H2g
        GG/XUWx0vrBmejisLjXCWf/gL5iQ+UU=
X-Google-Smtp-Source: AGHT+IEG9D/Qck99tXuGMqGc4dBIiJikHVTibl/VnBVmDKQOPuhH9oltI6hSmpFW3TxWsEIpyCGqrA==
X-Received: by 2002:a05:6e02:20c4:b0:34f:234d:4b5a with SMTP id 4-20020a056e0220c400b0034f234d4b5amr3421631ilq.29.1696440561473;
        Wed, 04 Oct 2023 10:29:21 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.93.41])
        by smtp.gmail.com with ESMTPSA id z15-20020a92cd0f000000b00351375f30b4sm51325iln.51.2023.10.04.10.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:29:21 -0700 (PDT)
Message-ID: <651da0f1.920a0220.fdf08.028d@mx.google.com>
Date:   Wed, 04 Oct 2023 10:29:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3448314402994748997=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add BASS unit tests for the SPE suite
In-Reply-To: <20231004153150.3051-2-iulia.tanasescu@nxp.com>
References: <20231004153150.3051-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3448314402994748997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789981

---Test result---

Test Summary:
CheckPatch                    PASS      7.75 seconds
GitLint                       PASS      2.94 seconds
BuildEll                      PASS      29.11 seconds
BluezMake                     PASS      988.24 seconds
MakeCheck                     PASS      12.12 seconds
MakeDistcheck                 PASS      165.30 seconds
CheckValgrind                 PASS      264.72 seconds
CheckSmatch                   PASS      354.81 seconds
bluezmakeextell               PASS      110.69 seconds
IncrementalBuild              PASS      3537.44 seconds
ScanBuild                     PASS      1170.86 seconds



---
Regards,
Linux Bluetooth


--===============3448314402994748997==--
