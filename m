Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767E182D0;
	Sat, 21 Jun 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517471; cv=none; b=I7pyYOI3S0wj9FYySXQj45aoWf1p03oTXMt/jr6LVPrdXh5O9/aHjHxNR2iOqycG8F4fO5G1ZAcH0jZYvlaysyZZaOJMoEtaBUuUxIG3aXw+IfaOubit1bSmJG5YbYfEvqmLBiEV9i26LWnkZk4wgBDEjNSqthc8y80weRhQi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517471; c=relaxed/simple;
	bh=CULzOHrNa1v0/Zgb3GPlUZZVaPtzmTHZr3Wj4HpeuAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6aLZ/U9E5tekf6aKbEf0v+zZfYK0ODTNIJULjjgcoNRFnBEL4PDFjqlbZnfVkQJ17mVshC2WVOJSSTpF5mAwhTtb6DO6jmReiFpLLddcF8LtxFO0/cp/AkM5NfgppoCm8scKljO7qU3ucWIfErU0LMtRzF76fYhvMnRp4hE/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZh5CRqu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZh5CRqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7224C4CEE7;
	Sat, 21 Jun 2025 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750517471;
	bh=CULzOHrNa1v0/Zgb3GPlUZZVaPtzmTHZr3Wj4HpeuAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NZh5CRquqvFPjnnLbvoipfkKopAZvSZrATedUvcYOBQdxgzrRkGT8ysev0z83u2C4
	 rOr9etCHTHIxDCwCBTqaH4HusQHB1SFk2cWEwZP6aUow3oJcmsMvZgLE8QxlRwIWI9
	 WW6X/lS9PYF8Kx6kY/DXZuAui0yu9Mm8PYXd+ZLcfQmS+O/mB0huDN9dSfnfPwIE6t
	 BQOb8HZprqHgm0ftddFh9pmiKTBV5eP8fPbxzXSWHbU84dfxyYKhlwbjNi5J0i1aFL
	 gVnULQCN+TZtmy8KdTbSpBWSDayMfyE/QDavlnHjv27PAIZ+9ZN6KtHHU8KlqT9GWq
	 OVG4Z5Ln7Fo5g==
Date: Sat, 21 Jun 2025 07:51:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [GIT PULL] bluetooth 2025-06-20
Message-ID: <20250621075110.686bbf0f@kernel.org>
In-Reply-To: <20250620175748.185061-1-luiz.dentz@gmail.com>
References: <20250620175748.185061-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 13:57:47 -0400 Luiz Augusto von Dentz wrote:
> bluetooth pull request for net:
> 
>  - L2CAP: Fix L2CAP MTU negotiation
>  - hci_core: Fix use-after-free in vhci_flush()
>  - btintel_pcie: Fix potential race condition in firmware download
>  - hci_qca: fix unable to load the BT driver

commit 135c1294c585cf8

        alloc_size = sizeof(*hdev);
        if (sizeof_priv) {
                /* Fixme: May need ALIGN-ment? */
                alloc_size += sizeof_priv;
        }
 
        hdev = kzalloc(alloc_size, GFP_KERNEL);
        if (!hdev)
                return NULL;
 
+       if (init_srcu_struct(&hdev->srcu))
+               return NULL;
+
        hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);

Isn't this leaking hdev?
