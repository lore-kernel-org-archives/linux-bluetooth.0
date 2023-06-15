Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A30EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jun 2023 14:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245732AbjFOOgV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbjFOOgU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jun 2023 10:36:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D5199
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 07:36:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f736e0c9b1so19353715e9.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686839778; x=1689431778;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uzm3VZYDXcStcytclpPFwuHiXTEqB8XHGvxC1QF1m8c=;
        b=X127q9e0Fgt8n8vIvKG4OAJiNW16xn6FrrF/VADzq21fvh7Ub0BXZv1MapIPDhHy3b
         LifMG9HXuOJpkCu+nHORz6rXGvcSWlba1JqMeL5NSkjuQBuvZoC4JwXf6HkDLeRxZuS7
         iGAwJO+buvaJV7A7MQ9dbBDmHu6RWbmnxfoijtCYls0GNXTScFlplIhlCSjPNG/HyQQz
         l/LojzAeefJZqWcIh8dEMRYVqpiFojWaqckdDxXZDwIyQM9KKOjeyz7z1AfP4moS2oxn
         0nVqJa/bJtawbzgO219SGUfmX5mgApaVUGM35bvvuyKkqtcKKOVKukuw59YNpFTcn/Ce
         GGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686839778; x=1689431778;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uzm3VZYDXcStcytclpPFwuHiXTEqB8XHGvxC1QF1m8c=;
        b=a8iqKfkoXQlfzSSV7nOD1bayrbmk6DA3Z+gyoD0XixGU7v1p6FWVhBPwGrEDapwqcH
         kYSTO6AKekkrTFVj4VkEFXJJIbrwm6MokHt56ogDgPFW8MKJ2uQTVhkO7Vyi3Em294it
         kKOXvxDjr4ZnW5jdG12Z7zTB61Gg8VBBt6RtLL7SY+k8eKE70NSv2xzlScQIRPaBizRs
         /H6AaHl4LniIMRf6pW+/wE5m9wcPA/3gAga/lbCpzzt3AZjAA6ZJfOpl4q5Xe2gHCXl8
         W29b/w9HAdbkv7Lw64AABdqVzISt91Y0dkgBAzTtYEMoE4BXSKL2JaPc/HfwMqtQ1hcg
         jraQ==
X-Gm-Message-State: AC+VfDzDjD51zp0F6j84xinaOw9+Mv5H6cssKFVdcSrLyoR17KTGPWWY
        tglxHUB/3j0230vWAkwJsy1YEGwIyIABarCv9bpz1Ax/btbxGsz+/sI=
X-Google-Smtp-Source: ACHHUZ7AluSf5IsEkK90B/xWUSGHOqVjn2lJsAOz1nEvBR3rMloKQjdWVkHyeLVx/2N7bg+0wT6csjienzGQJNbYxvs=
X-Received: by 2002:a5d:4d83:0:b0:30f:d1e3:22a4 with SMTP id
 b3-20020a5d4d83000000b0030fd1e322a4mr4923912wru.56.1686839777713; Thu, 15 Jun
 2023 07:36:17 -0700 (PDT)
MIME-Version: 1.0
From:   Jake Rue <jakerue222@gmail.com>
Date:   Thu, 15 Jun 2023 07:36:00 -0700
Message-ID: <CAHe0yEbS0jcq2LsTcU8MqTDq+5HD0iXqnu-YXcLXPWm090PGKQ@mail.gmail.com>
Subject: Does the DBUS API prevent obtaining GATT information without a connection?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I was looking for a newer and more supported way of collecting GATT
information, rather than gatttool, which I understand to be
deprecated. I was looking at bleak (https://github.com/hbldh/bleak) as
a potential python-based wrapper.

However, when I try to use it to collect information from an AppleTV
which I can collect successfully with gatttool, it errors out with
"bleak.exc.BleakDBusError: [org.bluez.Error.Failed]
br-connection-unknown". I eventually tried the same thing with
bluetoothctl and it gave the same-ish error of "Failed to connect:
org.bluez.Error.Failed br-connection-unknown".

So the difference seems to be that bleak/bluetoothctl try to connect
to the AppleTV (which it rejects, if I don't go accept the pairing on
the TV itself), whereas gatttool doesn't make a full
connection/pairing attempt?

The bleak developers said that this is a limitation of the DBUS API,
and that there's no way to get GATT information without a connection.
Is that correct?

Cheers - Jake
