Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FBF31F9BC
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099391; cv=pass; b=cEi3iLGqVlSiq6LxsPen95n563zDBZO+6KbFbZR7Ukx86qzzVCsmP0M8Tx+U4Ez/uf3KeI/iDdWIDr0/dNAHj8IGM3QVC996b/DGMnA7bx4DaQ7e6ie4ZH+A03QP6P7zyHeYVnveXKp3YrEORUX8gO9FrDQIdO5KxwhKFkZ5dDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099391; c=relaxed/simple;
	bh=FxnSOEw19bqu0jl8B0qdVxKvM8S1LocoG7aLZOEUjzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K37LfhFbx1Un3pLMUhSEaA9jTejLqJzYYwTIcj95BnYubLkVVLSvT/o33ehrFv9Wo2PkIb3FR81mzPqqB0YIeW1U7tR+JKjCqRgl3caHGcYanXS3OoeIe0Mfx6JBS3FWhOkGsqRG4e8YMmp0hwgXObJwh22w/yF9m/n8QTuqSR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzuLSUMm; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzuLSUMm"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649278a69c5so3625586d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 09:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776099389; cv=none;
        d=google.com; s=arc-20240605;
        b=M2tg0URcloLTq1kRCfag0eup8yBD3RgDugxOVkSP3yc5t3dz9JTj1sPLbvbA+m8kUZ
         CMos/oD1MMqPF79c8R6WqUhYYdEq6KTv/CfYiLjWVn1DP6W5zgeby6CqCa8UaZ1RlkNy
         j55Ir13tJtKfCVf2h8faV5IgPItqCVs3iN7OnXW5WPFdfkBeZReKaHcIgbBANS7qh8DM
         +knN1KBB8VlxJu13B5yJku4cSmvI0DII4Qd6F6qv6Ckdg/XS6CU1lTMZOEJKkbn68TLN
         m9W2sctDzIb0EqDWsI97hH6mZrHexT+vNwscEtoedp9B2bIglODEzVPYaOFajgPS/qt4
         Gvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xRYG30d6kci8lXtdFl5ZkoQb0cJVAQ4RGWyk0+fFRPw=;
        fh=PeOzssJ/43VGRrnsaH8Dm/FjC3UjwiDRNKAn3gtAkUw=;
        b=kQGe1XRTCZ0o70rf+1XlzrfOBfFGozWOkKmVZpOjK3DjsuOy3rHDCy2UU3ojIUJA4w
         sX0nFVcCOBaqMMQjTWXa+tYi0qhXFW1VTC+fuNoTBJlH3morhKHQNxWh8kbkofWm59Rs
         U4v8/bVwf4eDhwI4jSKHZu04jBX4xXMUeuZDhm+5wMxLPctzj6/3xqlZK6kAgtRuUA2M
         mZ1/cvnqwa+WtMMLLeHaC2pEyV5Yc5BnKOCv2uWPuCAXb5LS1iPVXkqUq+sC1uO3PPyM
         qSAF+H/iQk0SOUAUqgFcTZFyB0e76i/YfAVuhv/4zxBIgBEEQi9EaE4CBw7mp+zluVMU
         9u1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776099389; x=1776704189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRYG30d6kci8lXtdFl5ZkoQb0cJVAQ4RGWyk0+fFRPw=;
        b=BzuLSUMmG/EpmOFLJMUS0rWUdmAPAUOFOUwFfw9TkCgeX4ue80EOXJdzUpsh44uMKw
         n5S3nop0fbk9N90zspvJ/jwBIeWIRukqcFDg59HhztdxB5vtTXut/S7zSURoL/eTZIKl
         mIv+hOSs3Drzl4fjg9ucDkDdXORJ51mbuvk+usjr6i1hfpWTa6qDt0maXn/+QHJyRmUQ
         kV22C2RJ63esGjs/hbN1fWMYMKxMGwtL3u6TIqepVYJrazkCeUI7tsDgvEd+67vlGptl
         dXB3YMaae6vPc6sdIfeeTsN0UPAIY/mlVaUzMjfM2hSiwWhpuUGMBnffDUwnWX0Fp1HE
         I0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776099389; x=1776704189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRYG30d6kci8lXtdFl5ZkoQb0cJVAQ4RGWyk0+fFRPw=;
        b=G01+FHEl+Y83sLmCwmozyL+NjINAiwYfhyql7vH7JNm0WBGQJAN7LhtCahp2HpqG3r
         wONsm8x9JHcAjsxvMVzW9N26PZ+P+A5XgsCum3DvF06xa/w+/tuO42FAAHP/ygmw0GXM
         Nt80o4BcPnrR9L6vJU985JgD5k1vIJxkuxCLnAbs08g+uM0V7Fvcb9hpTu+SKijTnC2m
         JXWBVMvCPD8tyRlFUehsDyBMKyosP51jyUoLh76v+T54SqRTpGQVIH97hXBA1YonrEoL
         3QGwXSEm8CFD1RD+Yi+S3Bfq8tbK89pwpYCl+R5AzuXT97x9Qq6bcokWlaWjt4JAjwKj
         StMA==
X-Gm-Message-State: AOJu0Yzg0onAMXlXWxjGxhh9MIrxxLfQapGwL6HUJeN++3T6m8Ed1zYr
	yuQj62jmadbQZJHBVU4LiwdlfBH1gFVSoLXJYMDePOBBgvjZV68cDtJSFi5+ERLDIAnB47rG0DZ
	t0BFiJT3wbMtg5qKVH9hmRlNk4SxgHK4=
X-Gm-Gg: AeBDieuH6md+GgwAytCd/ZE99XjJlAE/cU07mT1JRLEJB/Kn4dknAU59xokztNVZT1k
	o4Ld5SuIRE0Vu/ejN9AA9bljzNOJOQaPRdhzX/9Wbr7zZgw3MzBIezeYDZRboeVZaTaCLfhkX2W
	aowF/tVf7RMs9mt/ZYXvaUp0mNDGe5heK7Kjw66/y1i64ZBgLEzckOAXG5DGsMSkPaKNlhWdZV4
	bRWEtq4ZVClJ1PakrSoYmonktUmHwO8xMvYPhX0SRFqiK2RMR75DPx4qHa+ivj80vCbADq+UPSA
	r/UO4sTn/fnwRaCRJomUc43kvb7Z7vKiHjFqTGlhJLYzJOqaDpIOUMnJiCbjRbu6SG8mcA==
X-Received: by 2002:a05:690e:4089:b0:651:baf0:f49c with SMTP id
 956f58d0204a3-651baf1083dmr7063357d50.50.1776099388833; Mon, 13 Apr 2026
 09:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413085455.74585-1-phx0fer@gmail.com>
In-Reply-To: <20260413085455.74585-1-phx0fer@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 12:56:17 -0400
X-Gm-Features: AQROBzB-2I2yJIcPd3D-QDtNTAUMuM3_NIhUTYRqllnW55_mHgRXYsu6aBjVo40
Message-ID: <CABBYNZJnbVztLcUA49CQmNHd_ScMwZkgiLKXForVYygHPD93mQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: Use disable_delayed_work_sync for le_conn_timeout
To: Dudu Lu <phx0fer@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dudu,

On Mon, Apr 13, 2026 at 4:55=E2=80=AFAM Dudu Lu <phx0fer@gmail.com> wrote:
>
> In hci_conn_del(), the LE_LINK case cancels le_conn_timeout using
> cancel_delayed_work(), which is non-synchronous. This means the timeout
> handler could still be running after the connection is freed, leading to
> a use-after-free.
>
> The other three delayed works in the same function (disc_work,
> auto_accept_work, idle_work) already use disable_delayed_work_sync().
> Change le_conn_timeout to use disable_delayed_work_sync() as well for
> consistency and correctness.
>
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
>  net/bluetooth/hci_conn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index e6393f17576b..6e96a8aeebd3 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1201,7 +1201,7 @@ void hci_conn_del(struct hci_conn *conn)
>                         hdev->acl_cnt +=3D conn->sent;
>                 break;
>         case LE_LINK:
> -               cancel_delayed_work(&conn->le_conn_timeout);
> +               disable_delayed_work_sync(&conn->le_conn_timeout);

Why the change to use _sync though, afaik that can cause problems as
pointed by sashiko:

https://sashiko.dev/#/patchset/20260413085455.74585-1-phx0fer%40gmail.com

>
>                 if (hdev->le_pkts) {
>                         if (!hci_conn_num(hdev, LE_LINK) ||
> --
> 2.39.3 (Apple Git-145)
>


--=20
Luiz Augusto von Dentz
