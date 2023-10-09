Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C8AE95A91
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 09:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbjJIJ1F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345920AbjJIJ0u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 05:26:50 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F95313A
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 02:25:37 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231009092532euoutp02a62a6f426f1370ae645b3c9f6e7a092e~MZjP1QOVD1109011090euoutp02j
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 09:25:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231009092532euoutp02a62a6f426f1370ae645b3c9f6e7a092e~MZjP1QOVD1109011090euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696843532;
        bh=JOyYLH7k7fFMhIvZWuwlco1Oq2vEnlY9/SZASr37u+8=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=hROyUY7S8A3uN3E1YiQL2NLg3DsD4b/ygOqPDBJphbiTcEsxQF4nIp6klguoNE/gS
         iRz/Uvmrz5m0CKseM3vgdCfB5R/swhsbzk96qKRrKOCvJbA9So+uRe4AQkn/CHDmxa
         lq/1j5zf4WHr03AkAGbIt/Ddz0iGSK6hucIdye2c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231009092532eucas1p1f7a71f71bd91710f6df516e43767f82c~MZjPpb6AC2110721107eucas1p1o;
        Mon,  9 Oct 2023 09:25:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 32.54.11320.C07C3256; Mon,  9
        Oct 2023 10:25:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231009092532eucas1p242f62eb3d719cd749599835de26f52f5~MZjPTYbXu1373413734eucas1p2m;
        Mon,  9 Oct 2023 09:25:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231009092532eusmtrp155adc07dd7acd1d5234426c13df2204c~MZjPSqpaw0122401224eusmtrp14;
        Mon,  9 Oct 2023 09:25:32 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-e4-6523c70c7336
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.3E.25043.C07C3256; Mon,  9
        Oct 2023 10:25:32 +0100 (BST)
Received: from [127.0.0.1] (unknown [106.120.50.37]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231009092532eusmtip293fcc78db869789ea8367326cbc057cc~MZjPCCrND2382523825eusmtip2A;
        Mon,  9 Oct 2023 09:25:32 +0000 (GMT)
Message-ID: <94802ffc-9949-c968-ab96-e63f98cb684a@samsung.com>
Date:   Mon, 9 Oct 2023 11:25:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.15.1
Subject: Re: [PATCH] Bluetooth: MGMT: Synchronize scan start and LE Meta
 events
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Arkadiusz Bokowy <a.bokowy@samsung.com>
In-Reply-To: <CABBYNZ+=c_G9wRRw4BvzypSu980ThzzdcUz_jMthe5_UZnE9Ew@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djPc7o8x5VTDRb2alnMudbHbPH08xRW
        ByaPnbPusnt83iQXwBTFZZOSmpNZllqkb5fAlXF1/SP2gjuCFT2rdrA2MP7n7WLk4JAQMJHY
        Mbe6i5GLQ0hgBaPEhldXGCGcL4wSv3ous0E4nxklph25D+RwgnXMe/cSqmo5o8SN85PAEkIC
        LxklXr5QB7F5Bewkpi44zgxiswioSLQsPMYOEReUODnzCQuILSoQLTFz2kJGEFtYIFDi17u7
        YDXMAuISt57MZwI5T0TAUOLbhRgQk1lAWeLEWV6QCjYBXYlvS06wgticQJ3t+7YwQXTKS2x/
        O4cZ4sy5HBL3z7JA2C4S8+ZNhjpfWOLV8S3sELaMxOnJPSyQgCiXmNOWCvKVhEADo8Sx7Vuh
        5lhLHP73mw3iBE2J9bv0IcKOEqd+vWSHaOWTuPFWEOICPolJ26YzQ4R5JTrahCCqlSQWzD0M
        dYCExLrjP1gmMCrNQgqRWUg+n4Xkl1kIexcwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P
        3cQITBSn/x3/soNx+auPeocYmTgYDzFKcDArifDqliqkCvGmJFZWpRblxxeV5qQWH2KU5mBR
        EudVTZFPFRJITyxJzU5NLUgtgskycXBKNTD5t09nX+77kCM1doLs6htrf946kFaqZs/+bXVO
        OX9ffGWHcfmpnGCWSP8XybGpT/VtJ6yrDPknO8Xu3l4Tp+933vetPiDxePMNb1ZOBskbB5Y8
        sXI6Ysyp2f/lt6Yj99eSIoUdv1I92IwcXzCs5uJyiolQYGDeve5h5n9eKY6gi6HqR35sLL8m
        PkPlQFtGhdW0j7YKy2xlpiy3aDqlL+t6LrN0ziu5/7NOP1Hhsl2bsGaieMxM2Uszw+Qz/tSs
        c9nc/UkphH1NrNfqJYfy1K5fPn5ZTShiy9QoCZszZq+v+bXcevFt+tdzp9Pemk1P138uFOSe
        P+VRGsPj28/OezbUfXp00GR18ITrlbV/vxkqsRRnJBpqMRcVJwIAK2ZM44MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4PV2e48qpBn1nhS3mXOtjtnj6eQqr
        A5PHzll32T0+b5ILYIrSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJ
        zcksSy3St0vQy7i6/hF7wR3Bip5VO1gbGP/zdjFyckgImEjMe/eSsYuRi0NIYCmjxNwln5kh
        EhISex8/Z4GwhSX+XOtigyh6zihxfv1ndpAEr4CdxNQFx8EaWARUJFoWHoOKC0qcnPkEqJmD
        Q1QgWqLrpTFIWFggUOLXu7tgJcwC4hK3nsxnAikRETCU+HYhBsRkFlCWOHGWF2LTVUaJjyd+
        gJ3AJqAr8W3JCVYQmxNoTPu+LUwQY8wkurZ2MULY8hLb385hnsAoNAvJEbOQbJuFpGUWkpYF
        jCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiNk27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRFe
        3VKFVCHelMTKqtSi/Pii0pzU4kOMpsCQmMgsJZqcD4zRvJJ4QzMDU0MTM0sDU0szYyVxXs+C
        jkQhgfTEktTs1NSC1CKYPiYOTqkGpjDWiRrmSecmx7w4EvKoxk7/1hLZOYUV6Y7cfw0r3W5I
        FF91V7DWiJfUeu33TWz+3A3vj+8KtFeYlJjQnWnes2SJT/aKdBn+YqZ9LmqHJ/ysUUxdH8y6
        V7BZqVC67pBVicj1qYm5UcpcXBcntd2LX9m5L+qWg8+hpwcubAgULV+qk3RA7m3h2jsmK+62
        sFl/Ck5ft/zUKaXQqnkiLFaqb0V+pkba8xenzLpj+9PWn/Gn/ev2DQIJSpJvJBOPVb3+HXNm
        8mcld46ZhX5zt4Y9En5hKPRkzaub7g6pkkssTP6IbLvaziPpZbP+4JLT9esbKi8l7Hky5aKq
        9ZTVXHwlC1jDzbbdba/fuTvu+sk1SizFGYmGWsxFxYkAW3flfRkDAAA=
X-CMS-MailID: 20231009092532eucas1p242f62eb3d719cd749599835de26f52f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230928134517eucas1p296d2f03574a8948e642cfbfb5826539b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230928134517eucas1p296d2f03574a8948e642cfbfb5826539b
References: <CGME20230928134517eucas1p296d2f03574a8948e642cfbfb5826539b@eucas1p2.samsung.com>
        <20230928134506.130545-1-a.bokowy@samsung.com>
        <CABBYNZ+=c_G9wRRw4BvzypSu980ThzzdcUz_jMthe5_UZnE9Ew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

>> +/* Wait for all pending HCI commands to complete.
>> + */
>> +void hci_cmd_sync_flush(struct hci_dev *hdev)
>> +{
>> +       flush_work(&hdev->cmd_sync_work);
> 
> Afaik this will block waiting the work to complete which sounds a
> little dangerous especially if hdev has been locked.

Yes, this will block wait for all tasks queued on the cmd_synd_work. 
Unfortunately, I'm not very familiar (not yet) with BlueZ kernel 
component, so I'm not saying that this solution is correct. I hoped
that someone with actual kernel knowledge will review it :)

Anyway, my simple test case passes with such solution without any lockups.

Alternatively, I can move this block wait before hdev lock in 
hci_le_*_adv_report_evt() functions.

> Couldn't we just do:
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 195aea2198a9..78f0a8fb0a19 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -136,6 +136,7 @@ bool hci_discovery_active(struct hci_dev *hdev)
>          struct discovery_state *discov = &hdev->discovery;
> 
>          switch (discov->state) {
> +       case DISCOVERY_STARTING:
>          case DISCOVERY_FINDING:
>          case DISCOVERY_RESOLVING:
>                  return true;

I'm not sure whether it will fix the issue... I've tested it and it does 
not pass my test with a delay added to the start_discovery_complete() 
function. The problem here is with synchronization. Since the LE meta 
event (device found) and start discovery completion might be processed 
simultaneously... Also, it will not be true that discovery is active if 
the state is "starting", because HCI might return error when enabling 
scanning.

There is other solution to my problem, though. In a real world case 
scenario, it's not an issue that the LE meta event coming just after 
scan enabled signal will be dropped, because there will be more such 
events later. The problem is with btvirt, which does not "broadcasts" LE 
meta events when discovering is enabled. So, I can "fix" btvirt instead 
of patching the kernel, by repeatedly signaling LE meta events. This 
will slightly increase CPU load with btvirt, but will work. What do you 
think?

Regards,
Arek
