Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12352C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 20:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiBPUdK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:33:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiBPUdJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 15:33:09 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECE215DB1E
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 12:32:57 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id r20so5174235ljj.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 12:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=uv1yE6twkHO/2UaySKAEznZVRNXv3W4brXy6hRbJE4Y=;
        b=AzlJRwHkmWXln1wb8wICII4lKJf3lnzcxOQYSQT7+aC4kfNj9oZqf+uWgLWPZptHWv
         776ouw6t/mIpwG9P2Lq1ydhO3RXx2MnPxw/7vkVlxcRV91BCoIIz3nrmw7RoNbWQAofI
         XzjdkDSfdk/bRWAx+3X7EgsEOg4mtYZSrNAoFQsYHMYS2bYdcq6GsD5PN0WXa8TJIeFV
         oGsGGv22VoT4z7OiO88A/renGXUtq+8f6Ow8IBMwBDeyEmNGfoZO+wSVJNNRHcEUyWXb
         bTcz98d96pZFGl6/omBn5Ok7BQ7V6VV8sJAdFQpQ/6T/xNkQwlzXGdcroZYESOH2R1L0
         Gybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=uv1yE6twkHO/2UaySKAEznZVRNXv3W4brXy6hRbJE4Y=;
        b=OsATOGwbozlcDUcLBnDP1USQDpppT5R+TVIHvPwFK8h7Q0rnrD/B7H62wblx1qr3wz
         xuaNOLl4yGeokP/EaP7C4nO/3QERoSFglFInwVQN1wFJf9ziRZ3bIEj3B5UFUKEVK3Zl
         wQX7q5Lz3aYSLzDsFdHTSQA/0xuSRpcDb8XamMDTveEMGKsMMPoSVuysof3Q0EA9566U
         u/W653KxBFqyoChjeDaQN+FP6sS7JY4vFbjHItjYurs4lggUJD6jrkXSPHIy/KRidzPO
         x5uueuy8OUZWmuFpiVhrNdNES/SdCYMZSQlbIt7sroHFVLMacRhdp0MpIm5VP20nuhG4
         XvQg==
X-Gm-Message-State: AOAM530LwajYwQ//Tn9yXC4iZlwizB18JG6zaHOgjJWCsihTp+MTkmWR
        YjJoaBTdWMnJHorB8AWvFRE0jqb/W09Itg==
X-Google-Smtp-Source: ABdhPJxFXP95MVMydqQ9s6aJPbJD74rwwHmkd+1r1CyfQehA5v2C9dYkGprPadp0Rj12fynB/bWfuQ==
X-Received: by 2002:a2e:b896:0:b0:241:a47a:debc with SMTP id r22-20020a2eb896000000b00241a47adebcmr3402957ljp.450.1645043575308;
        Wed, 16 Feb 2022 12:32:55 -0800 (PST)
Received: from ?IPV6:2a02:2168:8737:3600:88ca:7ec5:de02:41c2? ([2a02:2168:8737:3600:88ca:7ec5:de02:41c2])
        by smtp.gmail.com with ESMTPSA id bp29sm99458lfb.239.2022.02.16.12.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 12:32:54 -0800 (PST)
Message-ID: <6bec2be7-a411-c5bf-6e5d-b3efee33b834@gmail.com>
Date:   Wed, 16 Feb 2022 23:32:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
 <CABBYNZLA6bRCxd=Tse_XbUT8ReBo4QjvstSassfQAcTX+Fk9_g@mail.gmail.com>
 <b50b9b75-96ea-0d93-3687-3a79cdec5419@gmail.com>
 <CABBYNZKAUMOZ8vhk2ATPOaVHbcqCTg-DMD2vypkx_CTOjeVg2g@mail.gmail.com>
From:   Andrey Butirsky <butirsky@gmail.com>
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
In-Reply-To: <CABBYNZKAUMOZ8vhk2ATPOaVHbcqCTg-DMD2vypkx_CTOjeVg2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 16.02.2022 23:26, Luiz Augusto von Dentz wrote:
> So we are receiving the reports:
>> ACL Data RX: Handle 3585 flags 0x02 dlen 14
>        ATT: Handle Value Notification (0x1b) len 9
>          Handle: 0x002c
>            Data: 01000000020000
>
> So I suspect there is something in the HID/uHID not working then, what
> version of BlueZ are you using?
>
It's BlueZ Version: 5.60-0ubuntu2.2, Ubuntu 21.10
