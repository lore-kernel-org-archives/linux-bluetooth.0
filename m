Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8D2C11CF
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046970; cv=pass; b=EaE6Q7LnTyDtApk15hBmFGa7hvb3AI3Pe8jTksD1S5hFuXEyltcyMYrP0lRfeKqkOstlyX/J26Z6ngKtfME6bvQugLBpIRzCOP+i1CMLDGJCDDaRgh2niJN3Ayo2M8AzU08KPOF7LUaSbpkypvOJ3g39Bn0zwPTHXQ9rdtgKUf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046970; c=relaxed/simple;
	bh=tchYxSodbm8UwJdOUvlsYGQCs70i3eLQzYMVsVCLIgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2u0gEZYyIHcAjd0Hdbq7kmZND+YIsGlhspE45cCTl/nD3N0JIvMhGyTpxZlSXKpREkcvzuT7W49wtA5MiEgZC/CKbRw+YtL2xHB0stCjQw5XgY2CxkSLPKItJF3aSrDOYla6eT/3ITNwGRxWkExQj4q5JyNyl54g6gL+uNfjCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1pO1JrL; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1pO1JrL"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ae222d978so6769815d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 11:16:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772046968; cv=none;
        d=google.com; s=arc-20240605;
        b=ZYLOi2txcyzXHRIfvyZCIXJ3ltIoUDOkLj1xw5TXFr9L4Fgs2cRM4lpPq8jHDFamy/
         mz6DsBPofzjspuJg+kjttLnIlJbPb3wGZDWHiecY6ckUFpW1f7zW4JV4Ta1DXbA00dRb
         X+Nv2lmA8PJ2uwvyUlpU693MLv1YCkdEHbvlYMq2Hs1F7uWDQ/yL80XVSNQwLr83kYv0
         khiI7xkGlIh9qpwfJ73e8ZPw86wJHTZPuRtN79WBrx445ngcdUSoIlbXCniqvn+C6RYA
         ShKfprl8S1z0CTlxKU+PNi6tyiekV9oZ/5bwjmQgD+jNknLJDkAyPjRryovfqq7Z75LW
         xQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HkFbuUfLRSglBYZEiIAKV9hdWn1oT2tQfmQ9mGppfts=;
        fh=OdazoPLGEPgG5azNaHRln+rRtFXfMzUlOMeo6/ibF4E=;
        b=doDHnK2bBHlKvMeSSkwsWA+aCZaHiyKgD+43JE9Uj1HFYkN6sfs8cESEzKS/bEji5z
         zReaTMWVQ3KRozDJ1+zEF1AeYNWW6VJBQLdtMyKrA1yQma3K3n/aeUfXypmihvO1i0/3
         uUIlSk8WacK4kyjpc6XSUlmsPUtTSnRvg2WquDFy+d99WgYLuUf2L8ZV1yER651LRS4N
         JGd2kJewTt/F4EoesqBkItyRwwgPuXtpzDircL6mZFMh8dXJEHiHvjrXKj8HSOjdwnEx
         n7g7/9K3R8c6l9GnRIr93AqZMhztCO+7lEAAYJHjqXV2+LB2oyh59DLoRdM7RaDx4LCY
         GGoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772046968; x=1772651768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkFbuUfLRSglBYZEiIAKV9hdWn1oT2tQfmQ9mGppfts=;
        b=P1pO1JrLQmYK17m6b+dfbYjtBKoM5Fvtbfjte/oZBg8QH0A+qMX+RsmLH9d7vpqxww
         n7zU0+pL9ydD7PdWFlMK8UGWzDRcHn9ARxRi2JXF9Gr/dva1ifX5YPoCYCKLotnLAvWp
         /zfrogRWsNHemXGT42ZdQ42AQdv8h0ayOXtaRD+Z8StbxgeGj1u66nHfbEKUdnwljq8u
         wQgjiDtJljjNM6DrOtVZE+t1ibUUYbJpdVvPLx8r08JaQbFRW27km1iEzj8Et2FHTcVo
         AgYcacLKXS6I4KhkG9o721cBBtvfmOIFUh0YvPY/Z7eRLmM4000w/WASVYxjSxXJimvk
         t0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772046968; x=1772651768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkFbuUfLRSglBYZEiIAKV9hdWn1oT2tQfmQ9mGppfts=;
        b=JrYOUtT8UqVaWS03AoYdnajItH6vAnQxJGh9Cvn0jZwc0N9+SW9cqe1xeIGUE11nDK
         SesWKFck42ZlWXtV4nDQA6yfYcjK1m9j0VUGcd+w3zcFNzNAkNmlFLr1YA1027s5GVWf
         MRFYCzSGAycHmPvgb+FzxGri6eC6cgZ+NDY6RMiFdf9c1IOX3V68yDLB6dKl+FqtSYw6
         w0WQKn5f5BgTAjdRDUGjYbEfTqERrSgrGfKmMTopgD1m/apX+kVZJHg7moRNSfbMAZjS
         EBLB9AQKWeaQsJhB6SNzlwiz0VCP7A3A4LJt9cuXWNTt2En9/8dJlg1IqHaS7dOvV6yC
         E4Sg==
X-Gm-Message-State: AOJu0YxqYas4wORO4ahDaLP3F7GxSmI+nwJ4glFlv5mqxMTO2Qwm3nxi
	QvbUhXEfR/hcV1TKn+ns7JpE7QR5WTdIuYfnMrj1fV+XU0/Ctvwr3QVHO1WNSxv6ZkYFn38HEGk
	+/hZl/u8qDJ8hifSuR70iaaKpFFxUfBN5opPASiw=
X-Gm-Gg: ATEYQzyjI020vltf4xYcKSu5W2DCrTegbswY/aM6GzAWfgDDIavADBc9/l7xaU4Riiw
	yBXPdCz5Xl3XiJGM7BHIFWmETG80UD1MtO4/H9gbuWdyRsGRPe3TnZ/GnEQryGI4AxYgeMsouZA
	QD8FSh6uxuKi7yElfmGUlxsGrFBbUzdhpy/w2RAKXzuzmN3vL2SEaZMPIaIxCCiHy/Jormkgi+R
	/lXiE29t4eXQ+NVdKF80WDhBRml19QcnlErn32x9Nh0gEl9Ybr62aPjmyg67MGMyGJWVy/jlzqS
	Jby0E95w1M29Jt2/QYKxgmNgO8y5uiUjJ+yRl8cq8Rt+f6DX52aZqdenSkYHAnOE8IBUKw==
X-Received: by 2002:a05:690e:4081:b0:64c:b242:496d with SMTP id
 956f58d0204a3-64cb2425755mr1401590d50.18.1772046967615; Wed, 25 Feb 2026
 11:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225170728.30327-1-ceggers@arri.de> <699f3cbb.050a0220.322062.c50e@mx.google.com>
In-Reply-To: <699f3cbb.050a0220.322062.c50e@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Feb 2026 14:15:56 -0500
X-Gm-Features: AaiRm50OENWx7O0AXBKFNK8f402tgD8s0mKpexwne-sh8Gq-yeO0RikAvKB79EI
Message-ID: <CABBYNZKO7cGGcYdf25udNZ7DN1HFGxViKbpzMMNAS-k_Tcc01g@mail.gmail.com>
Subject: Re: [1/4] Bluetooth: L2CAP: CoC: Disconnect if received packet's SDU
 exceeds IMTU
To: linux-bluetooth@vger.kernel.org
Cc: ceggers@arri.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chirstian,

On Wed, Feb 25, 2026 at 1:18=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D105=
7934
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PENDING   0.61 seconds
> GitLint                       PENDING   0.39 seconds
> SubjectPrefix                 PASS      0.22 seconds
> BuildKernel                   PASS      26.19 seconds
> CheckAllWarning               PASS      29.05 seconds
> CheckSparse                   WARNING   32.68 seconds
> BuildKernel32                 PASS      25.67 seconds
> TestRunnerSetup               PASS      566.33 seconds
> TestRunner_l2cap-tester       FAIL      32.80 seconds
> TestRunner_iso-tester         PASS      98.12 seconds
> TestRunner_bnep-tester        PASS      6.43 seconds
> TestRunner_mgmt-tester        FAIL      117.95 seconds
> TestRunner_rfcomm-tester      PASS      9.52 seconds
> TestRunner_sco-tester         FAIL      14.51 seconds
> TestRunner_ioctl-tester       PASS      10.38 seconds
> TestRunner_mesh-tester        FAIL      12.51 seconds
> TestRunner_smp-tester         PASS      8.73 seconds
> TestRunner_userchan-tester    PASS      6.78 seconds
> IncrementalBuild              PENDING   0.99 seconds
>
> Details
> ##############################
> Test: CheckPatch - PENDING
> Desc: Run checkpatch.pl script
> Output:
>
> ##############################
> Test: GitLint - PENDING
> Desc: Run gitlint
> Output:
>
> ##############################
> Test: CheckSparse - WARNING
> Desc: Run sparse tool with linux kernel
> Output:
> net/bluetooth/l2cap_core.c:7785:1: error: bad constant expressionnet/blue=
tooth/l2cap_core.c:7786:1: error: bad constant expressionnet/bluetooth/l2ca=
p_core.c:7788:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7=
789:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7785:1: err=
or: bad constant expressionnet/bluetooth/l2cap_core.c:7786:1: error: bad co=
nstant expressionnet/bluetooth/l2cap_core.c:7788:1: error: bad constant exp=
ressionnet/bluetooth/l2cap_core.c:7789:1: error: bad constant expressionnet=
/bluetooth/l2cap_core.c:7785:1: error: bad constant expressionnet/bluetooth=
/l2cap_core.c:7786:1: error: bad constant expressionnet/bluetooth/l2cap_cor=
e.c:7788:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7789:1=
: error: bad constant expression
> ##############################
> Test: TestRunner_l2cap-tester - FAIL
> Desc: Run l2cap-tester with test-runner
> Output:
> Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> L2CAP LE Client - Read 32k Success                   Timed out    2.507 s=
econds
> L2CAP LE Client - RX Timestamping 32k                Timed out    1.890 s=
econds

L2CAP LE Client - Read 32k Success - run
  Connect in progress
  Client connect CID 0x0040 handle 0x0001
  Successfully connected to CID 0x0040
Bluetooth: Too big LE L2CAP MPS: len 672 > 188

It looks like something is not quite right with the tests above, we
are getting more data than expected per MPS. Anyway, here are some
changes I've made locally:

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 69a57b956895..a187be90e74a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6664,8 +6664,16 @@ static int l2cap_ecred_data_rcv(struct
l2cap_chan *chan, struct sk_buff *skb)
                return -ENOBUFS;
        }

-       if (chan->mps_orig_le < skb->len || chan->imtu < skb->len) {
-               BT_ERR("Too big LE L2CAP PDU");
+       if (skb->len > chan->imtu) {
+               BT_ERR("Too big LE L2CAP PDU: len %u > %u", skb->len,
+                      chan->imtu);
+               l2cap_send_disconn_req(chan, ECONNRESET);
+               return -ENOBUFS;
+       }
+
+       if (skb->len > chan->mps_orig_le) {
+               BT_ERR("Too big LE L2CAP MPS: len %u > %u", skb->len,
+                      chan->mps_orig_le);
                l2cap_send_disconn_req(chan, ECONNRESET);
                return -ENOBUFS;
        }

Perhaps the bthost isn't checking the actual MPS to chunk it properly,
but it probably worth fixing so we don't leave these tests failing.
