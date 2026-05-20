Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4C36AB6B
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308996; cv=pass; b=Ng3wyhEUiDsQ5rhfNgq3MFvjaIGdpEtSdn4azFgsb7L6f5IMd+kqs32ZvbpmUn6WYKDcf21oK0pxMl3Y+qijTYKRe7n7tB2AhhGqMHMsvEgRyWdtXAYmsBeMHtRzKNlMwEuwD/tJXEx0C21XMSXUgLVas8vJpHZIiFGjR1KkwnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308996; c=relaxed/simple;
	bh=2mdEwhE24eABiRfThApzhuU+jeBd9xCPHcbXwXI56Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9KZMtp+9hlP6a+NV+C0eDo5pSbMv1/VkAYuuQr7eWfLXkliCpjNloaQMEcSkl2jS6kIJwOwd+soJYk8sY6MJowiVPBv8bIDS2eP86MV5TUrrVTWg281tMolIwkte9YLiSuoOQQIaqkQrV5AoT3t5XkTseXfNZEqAdZ68ic1zuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8J7pVIe; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8J7pVIe"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651bc83e74aso5621903d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 13:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779308994; cv=none;
        d=google.com; s=arc-20240605;
        b=W87ILMa1MJhvLAX2MIrVy+vVjWTnzw4ytw/bnRNWHt9dVpPdwqNixnTeKN/LvfeqYD
         BfqnZV9SDcR48PFAITuvSQVYSXUsfEpohjcyyEDjEN0ndMVFEfUUWParMVMPcRuYl0zg
         7+QeoSv5Hppb8qZZQ6GHn+ukmX6TJYbU+WP0ZkYVizYXNmaAFIGFzfHbO6sirIW9+Biu
         xBO5DLGqMII3Gepq3DQiI6WdobHCCi3dC3rFjAepH+EB92LuG2SyZXXvYvud45/G0Qxh
         Ok/oqwi0T2A7dMOurbrUAsEh9FWmOlI8Xza2rnLDdBbjGTbXy/IovrR6t9xe1Wm2Zsux
         zZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ws+sa0HClBYmuVw+xadI1X6F1+ae3DzkcGPRrOSQ5jM=;
        fh=WyGbZN+bnrXzvClJBfLKA43rKxND9ipaPttcd6dy+mQ=;
        b=a0tCim+WAdXA+B+HVGdBF7aG3IT/wr4umbIuKnMfraKZAO3+fZ//e/t5X9grKA7rGb
         H1x/tOtCyfh/J8ziio7pXs0pnZR1xJNHiaio3R/bfWPLhb2h7XoBb8yHs2942WEcHKl/
         imJkZBF4GWJO/tg+ke+e3Tzd8WnN7zZJA3Cz1/wkLw5aA2wbH54WwNeHVVdrdhw/j0dB
         2dYiN40JKOt/TNe3zIJS0G9a1YthLuNUbyIn+bVo/DZ+N0fOzwwQ1kyc8HwX58MJSVVL
         KySWp7dMdAXuWkjmnTGjioJvgFmAk/MjnGHzJNjk69oVmhGykYm177629I1QxbqDe3n6
         LA1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779308994; x=1779913794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws+sa0HClBYmuVw+xadI1X6F1+ae3DzkcGPRrOSQ5jM=;
        b=U8J7pVIeZ0SZh4XnCoGUHL8kqYdoXp+Qr/eMPo9w6Ok54e0yvuRFDUlE6TSmTbVTBu
         4vgdAWdkbfva7YQ6OQzNUb2gELp9/0AEawY0lkumV56Hj/8j+M2djCPmrAmbOaMsYKuu
         dovxA9xeWLowPNjxeFHfQEsGJ7hzU3Sekm7dhR7JZeVBF2ZN59IAIb+/h60MkUJRB34k
         0bbzJzgfDCVG5acnvh6NQatON9KZrddqqNYDSRMICsFcaY1BSeuzv2iVRUcBDr5Uq1ZI
         aJtyknPIiA+uPj3B6YTqBCYXGcH6svamspNzYNBboK7RQB1Scv9rAuDW5A8nynqEXhoI
         P8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308994; x=1779913794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ws+sa0HClBYmuVw+xadI1X6F1+ae3DzkcGPRrOSQ5jM=;
        b=cOWVpTZexf7BZLnaLkwfV5B5L9aUzNZ9X3kQeEhezWSTh2nIPNfOudwnd6IXn9jEDd
         SbKI25vt7Dvol1k+i3eUByCV0i+rO0fqJgQ4mEPCMhNVyxZZ5U4UQBF25TkrBiY02NrB
         NqKalq0tfJsu7gWd0pLJJvTS7/Zr4McWNzTDT+fM4oalo6x4IEOrKhMeFl10QnI3utSn
         dKkk9zA064Ry85wGC2hPx2MzfmEqZF+FeOzwcFc8eH+9tWdnMQLWhshcYg00n7SsOsw9
         1IfmB1VWI3qo5qpJhhHwkP2CwimSzbENvAOCgAn8FBOMcQ1c2Wntwx7ChZMk7M8KDcSs
         N8NQ==
X-Gm-Message-State: AOJu0Yy81QAkRDyLQCxf89BnJ5bZK3xs/HWEe6F58SwtJGCiNEL1h79b
	bKbk0GNBp1UML/gE/YFm3ONcnjO0et8nyn18BpS1tYiNzqaUcE7xiKRdXCbggmHgElAWS3YzxVt
	x5OkbsySIGTq2nmyXFoNLsSPunUHx3F4iRqTGRoI=
X-Gm-Gg: Acq92OEQ10Nzc8+F1H1sp2mC36n+h95mZAX4QNP9nnC//kbhankp0ZjAbdIKBF4p4Ai
	+EB/n7uFUBRVD9R0PrZfj19C6OVsI3hme0Zbx7wK9LAMgxOJVpsFpHR0W2Nwsk5dBh42bomZoob
	Gg+vIt+rUcNXN7DEiQOxC9XE4hjIqBFWkIRl50fP0XW0h8yb/gOo+WiC1+sITCWF5pO3YIgXKQ3
	ohFAzYQJjI6JLULzrOj0oXwl1UWJyLG0IG2UZvCsaf5NZBktw9TKn5ARqeGriPcAxd08y7AXCnC
	UCexKIRS8i1WRR00dF7ABspD+TxjjSFhmGIBx9YPEsTnMM0GyL5z0qgaU+XuQxMXXmunzA==
X-Received: by 2002:a05:690e:1589:20b0:64a:ce9a:ace2 with SMTP id
 956f58d0204a3-65e228a2c9amr21082573d50.56.1779308993693; Wed, 20 May 2026
 13:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516181504.3076260-1-safa.karakus@secunnix.com> <20260520200611.3033410-1-oss@fourdim.xyz>
In-Reply-To: <20260520200611.3033410-1-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 16:29:42 -0400
X-Gm-Features: AVHnY4KMuvWdpmpM56Pu18YgWCfyzyGBUIJd9SAsA-NcEhvdrWQaxJ3T0X-7F60
Message-ID: <CABBYNZJiCTJrde9rYT=NQAk_RUv=ugeAUPnRg6vsjvU5hW4NqQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org, safa.karakus@secunnix.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Wed, May 20, 2026 at 4:06=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> wrote=
:
>
> l2cap_chan_close() removes the channel from conn->chan_l, which
> must be done under conn->lock.  cleanup_listen() runs under the
> parent sk_lock, so acquiring conn->lock would invert the
> established conn->lock -> chan->lock -> sk_lock order.
>
> Instead of calling l2cap_chan_close() directly, schedule
> l2cap_chan_timeout with delay 0 to close the channel
> asynchronously.  The timeout handler already acquires conn->lock
> and chan->lock in the correct order.
>
> The timer is only armed when chan->conn is still set: if it is
> already NULL, l2cap_conn_del() has already processed this channel
> (l2cap_chan_del + l2cap_sock_teardown_cb + l2cap_sock_close_cb),
> so there is nothing left to do.  If l2cap_conn_del() races in
> after the timer is armed, __clear_chan_timer() inside
> l2cap_chan_del() cancels it; if the timer has already fired, the
> handler returns harmlessly because chan->conn was cleared.
>
> Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  net/bluetooth/l2cap_sock.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 4ed745a9c2cf..025329636353 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1512,6 +1512,10 @@ static void l2cap_sock_cleanup_listen(struct sock =
*parent)
>          * pin it (hold_unless_zero() additionally skips a chan already p=
ast
>          * its last reference).  We then drop the sk lock before taking
>          * chan->lock, so sk and chan locks are never held together.
> +        *
> +        * Since we cannot call l2cap_chan_close() without conn->lock,
> +        * schedule l2cap_chan_timeout to close the channel; it already
> +        * acquires conn->lock -> chan->lock in the correct order.
>          */
>         while ((sk =3D bt_accept_dequeue(parent, NULL))) {
>                 struct l2cap_chan *chan;
> @@ -1529,14 +1533,12 @@ static void l2cap_sock_cleanup_listen(struct sock=
 *parent)
>                        state_to_string(chan->state));
>
>                 l2cap_chan_lock(chan);
> -               __clear_chan_timer(chan);
> -               l2cap_chan_close(chan, ECONNRESET);
> -               /* l2cap_conn_del() may already have killed this socket
> -                * (it sets SOCK_DEAD); skip the duplicate to avoid a
> -                * double sock_put()/l2cap_chan_put().
> +               /* Since we cannot call l2cap_chan_close() without
> +                * conn->lock, schedule its timer to trigger the close
> +                * and cleanup of this channel.
>                  */
> -               if (!sock_flag(sk, SOCK_DEAD))
> -                       l2cap_sock_kill(sk);
> +               if (chan->conn)
> +                       __set_chan_timer(chan, 0);

Great that seems a lot easier to understand than the previous changes.
I just don't quite follow why you are removing SOCK_DEAD handling with
this?

>                 l2cap_chan_unlock(chan);
>
>                 l2cap_chan_put(chan);
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
