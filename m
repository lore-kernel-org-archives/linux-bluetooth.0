Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10094C14FF
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954683; cv=pass; b=n418gD6zjho5ox1osdz9ahX3SJmMtYQevatGGoAsEniFnGyCMGJzr7yta0h/CGCcrDFta5R06RPCV4rBKJyliZRd2HlGc8mSda9S0j/SPrXnVcsee86V0VKLg0tavy09XPdCKFEYFvnU8a57zj9ExoXa3ecHL3qCWEaEx+SHQq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954683; c=relaxed/simple;
	bh=hx0DJy2oWmaFBsB5CnrlxzEhaxiZx6c3N8sMFYEejaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3sgRXHsCqUk5N53Fjt+0FQ68iH3BXd1N1RJO6SMjFbmFVVUvW7DRIYPsa/3yQ5hjCjg3TpxiKOQV7p+rzMS/N27HB5Z/Vsok6OorJb5tYSgqpWK7i0hndJ2gDianFwD3HQTSOnrI01D4j/B2ZWiRPpIrrHw0wDtYdgo3el7vg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tIcBQC2T; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIcBQC2T"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a87fe69060so68469107b3.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 08:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790954681; cv=none;
        d=google.com; s=arc-20260327;
        b=bZbu92Uh+ksXzCgVLNloPEREVWXGDWwIN02r1vC3q9aRkPjwdzCGgRg96vhTximnoZ
         Fw3SPhTl/wDjj5/6QoGR3myM2DKh1ZGWzAZqS9fAJunZPXynJPbkVnVgfYVfa1z5em6o
         jeN4yreP8iWV1QPiufaArUjkv8xMMJApN8IrtKIucSB/yep8J2wqnJ1ALdvfFQV0XFTm
         W6cU4N6NGUwNzJBRiGAMdHsQBGEnmKeNo65gQnt7bgYWTTUzj812BArGyZNsmVzoj7me
         BvL3G4vf7LM4sxtp3NnBt5Id+HiKB2pHRwBn7owLwdZ3oiqudHgma6qhaNngH3pw294s
         gQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PclhIGNmJDCPCiZNEivoRyEXP1BKISqmsSK8vRcVtGI=;
        fh=XYDkU1TTZTlQiedNyhQBOXJRcm2xFOG4rWZzy7Q8TSk=;
        b=a8vKaNnniHPvlsG7LXNcyWvNROrMmmA1+bZm0fNx0QGhG4kk/mTDZAHYiIRMfOHSPI
         EwFrqGBXVbYXpk9YRhPIc3XOlcSiZxtuygFczfuwp5LZp3AOXN8uTUi8ypHM9tQiXTep
         IopIZwHD4Ye+Ku+rxL5+W9Z6b27mLC0CcJl/4acwxPX3qq+PLCyMNKp5QLFONUIawBip
         +ty0LVkJnhfxVdO9pP+VUi1xBFuF+8+bEsUCwmWFWIX773D2vPZoB9bL2VzyeEDTA479
         HsVd5t3IoBmJ2/7uWZl9C88QCiNv2t8a1/Y0guEM3SQ2tS6I/7gVqojD99GYFZR44KTS
         gLlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790954681; x=1791559481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PclhIGNmJDCPCiZNEivoRyEXP1BKISqmsSK8vRcVtGI=;
        b=tIcBQC2TBFnFAlRnY8lLfdUaNpp9zUkKRZMGuVJ1gDkqi8IiRR5O8DzNRgXD0CCdm6
         GRkZhu/fSsG5quQ5MMvxFy7ibtSkK+9nQwh5R8AmNMrlH1nHqoLsQzcjna2nB6yx/D7U
         M2umH8guWHZL89RVvDL+n3MSQCbdPIs/A5eYLQecft61gHjfE80DOw3VwOHD0TWo+Mkp
         yt+MqCaAj5hAatAdFrUl8c3uVZZ2TguTCL2eQ/dA53f1GIC007+3er2XNMsgNeEzstTY
         sWyKhzuz90cnFBUG2LKOz9SEDwgysPvStl6tDuLmIbgiuYdFFR9iV52M28GjuUq748Fi
         au5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790954681; x=1791559481;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PclhIGNmJDCPCiZNEivoRyEXP1BKISqmsSK8vRcVtGI=;
        b=LhEK+mWxlOqnc/AqKYyB+BpcApnjEaE5R+avKxA8wmZA8v5pPSwL2CKxYjLinGfWIp
         rd5ResOgHBVPq3mZcfv3sbrQned02KfbpNXSiG9TpXIymUoZIYw2/rrEF1kkW4V+M6ur
         ZFQEzawTQHARjDZaZcBAfNnNDBqyJAfi1qmgDaiy3OzBFf0sidb1uuiubN3MP/GFfuFf
         I6Z87NVhsxukEe7LjRjc8sURWyT00GVnGTp9ZBgOfaWDpeUHU9VW9Ecgi/tVQanAu13+
         TKY2RMx7t6YAJypX50rOe9kCE9+zNNpLoTTPtyg5n5Z9WroDwVw1WRpMVn8l078hyui7
         eWiQ==
X-Gm-Message-State: AFq9FYL3N9ZhNsDa8wumE/CPB5yKeSciI4QkxkZe6fEqRSeObk6yF0lp
	3ZbEbxTWJ4FP5l8s5P/rDIV7iH5LrthnXcWEHTkAZNWhHvpoqnDeT4d8EWBDwWSp+FDojvNXsf4
	gUOeED4wqpleHC4NpTmFZ3CKejyKhWRY=
X-Gm-Gg: AYBFou2BIDWeTb+sVFMA1F/ufF6z2cRUpGNuLAOcs3FGCSIDVZ8syt/BCjjJNziqrcj
	AQVU/wqkX6WQe+3yrGIMNpt2C8XzGQ0VpIHUjYcrR0o2lTs5JbMf2KIb0wJfQUQBXwy9Iz1/oVW
	cgOoZLZBmePBFYOqMXGVo+8a5OQcXh82OWPNlXzRh9ry7rhEUuI7jHTB9P45xvmTT7ANXgzYINq
	dbQzeChqDBTNQsnQND/Wcp1eYEncslkovRTK8UCeiwhfYn40QELouGZikl7sxwBVW9uWVgDZKf/
	OKzSKBKfWKFXhgK0UQl0f1kPWCBne1xhzk5gtGWXftAAJwHjCVQmw4FRQ6UZ8n79yhtUABGhWV7
	ci/zoj/IGF4PK17Xnx3TBJmhRzlWa1hZKk4eU+/T87A==
X-Received: by 2002:a05:690c:2004:b0:8ab:3c34:b3b1 with SMTP id
 00721157ae682-8ae392b136dmr11052687b3.15.1790954680601; Fri, 02 Oct 2026
 08:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790905146.git.aluvala.sai.teja@intel.com>
In-Reply-To: <cover.1790905146.git.aluvala.sai.teja@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 2 Oct 2026 11:24:29 -0400
X-Gm-Features: AclHuK-i3EwERwt8-9bndNAt1jCy0D5sFu31x-31_pho6_Duk3rSJADxoPsu3iM
Message-ID: <CABBYNZLGv68DmBPp+BPePsiD=JWT0fGAT2yD6ZKS1sd1z31Etg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Bluetooth: add hardware rfkill handling
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com, 
	chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sai,

On Thu, Oct 1, 2026 at 9:52=E2=80=AFPM Sai Teja Aluvala
<aluvala.sai.teja@intel.com> wrote:
>
> This series adds hardware rfkill handling for the Intel PCIe transport an=
d
> the Bluetooth-side notification path.
>
> The resulting flow is:
>
>   transport hardware event
>     -> hci_rfkill_set_hw_state()
>     -> rfkill hardware state
>     -> hdev->rfkill_block work
>     -> HCI_RFKILLED state and device power handling
>
> For Intel PCIe controllers, the series adds GP2 and HW_RFKILL MSI-X
> handling, IPC_CONTROL doorbell synchronization, delayed state checking,
> reset/shutdown/remove lifecycle handling, and notification of the
> generic HCI rfkill layer.
>
> Compared with v1, this version drops the Bluetooth-specific debugfs test
> hook, the redundant hdev->rfkill pointer-clear patch, and the separate
> RFKILL-core helper dependency. The real btintel_pcie hardware event path
> and HCI notification interface are retained.
>
> Sai Teja Aluvala (2):
>   Bluetooth: Add interface to allow stack to communicate hw rfkill
>     events
>   Bluetooth: btintel_pcie: add HW rfkill interrupt/doorbell flow
>
>  drivers/bluetooth/btintel_pcie.c | 140 ++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel_pcie.h |  27 ++++++
>  include/net/bluetooth/hci_core.h |   3 +
>  net/bluetooth/hci_core.c         |  34 ++++++++
>  4 files changed, 200 insertions(+), 4 deletions(-)
>
>
> base-commit: 3b44711c52eaf62723a4a715e1b7b4e49f1595ce
> --
> 2.53.0

Sashiko flagged quite a few issues:

https://sashiko.dev/#/patchset/cover.1790905146.git.aluvala.sai.teja%40inte=
l.com

--=20
Luiz Augusto von Dentz
