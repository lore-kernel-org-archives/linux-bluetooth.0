Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF57EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 17:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGTRaT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjGTRaS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 13:30:18 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4672D4B
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 10:30:13 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7866189cff1so46970539f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689874212; x=1690479012;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZpOYr1V51YcK7vMc04TQ13vRnr86yNoYytTnVzqXwOg=;
        b=fUlepYTiXUWbUNHchJO3PTxUfPyp+kYReBjN0jiKj7akuXwjlsWfvc+R046sSOZ0ZQ
         bgDhbCf39XuwqQKzNH/CFCvgBzgKPfo9dp1chm2KdHbFMdfU4Glj9lu4R+vF45Cnr0ck
         tJDiAtkGmdGCiumEnIjkU1wQ4mH+I+hw+/xF3TLeOpL133xxVKOQhIyPew9bTbQzrahe
         rPfKGHY67eikNgzBGA9489rdvfB5GfJH6ItMz3bLUM1p+jlpbvaJUKSydMr76/3TNB6X
         NAFxAm5gqg26IMcNlhQzg6xnog/sZ7QEZeNQY1LSesSoIV63UdW7TwN9zWJ8iQTHYIoT
         Kt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874212; x=1690479012;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpOYr1V51YcK7vMc04TQ13vRnr86yNoYytTnVzqXwOg=;
        b=dj3umLBlbN7a9cgZTacdlfJSDIRidPzwkcDVMUxdbDWV1c3vDR0pY6tHF6lMFn5oQ9
         UnUkxF95VsdGr6jtDDW43kf01N5rnkETzBHsCgDqn4UbX8Dv04m74qWjNN9eqgZOMrVU
         ZTXPViyMKZ8yd6CjVvx9yTRKQn5UUF1a4EvdQbzPo5Yos9NQQ2GG+pOSciZrbqaBEMqj
         o9TRc7VztCRI4aI3bQqH0InXW1hIVAJQMrpVC2Jv8l8O3iICAlA9muSbjkNHpLhoRwNh
         XSSAKkkqZybn56I4+afaNlYLijpb523cyGFHdMQaHsZHyihUhohTT8AFnx2htj25fUhm
         BUUQ==
X-Gm-Message-State: ABy/qLaON0BXODHKNztUwR2F+6MtaUv+1SbxoSfeUHONYNlYYxSBknAd
        iMKWxc+qvo+WEigCCJYfpbhfrQ/C1dj0B1Tp1K3Hnn12SBM=
X-Google-Smtp-Source: APBJJlEkxYIGjXKEHfIuHKWPZ7+MJzEN/+A66W4JdodRIKl7XwEh4iH35gARWwCZTx0XwwY0ElaXpL3F6Sbu4ZvYy9w=
X-Received: by 2002:a05:6e02:1686:b0:348:76eb:17d9 with SMTP id
 f6-20020a056e02168600b0034876eb17d9mr7412112ila.20.1689874212338; Thu, 20 Jul
 2023 10:30:12 -0700 (PDT)
MIME-Version: 1.0
From:   Dynastic Space <dynasticspace@gmail.com>
Date:   Thu, 20 Jul 2023 20:30:01 +0300
Message-ID: <CAEU5HDZD-U7vrQrusZxYW7L4wPiZL5m2kZw0nDz401oJjiVs=w@mail.gmail.com>
Subject: Daemonizing bluetoothd
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am reading through the bluetoothd code for version 5.56, but I
cannot find the call that makes it into a daemon. I don't see a fork
or a daemon call. How is it turned to one?
I am compiling the code on an OpenWRT system.

Thank you for your help
