Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AADC433C1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 01:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B38161920
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 01:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCVBeW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Mar 2021 21:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVBeF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Mar 2021 21:34:05 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7BBC061574;
        Sun, 21 Mar 2021 18:34:05 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id t5so7959518qvs.5;
        Sun, 21 Mar 2021 18:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=D0VAsMBx9s6m1EfahMT+VBysZ6Gxa9IY/nOLkqBzFhk=;
        b=eBaaTkLUCus7nTvlLiatH03Odbq9DQ+K5k3ne4E6gdVCDVggflDcqRM/jTRnR2e9Xo
         /vQWuVOr8zK3Zfa4p74CgsWshUUJpqi/3smRun/4Pjjl3Jj/h6GYZmMWne5bQdJqtn6J
         AODeDpdwrWYFKD7XW/1351AByKR2Xxnn2ZqYabGi+cEJ2DVRX4RnRT9vmSYDnWLcn0tM
         EYzKX7DqSzRVvf/n9P3NznFYXppSkJjUMS1P2moT8xdvUUFAcH1MvFYTQJDn9z+FFrKQ
         Aex4uXpfgLfynHi24LxPlKaGJSKBxoKw1c60BbJFe9szR0k7NkXqtMTdXuxIYYFt++mI
         JzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=D0VAsMBx9s6m1EfahMT+VBysZ6Gxa9IY/nOLkqBzFhk=;
        b=XVCpJLHl7UXv8DC/SCItzHg2DJ5IPkKQ54GSTzdPTJv/xx8JYD/TYNQXNQa/N8dgW7
         frbOdixPgPe7zOT8eNt+fea75+s2osFfnzpo+ReYraSTdXJ7qT8axsQEA27nhWCFi2Rc
         bJpnWHzxIaM5FsLfMnsGBSrT6n8l6Zg1xLXcoquX13rQFJXmQlhcF0vSVcFE5CF6Str6
         jD1RVdkKbd1MirCpi3V1BIFuhJ+28E4KcSKqGQLZJ7sCIYok9CjyQdlpaZCqMhsQbWEj
         gTUbmQDfHPDbSTOjXOmSFvA97RCWrMlGTrn9lK2ipnyQzOOOamO13EIQLzEZtQqALjox
         /ghA==
X-Gm-Message-State: AOAM531fp8CKEXW6d6UVLKZfFR1w3zsUrByvhhQUnSCdvO/SHY3e2eW8
        Kystwp54XXJCqm++buc8lCY=
X-Google-Smtp-Source: ABdhPJzDPBHuVxDpqyKT1JgQJ1757/8uz6T/nnATCSXJ/aKaZnJMtQdzYC6hUL6z9eD5J1ot3Yae+w==
X-Received: by 2002:ad4:4904:: with SMTP id bh4mr18953829qvb.53.1616376844461;
        Sun, 21 Mar 2021 18:34:04 -0700 (PDT)
Received: from ArchLinux ([156.146.54.190])
        by smtp.gmail.com with ESMTPSA id c19sm9571055qkl.78.2021.03.21.18.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 18:34:03 -0700 (PDT)
Date:   Mon, 22 Mar 2021 07:03:54 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_qca: Mundane typo fix
Message-ID: <YFf0AmJN0fz5Z3Og@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210322010051.483622-1-unixbhaskar@gmail.com>
 <b1867efb-afcc-1f9e-fbab-75a7793a2649@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f+1bav2gwg7CE5Fk"
Content-Disposition: inline
In-Reply-To: <b1867efb-afcc-1f9e-fbab-75a7793a2649@infradead.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--f+1bav2gwg7CE5Fk
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 18:30 Sun 21 Mar 2021, Randy Dunlap wrote:
>On 3/21/21 6:00 PM, Bhaskar Chowdhury wrote:
>>
>> s/packat/packet/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  drivers/bluetooth/hci_qca.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index de36af63e182..f2eee9112e41 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1066,7 +1066,7 @@ static void qca_controller_memdump(struct work_struct *work)
>>  		 * packets in the buffer.
>>  		 */
>>  		/* For QCA6390, controller does not lost packets but
>
>		                                    lose
>
>> -		 * sequence number field of packat sometimes has error
>> +		 * sequence number field of packet sometimes has error
>>  		 * bits, so skip this checking for missing packet.
>>  		 */
>>  		while ((seq_no > qca_memdump->current_seq_no + 1) &&
>> --
>
>As Ingo said, please try to fix more than one thing at a time.
>
Okay.
>--
>~Randy

--f+1bav2gwg7CE5Fk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBX9AIACgkQsjqdtxFL
KRVCogf/dBPIjlC1CpUjwXJHOylINjrXf7sBL7Mqfr85DLz6lyUGSj0rYo2JES4x
OJFM0HkyFOoipZH1a36M2ajTrW0lGCOsYOPjZjqN2hXW4oxU8og+3nlcX6Dddoy3
lLkO3/Reo9iB9mVXLPFJvGSVpPMw4Wk4hzyeNrVHugDjN9xi1/sbzEhp0ZCKjh2G
P34si32rpjts2idzSi/GZmwlArsTl2UpOFXAU3p/npaAL375hBX3AC2ks/kCRG+D
FHu50pbvC4Awbiah8kUkfSYvuW9rZ+mgehBv8m/RDh2H2IMJZBtC8GHxV8thqB6M
VhV5U6ZQJHh7jT8Tt4Ze8tCwT21BbA==
=xyPK
-----END PGP SIGNATURE-----

--f+1bav2gwg7CE5Fk--
