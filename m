Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5C23CE
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Jun 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719138657; cv=pass; b=A1dTPrt7dzZRpt/XaoBT+1BRHflQbsXzFC9hTDVpTmR88vjB9E7pBkd6dIYWfuw3t4M8vMOr9lNYh1YeWK5efkxJVhSDXAxC0zdwDR6VLlvTxKDNieerBPmwkZFzvnH/t77yvR/8MQzQG4xyO5lBHMoRKpEloPi0+sGbpsRJNrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719138657; c=relaxed/simple;
	bh=zZnHwD60P7WdPggLWo7zW1sPEAiYdKD2XL8OL3nMSTI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCtOKB/pBA9dnDUKAf3knzux02AlTjgE1SKLYScpXpDYHK3jqi5XO40c7fbfg98eh2q35QG1mkRG9kEsMePcoaa1TsPGiJwG1SpYyC3r57wVWC818vLYqfJzXDyqKJeC/QsyJDXKMi+xGkBHGOZrn0COul05/5Fu8nf6ceJcmUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=i39IQKzf; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="i39IQKzf"
Received: from monolith.lan (91-152-121-138.elisa-laajakaista.fi [91.152.121.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4W6S6f4QbGz49Qn7;
	Sun, 23 Jun 2024 13:30:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1719138650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=77DpmaX65YJ5tBxvrHzr3R+vVPbzThoESe+OM9vHJvE=;
	b=i39IQKzfrUCocL9GlqrgyNCdmFp1fDbzXD8RR3kL2mEYj1suK0gpQFOgIOQVt+0AFzzoLp
	hoM96a3iumvH4VBC3MFVTZLwEfeE2a+X/PmbOMm+MxFVyoVTXyFIbRI5ml60WbnrSTk9fE
	XRSdFWALyZjAvhUStOI3usIPGtyqlDP+YRwKQLormJr/M5XScdLgnlyaDDsc+cjAEMC0i3
	TvTfkDteXC4y0QHSY52fpwSYUrt89N0/LQlidEgORqWZgk+SNY+jXVYlYQTvB4gGi5jJAm
	8JDH7WkXzf5a4WOZ2522hDkUt7Xvy/LrsYcZF2jyceFmDS6sEKLNdActGpbqTQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1719138650; a=rsa-sha256;
	cv=none;
	b=n/u+r+GVC/sMJN3Agkbn54BwORQgxQTedIqM0gOJiis1ow/aUhF6fBTD0SJWwjew216y6n
	hAISovVNZdb4GFmLYzHGJoLB7DqRSYlyRVHxwwM0arDCGjcmgJ7iHsWpfgV/SYsbHVMYgs
	z23r9zAOyzLMhPqfdHVmM11BHAT/khcMXGdcffHuIX2jRF2D2mDQTClYS/dlG24d2SG5cR
	fS0f5cYtZD8QBRKOwV+EvrBMyi60eUjHEgZywcbJ3/rdCbgMwkYp45JOE4NO7irgArMpiT
	0WEudGc2QcYtOSGyltmK754UHcpm/XP4W+fGl9GHOGkSCeFgt8ILEhxWgXJi7A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1719138650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=77DpmaX65YJ5tBxvrHzr3R+vVPbzThoESe+OM9vHJvE=;
	b=stPjwxCL9AGkMrhTc18+eTS/ouG4HOMP6zllGKmVKO5ylj2pzuCqq5GNqkvh4j2P6jH1WU
	6ev0zGTt5BXdKheQjAu71PmBKLavrJSBya2TDOq+PhWPPqPSPxwymB7m3N+jBZYklur4Rc
	gWCvGiwt/bkTodSAp43BBizmI0eFu4/bBoIv8EmBVxHtIF281uKDCSk4bc4Zk7A7MAaxMF
	ZkmYy79X8BSCzYXiDsfYoI4qtOy0ybUGU/Nsy75X0NTvC/3DLeIYKxzSuAEO2GFWZ4yotl
	kJKIBs0dLjiaEmPMjKpXdOLF9JPPOCQh9iSQDGJCWAseKx2K27+3ZE1/52dc7w==
Message-ID: <181de5a745458f349b93b05a51438d3608046c49.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: fix double free in hci_req_sync_complete
From: Pauli Virtanen <pav@iki.fi>
To: Edward Adam Davis <eadavis@qq.com>, 
	syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date: Sun, 23 Jun 2024 13:30:50 +0300
In-Reply-To: <tencent_70F452CB86430990EEC56EEB4CBB27D40606@qq.com>
References: <00000000000033a6e8061b3c6d4a@google.com>
	 <tencent_70F452CB86430990EEC56EEB4CBB27D40606@qq.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

su, 2024-06-23 kello 17:06 +0800, Edward Adam Davis kirjoitti:
> Look at the following situation:
>=20
> cpu1                       cpu2
> =3D=3D=3D=3D                       =3D=3D=3D=3D
>                            sock_ioctl
>                            sock_do_ioctl
>                            hci_sock_ioctl
> hci_rx_work                hci_dev_cmd
> hci_event_packet           hci_req_sync
> req_complete_skb           __hci_req_sync
> hci_req_sync_complete
>=20
> If hci_rx_work executes before __hci_req_sync releases req_skb, everythin=
g
> is normal, otherwise it will result in double free of req_skb.
>=20
> Adding NULL check of req_skb before releasing it can avoid double free.

Do you understand why?

kfree_skb(NULL) is allowed, so this is logically a no-op.

Probably it perturbs the timings so syzkaller repro no longer hits the
race window, ie doesn't fix the issue.

> Fixes: 45d355a926ab ("Bluetooth: Fix memory leak in hci_req_sync_complete=
()")
> Reported-and-tested-by: syzbot+35ebc808442df6420eae@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D35ebc808442df6420eae
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/bluetooth/hci_request.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index efea25eb56ce..3862fa6bb288 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -106,7 +106,8 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 r=
esult, u16 opcode,
>  		hdev->req_result =3D result;
>  		hdev->req_status =3D HCI_REQ_DONE;
>  		if (skb) {
> -			kfree_skb(hdev->req_skb);
> +			if (hdev->req_skb)
> +				kfree_skb(hdev->req_skb);
>  			hdev->req_skb =3D skb_get(skb);
>  		}
>  		wake_up_interruptible(&hdev->req_wait_q);

