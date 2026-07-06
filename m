Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4441A78B
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344122; cv=pass; b=dxKdtD86777bLh8/383tWxh7h8QHzIS/4cKCOSNxA121gCCEIyWaBekTKDZIl6qVHHTutlQGDCeo8OeoINKg0svBlk9N+L2lRRkNWSJsd0OFd/O6zHIgRwONOokJ0q+V3WeiIypAjV/pSXa+ecVJ/+aky9+Ad1X/CgpkSFg9SGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344122; c=relaxed/simple;
	bh=NRpkEVsrO11eq4CxBW/dXRw+VTRn2w7uSQ1EWJH5sLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZT7lMzuwK0oQLXDLjqfwryWBq2dLRqSY706U5fpd3oQBtt/1GsDoR4YBFRKMr6MgBIkLKZIhgkvPzyOd3hy26VlfdG7Uo+wXeTsHvloiqW25ibqKXAxSwa47E1g3/mBKAsre3SOTCsF6UpVY2+NNQhvjMhxAHE1IRXESFvWmHlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbE8Vcui; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbE8Vcui"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664d7863920so2218650d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 06:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783344120; cv=none;
        d=google.com; s=arc-20260327;
        b=gezZqnWODtM9dPyn8OdpEEeDrYGQdZo7yBXghV2IET+8q2e/98elbXbl1EXCq8bJPY
         chxDHv+W1IGKzGrKoEp72zE9p8gv9/wQOzmfNhFBcb9VCRXCFhXS1DQGKs2/bpqjzeiU
         1WeF0S6GSbmHAcNB5+avsdBz09BRtlfh7N5vFXzR8RbPBEF5c/VJZJ/lcZWbQ83W2fS2
         TGO1/Z0IQWzeKVGzHonVTUsuKCdZek9rleeNuMxPun0ymXj7qfaglC3lxBNMeqocFRT0
         8j8zEUS/KhoYCBzRlctWGy/eUzogEKfsOPHEtdq4HprNO9rdQC7pnlFFy7uZLE9q2C2I
         LWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Crk8V3NFGTDCyc22U0OiJpfYC0BId6QVuYdAFk61QFs=;
        fh=a3VsNKzd/8P581Kn+tZLk++vm6FcqjSJCnXgOmTm+t8=;
        b=Is1Ip6AFW4csE8cDrdkMH5LQeygOlNIEA35s+HIy6nlvryC0oSVpA6ALNE+2vSgfJg
         pNB25DmGSX1+Uj+WYaXSddR/BH31ECWb9jelDdr/tGTjeQuMTnjFKS4/kAXx9o3OdU4F
         Y6AbSIFpFI9vY+UXpiOqEtq5dM7qj+3mmrh+51bnCe/oZTdTKaD6ns/pFi+tFLUyeS/w
         xRUTXWmB3jzccnUQEthz2XERi8WM1w2id1nRf8ZkAxqjJ9OKFI/ziLUtJ6yDqa7lOE9J
         dS15nvrQlFk8wDoolR9eqAIKw3nUPysj/6qe1+YJ6CNVVfTH4gROPC+E1UJcVWpCQxV+
         9kdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344120; x=1783948920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Crk8V3NFGTDCyc22U0OiJpfYC0BId6QVuYdAFk61QFs=;
        b=DbE8VcuiydVfXlBkInQvRmwiawHbdxa/Ni2S5ZH30k1rcJ1LRWoAtD3wTUHGlJa18o
         WLhPv6i1fF6p5mmOOyhcJNobnkqSNOTVCu8UkOFf154u7T2GoDyVDcUBKiuPESrzcV+f
         jKJ8HzOL9d8M/syqO6CI1N5tjtrjck/uzo7IPXa884jDh9B5llR2r9Yj0mxZCHHH5of+
         JhRjrJq5JF8jL+H7DJDR7hFK+kbk+sWSbyd1VfEGtR2sxE0rfZaoJOT4weNM1NzNEx46
         Kv0r5fBNR9I+VF4u0mbaKeaS22m/EHhEoSDtWY3ti3MXXj3B4X0uzO5UdXlfebn4S2S7
         NlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344120; x=1783948920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Crk8V3NFGTDCyc22U0OiJpfYC0BId6QVuYdAFk61QFs=;
        b=hXiEoy+DZ82kfOtAEi6enpotMzC0fuK8ctqQnAfY2dTFi/q1BTH45TqnuGwJNR+uZa
         fs5uRW8ZmlLmmcOSotqGi6bInjbGc5XJReoCoV4Is3GToZq7k3RYAiKa+0JeGl/tHQ2w
         yoCtE8CSqX8NQ+GexEQkGV8OXg7l3c/U/GXRkn9cy/BJk4o0YI35QpOj+sQ8mteyqEIH
         ESrz/fdTsfYS5o983wtLDBN2oVj60jo4qFIsKLOMfzJBEbrP1bR9dX0ZWHLkyYy0iK+V
         TejHZopromCw1ijPdCVraBLStRMhe/MQhjyxS+rLo/2zy03eY5BddbZlvK26frDtELWU
         GbAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq37Ozv7h0JEtQaphdfNJFeT0FwxVzyb7Eg6EBwQLREIKEj2n4cwrJuMaDoieF7yjdv7iIhX2rKnFZhcSVxyTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzSOtcfAKcTz8wY/5tbWk0G6rF8uuj+xxyok/eqjxt7FkMt39S
	Qk87XcIrhb0FTM2vyw49plmfDnb2gmS7ql6e4kMoIS6UPVn4+ty8mAdtO/WgjaoZMnUmD/jQcXn
	725oWLFK5m+2GVqw6S6x9NuyRIuZFhAw=
X-Gm-Gg: AfdE7cnUZqvXyxTlxNWdJUoBoxX/jWD7lT8oLPyV6r0viMUFV/Us9joAh1rlqv0Xgy2
	oui0sOJLfQtWcDIly0hmSjRLlj9Pgf2xzcW3Oju9FrlB3ijpF41kUWN8q468LGAbLKOdqqRe1aS
	LoWRTvMAlXfky2uUTgu/ONKyKky3QXY3xiWuDtxrnCiRJ8oW12Otx63P3bygq2LcFnBGKniE/zz
	KsZ1tDBKLNLWHZ6BhPqJnvsmDjbtiL9a0vxzczaMUNUG0ZUvnV/Ll8b3Lk7b2GNpJIwj0x5qzhv
	LfewQRTADWS0fGdDuHGxIEISGP1VsO/9dcvyBgX/z2SUmo+7imHaS4KYZPs=
X-Received: by 2002:a05:690e:d4a:b0:664:ce2f:faaf with SMTP id
 956f58d0204a3-6677fadaca9mr563422d50.31.1783344119481; Mon, 06 Jul 2026
 06:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706121525.2717691-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260706121525.2717691-1-shuai.zhang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Jul 2026 09:21:47 -0400
X-Gm-Features: AVVi8Cf-YDNoL4XWaUnO0AcjXOX198k_S_3iGuDieL4X7Pj_zPzTnJZtt5mCgGQ
Message-ID: <CABBYNZJTdONXJqKa5oR9EKAsZkLQBZ+w74GYQfKna79B4RCUMw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Increase HCI_AUTO_OFF_TIMEOUT to 10 seconds
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	chejiang@qti.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Mon, Jul 6, 2026 at 8:15=E2=80=AFAM Shuai Zhang <shuai.zhang@oss.qualcom=
m.com> wrote:
>
> HCI_AUTO_OFF_TIMEOUT controls how long the kernel waits after an
> adapter completes its initial setup before automatically powering
> it off, in case userspace (bluetoothd) has not yet issued
> MGMT_OP_SET_POWERED. This avoids leaving the controller powered
> while unused.
>
> On platforms where other services are ordered ahead of it, the
> actual time at which bluetooth.service starts and issues
> SET_POWERED can be delayed past this 2 second window. For example,
> cloud-init-local.service can perform a network metadata probe
> during early boot, delaying bluetooth.service startup by several
> seconds:
>
>     $ systemd-analyze critical-chain bluetooth.service
>     bluetooth.service +594ms
>      `-basic.target @9.342s
>         `-sockets.target @9.335s
>            `-snapd.socket @9.267s +58ms
>               `-sysinit.target @9.025s
>                  `-cloud-init.service @8.377s +604ms
>                     `-cloud-init-local.service @7.000s +1.340s
>                        `-systemd-remount-fs.service @3.257s +44ms
>                           `-systemd-fsck-root.service @2.803s +394ms
>                              `-systemd-journald.socket @2.223s
>                                 `-system.slice @1.772s
>                                    `--.slice @1.772s
>
> Once the 2 second window is exceeded, HCI_AUTO_OFF fires before
> SET_POWERED is received, powering off the controller and losing
> its firmware state. The SET_POWERED that bluetoothd eventually
> sends then has to reopen the device, triggering an otherwise
> avoidable repeat setup and firmware re-download, adding several
> more seconds of delay.
>
> Increase the timeout from 2 to 10 seconds to give userspace on
> systems with slower service ordering a more realistic window to
> take over, avoiding this unnecessary repeat setup, while still
> bounding how long an unclaimed controller stays powered on.

Ok, but we have no idea if the system has Bluetooth enabled. Making it
a 10 seconds timeout might leave Bluetooth powered unnecessarily.

> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  include/net/bluetooth/hci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 50f0eef71..ee3f295f9 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -483,7 +483,7 @@ enum {
>  #define HCI_CMD_TIMEOUT                msecs_to_jiffies(2000)  /* 2 seco=
nds */
>  #define HCI_NCMD_TIMEOUT       msecs_to_jiffies(4000)  /* 4 seconds */
>  #define HCI_ACL_TX_TIMEOUT     msecs_to_jiffies(45000) /* 45 seconds */
> -#define HCI_AUTO_OFF_TIMEOUT   msecs_to_jiffies(2000)  /* 2 seconds */
> +#define HCI_AUTO_OFF_TIMEOUT   msecs_to_jiffies(10000) /* 10 seconds */
>  #define HCI_ACL_CONN_TIMEOUT   msecs_to_jiffies(20000) /* 20 seconds */
>  #define HCI_LE_CONN_TIMEOUT    msecs_to_jiffies(20000) /* 20 seconds */
>  #define HCI_ISO_TX_TIMEOUT     usecs_to_jiffies(0x7fffff) /* 8388607 use=
cs */
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
