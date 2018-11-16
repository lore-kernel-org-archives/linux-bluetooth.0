Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6408C43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 16:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A167420825
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 16:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+ZQJBjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A167420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeKQCaF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:30:05 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:38767 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKQCaF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Nov 2018 21:30:05 -0500
Received: by mail-qk1-f181.google.com with SMTP id d19so38214656qkg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 08:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wBuWWW230rzGpsdIHdGS/ov4oJpBNMLe/GjthBvZcnw=;
        b=L+ZQJBjmL9cIN/atIpKwX6ddLNmquI7j9uy9DqwM6q/IAeAviMXdOdeLW2JWqV2PK0
         m7oRZRt1Rw60FC9QkOMZknNjw7n+NbVdVIq34FZewHPVrpmEQdkbKY3vTzI5s8QN6xrA
         F4328QH28OMHGgdA1jV+XcbH+L52bU7mGjiNVeO0zxeOA0Hb4+5xz6656xwBBdAgywSs
         zzjnKyY1mP/daoZ2UnD8B2UCxz1gKyzJwKdabVM4kCQ2SJLyURV/clyHanYA7COnkosC
         AkzJwhUnkfAdGw/s3y7h06C5aEAuIdUOjXnO3r8tZV+mQ+rlYJoYu9CzxLdSfF4wNvrb
         XEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wBuWWW230rzGpsdIHdGS/ov4oJpBNMLe/GjthBvZcnw=;
        b=Rq4sPXf+NBy3rWlh03hK6NWla/DYmHwGvZZRaNtiZlt3ksHWUYKUUIowDzY4l0Alvi
         Jq8yuIrsk9ms6jBs7nHmKnCiYXy11Re1uqDrdQgQMe9VOjRR7ZPNabhEPUmTUzYL8Y9e
         akyOkG/GMh2zIRLWducYcIfUAYLTXGtNzPIYdvoFwPVwxeEP/hnT8egEjKFpk/ECo1Pp
         XMsTtjS3pvvJxNZBq0+LzKK8g3S3XnwQyUPpENbmCxi1L4Z/eGtPpOhbO5I8wYVr55Jp
         /uBXyW/ifMVxFPXYbwArTgyPNJZ2PZ/lL15+fdY0H3ktkTaPaTrA7yKWw3uW3V7fP5GI
         NbIA==
X-Gm-Message-State: AGRZ1gKw30mlEmiuvgh77mRqpfGS/6X6UsHbauLjYgxzd9EjyQAHDnSD
        4ralfYrmey3WFOApttjlqoCpa8ktFL/V+9Gw8zmcXnUQZpM=
X-Google-Smtp-Source: AJdET5dXsprE8Zh9iDCFce1XnPtMpwz+fW7qjUpvKJc5uiU8EkbpfRHUv+FoxGgg8y4xk38GSVH1LTrrDXDzIcNzZmg=
X-Received: by 2002:ac8:1243:: with SMTP id g3mr10810508qtj.139.1542385024468;
 Fri, 16 Nov 2018 08:17:04 -0800 (PST)
MIME-Version: 1.0
From:   sanjeev sharma <sanjeevsharmaengg@gmail.com>
Date:   Fri, 16 Nov 2018 21:46:52 +0530
Message-ID: <CAGUYZuQ8ue76z0Xj1E91=S+FyXrVYy32xW-zLEsLzxxZzU4m8w@mail.gmail.com>
Subject: BlueZ for Android
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Do we support BlueZ for Android and if yes, may I know the latest
commits and on which architecture we are supporting it.
