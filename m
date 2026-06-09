Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661C31ED83
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997981; cv=none; b=FP2jGd3WJWJfC7lXKtZckVeMiOqMXSc0YXE2iEV7qmV4/kOhOB3XCmXfsMNFB+Bpr3IjuquTxzYx1vFf0lQUhkxiEhU838mub9VwlL0y3E5hkeGf0z09LfTzj0iuID8qRImh+2S9NyLUwjwLfflGoL6kWz+kv5R+Y9u6mG240n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997981; c=relaxed/simple;
	bh=kdz9D3H7e3YdUaV/C+RsLrjdqWIeMQvB7ZDx7+iPsUY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+Y76JWUHKgzhaGTB+uA2IFlEEXpB2s7I+p7kSXr0Ehg227hIcXMdoDOmMkz97K5JwLR0Z/eyJBBDL6D3wOrI/+Da2JBDtbEgt9HnVrLv1XxM8RSktHZdbsnfDqImAwJl2tAUSxvIkCqvwwft/kYpl4fyZ5+6NG7F4v1KV7bmk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtgAWlmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtgAWlmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C431F00893
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 09:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780997979;
	bh=rATEdl6LiQR60SP/nV4ENkMWz6HgzyeezathKrPkQ1s=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=mtgAWlmgPDZcpdDtD4lieFSsG4btlrbSaVZh70DFUHsg2URdIZ2UbGzG7ihnlqQRv
	 rVN+KihVq5Rw46+fP6/cyhnIbTfh16IRHQ+MPEQnsPM41+UTKk8MIbwN1FE+iAYgEm
	 XP0Kve6dvFjIMlLG+IuQSNcjHZpwSGj7csc7H43Eb0aMUM+VlKpgaeY+VFJk5S8ZS9
	 YtnHI8Y+xXAbjq55iwc+Dq0J2utnCIWxyqrK1D/4ZPBecFShzCUSpXI8/4y7C7W+4z
	 D7VW02nOUGk7OhEKbAtMHgJaSh6XiFEfI23ibe6myXQTkNtmZDnzS6GI9FK2Tmk658
	 TsrCRZ+YtCWew==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa68d9d4a3so5802404e87.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 02:39:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/SOJ2i5v08YIZVL8VXCo69Z7bYYSpHo8UIs/54NyN3JZlsoLYmm2yKKZQaB9pIU1BYKuwbK7TycNMcQYWrLVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmqZcSml8jx0PwnHcM9ayha2OQgcoT4NMDm4Z8X3UsFWnYNwB
	soaweg5rpK4EsZZ7vzBk0xrpUZHl7GZ93llwqQ22/p4yHLz902PvFImhFj2NCPmByRaEKrpSJwM
	ygXv6aYrx7mPzIuMJBe6sJS7u5bCMzT8wNMajc9crXw==
X-Received: by 2002:ac2:51d3:0:b0:5aa:6db6:530 with SMTP id
 2adb3069b0e04-5aa87b91e94mr5254399e87.39.1780997978417; Tue, 09 Jun 2026
 02:39:38 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 05:39:37 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 05:39:37 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 05:39:37 -0400
X-Gmail-Original-Message-ID: <CAMRc=Met_U-1gDmGFM9hSWFc5vvs4SuRQOa3hZcfUo190rh59w@mail.gmail.com>
X-Gm-Features: AVVi8CdoucG7gnwn5riE2gVBy_jdERgKCr_gvLA0oc9UySp4KG6r88TvBMADcr8
Message-ID: <CAMRc=Met_U-1gDmGFM9hSWFc5vvs4SuRQOa3hZcfUo190rh59w@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: qca: Add BT FW build version log
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jun 2026 09:54:17 +0200, Xiuzhuo Shang
<xiuzhuo.shang@oss.qualcomm.com> said:
> Printf BT FW build version log after BT FW downloaded.
>
> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index dda76365726f..04ebe290bc78 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -143,6 +143,8 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
>
>  	hci_set_fw_info(hdev, "%s", build_label);
>
> +	bt_dev_info(hdev, "QCA FW build version: %s", build_label);
> +
>  	kfree(build_label);
>  out:
>  	kfree_skb(skb);
> --
> 2.43.0
>
>

This string can be read from debugfs, do we need an additional message in the
kernel log?

Bart
