Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A228DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Feb 2022 17:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbiBGRXM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377176AbiBGRNT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Feb 2022 12:13:19 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7870C0401ED
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Feb 2022 09:13:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g8so4214666pfq.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Feb 2022 09:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DzeP33bVe/PRU7l8u7/ekAKVRkuaC91XduTpV1y5u6w=;
        b=fPGGV4+OqfBLxhXgKlBk8GEqB/OZwotFkK2VUylFNXnzzoy5k7PKvKS/VII80jgz2x
         cRWUvL8sVKacsUb96Hf2u9AzOSzpy4joW1TerxQfRN7cXU5HS+a4DMdiqRCpeAGZgpTS
         bwcuIoPZbpT6NZqgWYXJHRpUPuvZ4z2HqFn4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DzeP33bVe/PRU7l8u7/ekAKVRkuaC91XduTpV1y5u6w=;
        b=A8Ypn1A/vjv1PmU6LFwIsSwTu0LrCmB4Fq2ZT021rAa3/m66LfHgi7tNzsKNjsd3Ou
         ARzymhmZ70kwJ2neIIasxDGU+Jr8THiNlwsqZLwsDn2rvVVf2M8LBK6Jy++aUAZPc6Ak
         NofVSgj473he3fZCW9ZgulGIxQPEzIJYB4XQ42ULs0JeOExHxiEgEBUm+X8R1giD9L1I
         ZGytOY4We0OkdwIMR1ImwpIbwV4MhoLrCaxWtBFr2r5/2Ofz7qJKivhPT7zWHE57hbLJ
         yjqG/C8KdtIbkk/oqyVWw7iE7iFiV1CH0JxKVAFUvH5EYS1thE5AieUacygwT10qJqzo
         rDFA==
X-Gm-Message-State: AOAM530S9LTSfzpFqWDVZl3WS4QcNaotCVAvh+UllHA+zmrS8LtAe9bb
        mqunWNJO2UttY2Qj3u4eryoj3A==
X-Google-Smtp-Source: ABdhPJzcsEZUqhK8vVVbURSYFjIx0GewfFVvnIgrF3hcReRYwiUJF+QzYtK2SQJb856KCk4saoJebg==
X-Received: by 2002:a63:5a65:: with SMTP id k37mr285365pgm.431.1644253997205;
        Mon, 07 Feb 2022 09:13:17 -0800 (PST)
Received: from localhost ([2620:15c:202:201:21ed:2162:c25b:6bf7])
        by smtp.gmail.com with UTF8SMTPSA id 12sm9010815pgb.71.2022.02.07.09.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 09:13:16 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:13:14 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
        quic_hbandi@quicinc.com, abhishekpandit@chromium.org,
        mcchou@chromium.org
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add bluetooth node on
 SC7280 crd board
Message-ID: <YgFTKid5hOCmSJHh@google.com>
References: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Feb 07, 2022 at 09:54:38AM +0530, Sai Teja Aluvala wrote:

> Subject: arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 crd board
>
> Add Bluetooth SoC WCN6750 node for SC7280 crd board

That doesn't describe accurately what this patch does. The CRD already
has a Bluetooth node - from including sc7280-idp.dtsi - what this patch
does is setting the vddio supply for Bluetooth on the CRD.
