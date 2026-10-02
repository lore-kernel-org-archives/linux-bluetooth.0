Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26653E7BBF
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951398; cv=pass; b=FTsj+Nrp/sV5RVJNMFAJYwkJfEw+PUT5auzow2Oa2ncO44caWZ0jpDL8Kg2+RzkUNbwBMJdtT/Yqu/yGn0RFiAn6rKNNwaCoIENlJqxn8KB5Dokvh2+PUYtwoM1+iTTN6Pmx38n5WLsPiZID3UQ/cmRQuSbJVNcNPgzZHJ5mM6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951398; c=relaxed/simple;
	bh=io50RMJRq8kMNTY6x4RzSPCnFg9pRe+r5uIs18DFLyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQqoCOUVtBzuF40hwdvucbcta0B6GnVoXKePanyUqCxXz8YeeAaawNY1NXjs8X386zpVGR/7ICKxHxew3lVEo9xLrPvTGVOdWTH0RVG8xL20G2pK3I7aC1ufiGOG31VWWjaaZfkuFxOc3stJj/zl+MvejSJzzSLhr3sEF12ci9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS43CG18; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS43CG18"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8ab4c9f876bso34002027b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 07:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790951396; cv=none;
        d=google.com; s=arc-20260327;
        b=cFp3qaCF5R9HQ2TR2MxlJeIA9KnZPIxfUv0YfuZfa1W+0Pj3CymJVrzrII4Q3XouIQ
         jakkKfvauMwYynzOR5SkkFZK9WWdWPHpTRAUFbTHNo1H/IRTU4oVQlLLiAm+r4/Ueh99
         gj0wqyfwUOZmXfQfDU4EPMNF/2GsGHqlS0/jOWzulEqRmnCADj1ufUvbFnPxEcWZfIkz
         vwhcJTfEM4kdejpqkpESjIl8ieAqHsHFsZFaSP3xj1mKMAArbNulz3P/tlADJ2yhsc42
         cjmE8T3dbyd43vyiQIAKacqC4EOSMlWwPyTxz/ZqJUFO33O6d6uy34Bk+OMW2NPDuf3C
         a5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g/tE/tvsCifvw14iAE/uOH4Wly5U40GqNSztDVfOLO8=;
        fh=bskfUyQCKktHRabaAiYDoc6UfBEVjKJrXAq+81X107w=;
        b=BTNG7KhUxN/WmqYtt9YYMC2NhooamSpnnuW8AqME0WFDFpH6fcrSFCFehvIQ+2m6rP
         jr8EYcVjY0WCm339VX0rU95SuTBlXq+bkdjQPu9JHYj461JEyOfbpwVw5jh1eA0u2hTy
         9RsjVk4zn5kpCQuHKXlWuotD3t+6YrWdTv6PLjWVzzzz6LruATobJ0310PKOLIuY432t
         YMoVwdGuyBTul07742zPekWJkkw+A/ydLDpuXh6/LLU6DY1Ow/z7GakKrGiJ2VHsV3qS
         af4HbRKR41N4VMk2Q/59p2Wbg27emyz/Bu85q/MPwbwt/kVKfjSItvfGYZYGXiI3kJeH
         e5kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790951396; x=1791556196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g/tE/tvsCifvw14iAE/uOH4Wly5U40GqNSztDVfOLO8=;
        b=XS43CG18makHNsvzJhbbY6dC2q5X+dW3ZUU3dNLb/4zVvauPoFVRvxJh1ii+SPZiOE
         c7Og7KZTA2JLS50iOKkpb5kaPdewgw8S/xRG6/8DsUBWpbY4OmSlG7J2eU36XNRg7FKi
         5qRK1jfhHGNRNbb7HbImNA5av4KVPecAsPr8ZziIl9wYOuKJOrBJ6vXTqDotlcOVOHNb
         LI01wj7M0DQS99WY3ErXSIde4YIoZNvuL0/mdaGFFM2j5zsLc6sK1q/vL2gPku7PCJTL
         bQkVbiV2A7FPQ0JIyygK6GKlvrjmAlc3cz3i0icx6dZ7Yo/zbDTtLNYyiRRGcIc9zJXF
         eIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951396; x=1791556196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/tE/tvsCifvw14iAE/uOH4Wly5U40GqNSztDVfOLO8=;
        b=phx76FcU2G8Yv5Pa+dq6DYWMU4nETmAe1IDsWiheldO79s3RT+RKsZccEkbJyF3jI9
         qTWkSph9Uw1191tk5wczHZ8n9/JOs1ieUsyKNXwBcVJO8UOYUETYVLDXrKVHyD+HkAwc
         rDGTj0l1t64WxJ8+wMoia+MbI0dTSBM6AwRSmuFzwCi76TqtW1FLBpvzHkBKFll9uRhP
         H4jGZvV6Q/XGidjrohVdGyQxhSbPqZSy1uDPWIorSQQnHXAJ2X4iI+2ZXLCPwJBMXfyQ
         nf4gnphHdJDuFHXN/w/k9MJj/0LQU556Tdj/6UCHCYyHY3rX/rvELVDRATYJOdv2rQlm
         YY2A==
X-Forwarded-Encrypted: i=1; AKwUvByoQjJ2Lp2tYgc1zWe6xyhc1OPvgAJtH38PWoc6xNhMgpMDyPAH7mSPwaSpp3wm9wy7fTWPGFOsZsmLzn94Kio=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLt7RZvc5BifocESJwqzv027k2/FeL5Q51hnnT30/9w47C+o4F
	10eMHyM6+mUVYAfFNadCPO40o3OtsMIYRumauW41EKhpwlgyq3UQAncbDKhHw/VhLXMu+nyoLVr
	xQaQs8PHv8dB5j8XS8nfxvOT2yiD9K10=
X-Gm-Gg: AYBFou05mTriaXitWeJ7FbofK14iPdJJSC1iNflXADnU3564C5fYwsN9J4BEqrIzkvO
	s0PgQpebA31+8rtICmd994bEm3i/oYH0rRDSLq+9+wOTIzPkpQ040qzQ1sgvAhHjiBoSPKMSrQS
	gu6F1aw4CMjxEbRDCCZaGoIi0gZfL/PODHHOYTffzv9P1GYpmdNDsQOeDu+dedX1s9u499QOnre
	CLjnAPaWRn/Pp2vphoMPDrF654BSYbeaMUDIJTtDWHDqJS7vir/PySVJ9KqAj+l2GIYQO41gV78
	Hd7TXxC3uuZyFEmjM0nT6LWpRnTJ/hqv+lYdcNlso69eq3r3uMFskxtCAua3nCtNISj044Zs9To
	TD6GJ44PJVhtwJR4t10uKa1k5LfunAxxejuCOvo0G5Xz3iYSQcr10cw==
X-Received: by 2002:a05:690c:f08:b0:8a1:5df0:572b with SMTP id
 00721157ae682-8ae33de6f73mr13963267b3.0.1790951395613; Fri, 02 Oct 2026
 07:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002044810.80340-1-rabindrameher116@gmail.com>
In-Reply-To: <20261002044810.80340-1-rabindrameher116@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 2 Oct 2026 10:29:43 -0400
X-Gm-Features: AclHuK_JcE9p_2GSBbyCDdnmKoq_lMYswbDb6AU2DzdF7xezcBRpRXv2S8bdH6c
Message-ID: <CABBYNZLeHVQjsnjbPn76LVKT1RxSadYPZDqoNY7Lj-zEysU8-A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Cancel cmd_timer before draining workqueue
To: rabindra789 <rabindrameher116@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Pauli Virtanen <pav@iki.fi>, 
	Chengfeng Ye <nicoyip.dev@gmail.com>, linux-bluetooth@vger.kernel.org, 
	syzbot+48fc5b35b350240fd465@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rabindra,

On Fri, Oct 2, 2026 at 12:48=E2=80=AFAM rabindra789 <rabindrameher116@gmail=
.com> wrote:
>
> cmd_timer can expire while hdev->workqueue is being drained,
> causing hci_cmd_timeout to be queued on a draining workqueue.
>
> Cancel cmd_timer before draining the workqueue.
>
> Reported-by: syzbot+48fc5b35b350240fd465@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D48fc5b35b350240fd465
> Fixes: 40b87657200c ("Bluetooth: hci_core: Rework hci_dev_do_reset() to u=
se hci_sync functions")
>
> Signed-off-by: rabindra789 <rabindrameher116@gmail.com>
> ---
>  net/bluetooth/hci_sync.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c01c8b58d9e8..e1c28bffdc15 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5545,6 +5545,8 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>          */
>         hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
>         synchronize_rcu();
> +       /* Explicitly cancel works in case scheduled after setting the fl=
ag. */
> +       cancel_delayed_work_sync(&hdev->cmd_timer);

I'm not following here. If a command is outstanding and times out
while we are draining the queue that should be flagged. Or perhaps the
problem is that hci_cmd_sync_cancel_sync don't actually behave like
hci_cmd_sync_cancel which clears the cmd_timer whenever it cancels the
cmd_sync work:

static void hci_cmd_sync_cancel_work(struct work_struct *work)
{
        struct hci_dev *hdev =3D container_of(work, struct hci_dev,
cmd_sync_cancel_work);

        cancel_delayed_work_sync(&hdev->cmd_timer);
        cancel_delayed_work_sync(&hdev->ncmd_timer);
        atomic_set(&hdev->cmd_cnt, 1);

        wake_up_interruptible(&hdev->req_wait_q);
}

>         if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
>                 disable_delayed_work(&hdev->power_off);
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
