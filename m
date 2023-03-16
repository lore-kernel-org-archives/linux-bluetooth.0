Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127EBC7618D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 09:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCPJei (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjCPJef (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 05:34:35 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D4A4A1F6
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 02:34:20 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t9so998969qtx.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678959259;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xxDJIYlceulBDSUUAebm+jvSosbrYNnpgectZkUiT18=;
        b=lFu0pkLL4T7xtGry2ZUDbPSBrN7KBn0ZIVYTI03csLL63nOM+BfT2mSSgX2uFm0q1n
         PA/rSSroiZUFLZk8AsR3+bmyxWvyhvIEy+/Zlx2GrMXCkK1sd1zFqKcDAy1CiMDxQBWE
         34DjarUy7CrIA12vIwtdxAQVoZOtBWZUZJLXYaAVVlVKXy4LYWnZkSgljtpFg7aYNdRi
         r8EkmkeP2NLxIkzxLJghlOxXX4WgmzLow+fKccDzgxEycMyM0q00FSvbakUTYmdKTSTS
         VsmvmhmUzEWMhMiqtGiG5JqcqzkayJ8OSoNkMChowLqyRhks7SgG6gsP842+V92fGN+g
         L3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678959259;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxDJIYlceulBDSUUAebm+jvSosbrYNnpgectZkUiT18=;
        b=YUwldo8WSs4UImqyKOy5nkdoq+16y8HvZpRuwWEksKFwTai1WYyMlvLZt7AKjmk1bA
         uubFFvKcCGCMnfRVeXmiU1grikfVcH/QOL7E8KYFSe5Oci7Nxg6If0MZfW1eN9MwiGF+
         vXJ3i/SopXTEi0N8otTubQ/PG2dXJF/tuKg3SWt9ir0pK5ky9JepIiDTOk8ZZfA5L0iQ
         z6vXicjnGuG+g/9jHc8cQmUUx5rdeczJjyyqjyLA0eb80J6lGWQbIVjHxII6kdgeOvtP
         4mum65ETq5mYM9EksZC91x1Wbj8sMq3Aq5gTfVrRa3EZWNTmniN65vn3ECynY4jAvGEf
         CI2g==
X-Gm-Message-State: AO0yUKWtGWDV9NYJ+Abh3fTNPk+bujg3XzmOoeOt7kqVGooDlHmn9BpG
        pOjqcIcM1mzbSR3w2YKI5rIp4KvnfSBXhg==
X-Google-Smtp-Source: AK7set+EjQoR020iIkp0PpIfO8IPTnwbYWQ6r8EtTJ1zPg0szUpjQsLaDj9cCAkuag9830VaoEkvnA==
X-Received: by 2002:ac8:7d55:0:b0:3bf:d237:b154 with SMTP id h21-20020ac87d55000000b003bfd237b154mr5539239qtb.0.1678959259468;
        Thu, 16 Mar 2023 02:34:19 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.144])
        by smtp.gmail.com with ESMTPSA id h25-20020ac87159000000b003d8d1ec2672sm158567qtp.89.2023.03.16.02.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 02:34:19 -0700 (PDT)
Message-ID: <6412e29b.c80a0220.67286.0405@mx.google.com>
Date:   Thu, 16 Mar 2023 02:34:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6402169922808548510=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: msft: Extended monitor tracking by address filter
In-Reply-To: <20230316090729.14572-1-hildawu@realtek.com>
References: <20230316090729.14572-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6402169922808548510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NzMwNjgxCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS4xNSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjM1IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTMgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MzMuMTggc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBXQVJOSU5HICAgMzYu
Mjkgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgNDAuNzIg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTA5LjU2IHNl
Y29uZHMKQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMxLjQ2IHNlY29u
ZHMKVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDQ1MS43MCBzZWNvbmRz
ClRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAxNy41OCBzZWNvbmRzClRl
c3RSdW5uZXJfaXNvLXRlc3RlciAgICAgICAgIFBBU1MgICAgICAxNy44MCBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA1Ljc1IHNlY29uZHMKVGVzdFJ1bm5l
cl9tZ210LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDExMy41MSBzZWNvbmRzClRlc3RSdW5uZXJf
cmZjb21tLXRlc3RlciAgICAgIFBBU1MgICAgICA5LjMxIHNlY29uZHMKVGVzdFJ1bm5lcl9zY28t
dGVzdGVyICAgICAgICAgUEFTUyAgICAgIDguNTUgc2Vjb25kcwpUZXN0UnVubmVyX2lvY3RsLXRl
c3RlciAgICAgICBQQVNTICAgICAgMTAuMDAgc2Vjb25kcwpUZXN0UnVubmVyX21lc2gtdGVzdGVy
ICAgICAgICBQQVNTICAgICAgNy4yOCBzZWNvbmRzClRlc3RSdW5uZXJfc21wLXRlc3RlciAgICAg
ICAgIFBBU1MgICAgICA4LjM1IHNlY29uZHMKVGVzdFJ1bm5lcl91c2VyY2hhbi10ZXN0ZXIgICAg
UEFTUyAgICAgIDYuMTEgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQQVNT
ICAgICAgMzAuMzQgc2Vjb25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMKVGVzdDogQ2hlY2tBbGxXYXJuaW5nIC0gV0FSTklORwpEZXNjOiBSdW4gbGludXgga2VybmVs
IHdpdGggYWxsIHdhcm5pbmcgZW5hYmxlZApPdXRwdXQ6Cm5ldC9ibHVldG9vdGgvbXNmdC5jOiBJ
biBmdW5jdGlvbiDigJhtc2Z0X2FkZF9tb25pdG9yX3N5bmPigJk6bmV0L2JsdWV0b290aC9tc2Z0
LmM6NTIxOjQzOiB3YXJuaW5nOiB2YXJpYWJsZSDigJhycOKAmSBzZXQgYnV0IG5vdCB1c2VkIFst
V3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXSAgNTIxIHwgIHN0cnVjdCBtc2Z0X3JwX2xlX21vbml0
b3JfYWR2ZXJ0aXNlbWVudCAqcnA7ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBefgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============6402169922808548510==--
