Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721738F248
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781090; cv=pass; b=YeoMd3GfI3bWBLKT+5LoZr1D605gfbR3HftdPpGBCw7D7KSqTjFbtF1yAib7k3BhBOsYhRCMojAsSVAztop+2fRVwI+eK+vGNyFKbOFRC/w+qX4mzeUa5JYOqpSDmZl8r6K6CyD/OeN7jFUF0Jok+sXWPz59otBrWA0j0ypXeog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781090; c=relaxed/simple;
	bh=oEZTFGT/zsbjhwuKvWnfYPy3McEOR01XWhw4l9V3p8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFYTY+8reKmPXdOda720LVliyNxx8sIDS3RfHE3jL8tb19C85j29c7jRn5isL08+t20Z8NkA7mCR7gdNC9bj3hvW8zGNd7B08UOaWxa2Rj2/UAdwEk1yc640LVEOs3mtWVcvRM4OBasp7S9+jaHpxdNMPfflpMp2t/6N9i6UebM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYOv8U9k; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYOv8U9k"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-654672a6d68so10396508d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 10:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778781088; cv=none;
        d=google.com; s=arc-20240605;
        b=gJV4Nx6NgjhOxqsppROqPeGYheVNFn1ZS63MIm1OeKthbLttT7nzrV3pJ/+TJB90Gx
         wHTXe2heMg2xAyzmOhT4aQILsp5QcWJIS2ETj8rg+qcPH50Otj0nKPcETBvCFyG0Aak+
         Y6P0Sf9scRdvEa/QWS3dq/8rB/uCeCMaEMzuvbvaW+/uhUjqccr952QozJ9k2NNYrQe3
         dn85x1NdisfHUC7hGZn5Vhk/p1bmXiYBZ7Rdj8tmsULuCG82pESU3Jg23GpF3+DjPwg7
         37U/kiI65SJvlTsdvdKYSiDoRVam9dw6PHmnQUCyuyOvzCxg9k4+BODzK/wlum0kiahc
         n4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6wDiBZDMexEMEADEYdo6MQjjkOCysVPN+9Ft5KwrZRw=;
        fh=RUMbgXZfLkgavLFAdeupeFdakNnzHpxScAyrkAfP+aM=;
        b=hY74E1m+aINzwA/IHEKa8a/1w6Ajx+9rP2vGlNheCCwpNFf9FlRkTpCagVcb5iIGMM
         I59HVPsb9jhaXlBK37lMlL1WKZNbXm34ugM46ZxQ5lUMe9ywgcLv4q6HBamRQ6GsAW7O
         gFQzkaxnQCQut6vOPmqOVJdeiwa4rQgpG2gNyJ0egc1zeOnTMIw5GdrBNFsBaZ8caBJC
         qWCPgVhcc3RsSENI1/bW5ZWngayUq4SG+vQu94BZtAJQ3otZiws82NIgv27UIHkio/mo
         sjzygbmtOZGDu6q7Erjk/jAzL2q7ixGKTITxDKWU1ohIEvt+4IFC5Lz2xZA0Wq0MvRZF
         sZJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778781088; x=1779385888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wDiBZDMexEMEADEYdo6MQjjkOCysVPN+9Ft5KwrZRw=;
        b=WYOv8U9kRDVZWcHQGhZunhQgkMDOaeuANoqDV6EQmSWDBtReTLpolS3t154WTR3lb2
         8NHD5SZKRdBYk3aFv2Qzejs54BC99AnBhyuZeD6Yeq+MU/icS/UV5gOx7Tyhq8vt8AXk
         qkmmT5IUG6o1/2peFbqHZ2H6SvC1BAqQgodC9Bd0OPUPMB7peIvD9/51aUCwAGGa1Lnu
         lQB188mz52MAGzutTME0f9eJWFkWGZ5QFTKJp9bM0vvnHLNxa9H2lDODY+IX/Y/Bge/k
         fN8PZ9DTmWmWQeZvrpqDKjtzOxnYou5pMYmESdR1k3p9HBA7B+rnsRTvPiQvxOWdvKVd
         5cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778781088; x=1779385888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wDiBZDMexEMEADEYdo6MQjjkOCysVPN+9Ft5KwrZRw=;
        b=o9CtXSVxDkyHbVGJ9xqXU7Ah+hHoJqe6YKaDZXTrN83twqME2V/ywytUKRHH0rnWNm
         SaFC+Ze+YPRh9XHsW0suPXmcB0TbNNOvE61ba+AEGL73DWiGVkvyfovqD61QF/lpr1Kc
         sJ/lb6GicD8v8dfOtB5oRnpEcjQRVvHLuiSvcFij1xRkWJtd93Y+r9K8Eu/0HvGJUKWc
         225EuR0vP5UgO5Xyf9K2jAWluYpQwM9o3YSQZ3otjP7HyAi67JRrq8HASvQBYoJSEOoL
         EtfUSUEaxpNluNMiugcyQ+Z7nxoGbsLgZzEAAjOfhZMIJDcXKLFTIqE0G85jPlivwm2o
         6LXg==
X-Forwarded-Encrypted: i=1; AFNElJ+/t9rvr8GlETFVZDFJeQZx8bxqinoImLlBWTbuSWS/x4LZ1ssuvskkLI0crTiNfSg+SVAoaNiRZ5OSdtOF/EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLi9KiHdcEujpCksc8R7sbqiYqSOdMQxgn0mqFSL1vb6dpTaSU
	VJ6wAfxRU6TJl06Wbk91zV+eoDFdBdEzMIJTWlWAJWF2vzEjnqbaXfrTfXAW6l2Yr8YU3FSKq4C
	0ZL9vYOc3X7klXu0zPOUgaJDCSG6c+Ro=
X-Gm-Gg: Acq92OG0dvOR9aut9A+UOYm1dTNN0s+WA/d1t/PkV7YwLpeCFWu7xfLU7/87e0ROXay
	OehQZcF8+N72ej80RNml6s4kf/YokMnW2hCWdtAuJMgvBVxN0jbRyvIlgDD+vKhnk6em5R/v58h
	Easbme4itMkxm4Yfxm7M2gqE3xn0t+OJ3frqOrK/XElU31Jp5wNC7BAniYcclwKHuk53vP52yVA
	MQKuLUi7jBF6xHksmVI55Bkra2HNvPrN1LT6xbitekKDMZ8ji/jUDCizd6D8a1g6kWuNuKFKK5e
	PYu3jOsUZnv0NFCmR2QFjSl0Sxikn2qn1kgWpog1PuRCgqlbC4J/dESj9JC4qEIbSJ/XeFdsHz6
	bN3IW
X-Received: by 2002:a53:c049:0:10b0:651:c047:f09c with SMTP id
 956f58d0204a3-65e227d52f7mr245379d50.39.1778781087600; Thu, 14 May 2026
 10:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
In-Reply-To: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 May 2026 13:51:16 -0400
X-Gm-Features: AVHnY4LxOXAY7x1GGPoD-ZrWMAi2sQqAU3A0fF7icss2dq6JW-g14LN3XOF-d6E
Message-ID: <CABBYNZ+nvtMHcU9but5VEG891vyO=K0MF3OAGofANxzdLVmw-g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/6] Bluetooth: convert remaining bluetooth
 socket families to getsockopt_iter
To: Breno Leitao <leitao@debian.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Breno,

On Tue, May 12, 2026 at 7:12=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Continue the conversion to .getsockopt_iter for the Bluetooth socket
> families: hci_sock, ISO, RFCOMM, SCO and L2CAP. The first patch is a
> small precursor that fixes a long-standing 1-byte put_user write in
> hci_sock_getsockopt_old() so the subsequent conversion stays mechanical.
>
> The riskiest change in this series is the SCO BT_CODEC conversion: it
> is the only one that drops an open-coded ptr cursor in favour of
> relying on iter_out advancing naturally on every copy_to_iter() call.
> Every other socket option is a near-mechanical s/copy_to_user/
> copy_to_iter/ rewrite, but BT_CODEC walks a variable-length list of
> codecs + capabilities and previously tracked its own write offset by
> hand. Getting the cursor semantics wrong here would silently truncate
> or misalign user-visible codec data.
>
> For more context about the motivation for this change, please check
> commit 67fab22a7ad ("net: add getsockopt_iter callback to proto_ops")
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - rebase the tree on top of bluetooth-next.
> - Remove the selftest, which was mixing network and bluetooth together.
> - Link to v1: https://patch.msgid.link/20260511-getsock_three-v1-0-1461fa=
8786ab@debian.org
>
> To: Marcel Holtmann <marcel@holtmann.org>
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
> Breno Leitao (6):
>       Bluetooth: hci_sock: write the full optval for getsockopt
>       Bluetooth: hci_sock: convert to getsockopt_iter
>       Bluetooth: ISO: convert to getsockopt_iter
>       Bluetooth: RFCOMM: convert to getsockopt_iter
>       Bluetooth: L2CAP: convert to getsockopt_iter
>       Bluetooth: SCO: convert to getsockopt_iter
>
>  net/bluetooth/hci_sock.c    | 26 +++++++++++--------
>  net/bluetooth/iso.c         | 27 ++++++++++----------
>  net/bluetooth/l2cap_sock.c  | 61 +++++++++++++++++++++++++++------------=
------
>  net/bluetooth/rfcomm/sock.c | 30 ++++++++++++----------
>  net/bluetooth/sco.c         | 59 ++++++++++++++++++++++-----------------=
----
>  5 files changed, 114 insertions(+), 89 deletions(-)
> ---
> base-commit: c2f0079e8c42fd6814c8d6b1491e3ce0a0e3b3fa
> change-id: 20260511-getsock_three-d0d7f1b2629e
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>

There are some comments from sashiko on this:

https://sashiko.dev/#/patchset/20260512-getsock_three-v2-0-30b7b22ef14c%40d=
ebian.org

Now Im not sure the truncating is actually used by our tools, but that
sounds like it could break userspace if we don't check properly, or
have you already done this for other socket families and it was
considered to be ok?

--=20
Luiz Augusto von Dentz
