Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494CEEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jul 2023 19:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGFTSL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 15:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGFTSK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 15:18:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A3B1BDB;
        Thu,  6 Jul 2023 12:18:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so16921531fa.1;
        Thu, 06 Jul 2023 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688671088; x=1691263088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ8xlnwwG75DABomjaI7QqlxiiSgIPWY3Gi9RsGEoCA=;
        b=DncxFNWwCFbdrSjJxSYqFDPVWaVajWn9H0YCGO+yFZy2UwIoz/6ypnWPxnvj6XXykn
         moJU4kiCO9a8LILaoo7QJ098RH6E1yYHsxR8uEuqwEyFaP82tLEMoAb805Hi8GO0CM92
         ZYbrDTiVvD6Tb+XxK4YMP33xMVvWU69STULo7vLbNLwRwVlQR9AjO8SZYYkjO0KZy6jl
         MwMXOMi7PY5V32Gv70CG58WrQPKuRH3WwJxf3zqsoy+EFiAmA6ETlBNAjCf90SS8g/S6
         Hnjw2g/91L5YUQivLPJrzBeC6NRXgEjNJnhvKkdYhGn0muy2d8Ub9EYvN9rEHa0fz58N
         JF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688671088; x=1691263088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJ8xlnwwG75DABomjaI7QqlxiiSgIPWY3Gi9RsGEoCA=;
        b=Jlxm3RVnrfGtpjlImKFRERcNVdS1DJlIEiznyQi1NkNuz6cF0mK2bR4xUxZdKgTh4f
         fKFMNEkMN86fjh/zTgs1mj3xs1DLIhlJ21gR1L5eJ1bEn+Wkuy69OJjtuJVv/Af4sFkr
         Ps+DCRGrAz7DOTeexN7pnqGJVaj7xOe0YOUN/UxDZIMh5zldyZ0IFEezd3ls3yb51EZH
         y62/NQqY7tv2EY37ZVNKswmXJecirp/nOHMwi4q/brqM+vhud0NN7vk+cVsCvi9PFaAO
         K6FV/9Xb/uCCj6OOn/jQhqO2VSoy4oi+H8AUCpfylnnK4+L7i/rGLE52pbx0fJV/1wBA
         lvvw==
X-Gm-Message-State: ABy/qLYDEyNlXAtCBidlkitWPYEETgGqMRaRn3x+OXX5UMYaKuMGfIzI
        RPwn0iCCgeyJmYqTglxURrBkPzjhwGwHZ3ncS5k=
X-Google-Smtp-Source: APBJJlFSrfGsuI1nlxg860DIpmq2c4FEKlks4TgweGqMuykwf8uclJG9TycE6f6WQknLrbdfL+zAc6WsJuFW0mJ+y0w=
X-Received: by 2002:a2e:b681:0:b0:2b6:cad9:75ba with SMTP id
 l1-20020a2eb681000000b002b6cad975bamr2096948ljo.29.1688671087635; Thu, 06 Jul
 2023 12:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230702210138.226929-1-valentin.david@gmail.com> <20230706191035.736632-1-valentin.david@gmail.com>
In-Reply-To: <20230706191035.736632-1-valentin.david@gmail.com>
From:   Valentin David <valentin.david@gmail.com>
Date:   Thu, 6 Jul 2023 21:17:56 +0200
Message-ID: <CAM06Q5T7LtyenM05gY0BcyFeGqGbwTLPaL70Fv6pT9cAChpmSg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Forget about this patch, while rebasing I saw someone else had the same fix.
