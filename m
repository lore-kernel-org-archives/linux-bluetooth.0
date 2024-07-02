Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C51BB69E;
	Tue,  2 Jul 2024 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949249; cv=none; b=EodpaNzpnpdNQyLVHtqw6mBzYwzRKdb9EKLam/MPLZ5l0mZiQkgHMq89olWrqMC88EI/4Rd0iapxzpshpM49rBdxnD7b40x+wBo0+QbFpCyVZ2fKMkYXh/0Ah7Qi4PBnWptxTDRDRfS7Hdmi6RipqNpB/PE1mjwNhCGOQFhPbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949249; c=relaxed/simple;
	bh=pkS+uehYQlYkeUjG9ipfbE+aFZyfxuZEjI584xLWUA8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YiBxpTVb/XMBKvEwuwLjJxOEygn+edTIipkhxa3/dsIlmv5BwmcITj7fNJ2fRWuvMz/j50u7lMQdzynw+x7BdE9KKDj0klaD0tx56IvAeFubNCLwTHR/qb/9jzH9ybjxpEANAaWYpOKpjwo/ipfeJmx+lLPkV1rwkQufwXnqzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eBvyqQPH; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eBvyqQPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719949235; x=1720554035; i=markus.elfring@web.de;
	bh=Dhc39LuDQM+jcrdSlNLZclGK8q3LqZ3pmc/NDCCAcVE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eBvyqQPH9fyxpbaK89lxdGwkjYo8MbzeWlMs8joyXg3ePkux70SD5rqGn59KDots
	 qpBEWznQHjPLYSgXMW679oVVj5vSvh8bobMyvxm+B67U1E/z/dgCwzGzf9Vslz3H4
	 8usgIcRMFLPzS7k25BvPt8B5w61xwZQRsFXevaQbwMDk4W4jlMQmDwF2F0Vz2ENLv
	 ajR5csjnzp5yiltWl45TX82pVXsO3hJomTXNrkZG3jg/yNOHqUGZxhwphOW84tCp2
	 ssh/uci44kWs7eSeO4/VlwRACBMv4qXmAazaSzapZb/qQRkrvifrhJGE3U5ZEcDcG
	 Wj5LxM52ehbeDDlVIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4N9I-1sFTfh1YMI-00zBJ3; Tue, 02
 Jul 2024 21:40:35 +0200
Message-ID: <4036b194-3014-4523-b8d0-ea39664607a3@web.de>
Date: Tue, 2 Jul 2024 21:40:21 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Levi Yun <yeoreum.yun@arm.com>, Yunseong Kim <yskelg@gmail.com>,
 linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Austin Kim <austindh.kim@gmail.com>,
 MichelleJin <shjy180909@gmail.com>, Levi Yun <ppbuk5246@gmail.com>
References: <20240701194531.97576-2-yskelg@gmail.com>
Subject: Re: [PATCH] hci: fix double free in hci_req_sync
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240701194531.97576-2-yskelg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nVwmcktw2EYzu877tUCa7svrrEhZ1hamaJtqWuUoPJLpFwPJbJe
 cv4vExJyFG8r9t9GhN49Zs4TeuJj3b+UuX7idLJ7yqMuAUoQxvJPSZ+EzMprx7veR+ejJq7
 mdAH045uB2bxA5vMO4xNTHx09sC5r7FkY5/Awe1Vh6as7O4x3/YjuJxkgEMhu7AG5fv7nWT
 dOvarq064+4g+sHZ3HEtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:44BwTlUuJh0=;ZkMUOwb34lNWL1PT5pTmzoXFR3R
 htrYeea2NjbabDgePmVU8FdyjNP21quHeuHIouuO1fdasZ82JDZ/hsXbcBRLQDLE70Cmi1zms
 XH5OYrFuo67C8HH6cdWYpdj1eHh8J/jlfQuEe/+MmaaLW6OMZUMUUV7u/liwZpHhoaJUyITmJ
 4DDzLN9tLMd5O1//f8pRsYi1R1/kBP4drn4dKITqiH9rgbPxIgd/xKHza1HSFBMiTT3Il88jo
 /dZyE/DnB2pO39QTsndLS27mxz7x5qgY5QI55DMFyBLiJDYC5hN72+2tYFc41J5n3WCrXMmop
 VyVpdC6pqQzSZwHiXYVL+8LNAUaR/Jx1RaRMWsof0AAJSwjMZAs4N4K+2s8mXkE03fLOlmZSZ
 y+GFe/GK1G6Ngywsn7RngNfcBg/+PuSaBMrEgZvbWkfrJqcrQ08H1QgeGUzWAwX4/3k/autQW
 J/gIR50tAUvLLe4iM8lXVAMLj+WTEd6f/HgeBVLc7vDVsf27Z1a9pgIjjx9Z+o00Ng2VOVnAb
 rF2kabI5t8QRgzE0AtcKrZ2aB9/7kJOtJ9pfUlDRHCPvzkuBmGVcyHwYwpkJnti2BSdepJ+vG
 5JRNwfQnT1T9IhaWistTN1r6cEQd0u8xvn3H9TsCPvPdyUp7/07o8jdvtig29Tp4J+mEdl6Y8
 enrpgnVil8IgTg3pEsEDidWVpzfoY3nJMloncjdRK0aSynTDtfrOzwqIMgQ74Gv3g2tP34nxe
 leRrnN16Z/enGsn1AqE8eCzzHPejdp7m7hokfYSAUl9kaLHtudJOfUnlbq1Cz6sOKcgiJHHYC
 BLl+3Haf/NUPy4Mhg8TFUjBXeXw/Fh5JrX9q8ERsrmb6A=

=E2=80=A6
> +++ b/net/bluetooth/hci_request.c
> @@ -106,8 +106,7 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 =
result, u16 opcode,
>  		hdev->req_result =3D result;
>  		hdev->req_status =3D HCI_REQ_DONE;
>  		if (skb) {
> -			kfree_skb(hdev->req_skb);
> -			hdev->req_skb =3D skb_get(skb);
> +			hci_req_skb_release_and_set(hdev, skb_get(skb));
>  		}
>  		wake_up_interruptible(&hdev->req_wait_q);
=E2=80=A6

How do you think about to omit any curly brackets here?


=E2=80=A6
> +++ b/net/bluetooth/hci_request.h
> @@ -28,6 +28,15 @@
>
>  #define hci_req_sync_lock(hdev)   mutex_lock(&hdev->req_lock)
>  #define hci_req_sync_unlock(hdev) mutex_unlock(&hdev->req_lock)
> +#define hci_req_skb_release_and_set(hdev, val)		\
> +({							\
> +	if (hdev->req_skb) {				\
> +		spin_lock(&hdev->req_skb_lock);		\
> +		kfree_skb(hdev->req_skb);		\
> +		hdev->req_skb =3D val;			\
> +		spin_unlock(&hdev->req_skb_lock);	\
> +	}						\
> +})
=E2=80=A6

* Do you expect that any data synchronisation should be performed
  for the shown pointer check?

* Can it eventually matter to implement such a macro with a statement
  like =E2=80=9Cguard(spinlock)(&hdev->req_skb_lock);=E2=80=9D?
  https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/spinlock=
.h#L561


Regards,
Markus
