Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B98171E7D
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195842; cv=none; b=a2+A/JbRP9y2HhOAPLy+hmvo9J8Xplb7+M+eFzlXgfaZuhLYa6UuWRClJ21zI/IWBhDaA8l4asI5EUrcy2CNBD488dFhwFIkh8cNk4MnA5Q3ShJQskl4WUSO/9PKWcc9ixeSx+DyG6lomlDVLVH83HalIxVI5kTkFrPvgWEh2/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195842; c=relaxed/simple;
	bh=q9Hi4EAC7u/D8TWFxDRTyUT9vdV7F9/lgJX0aCN1TAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eQ+lHaiv/rzxymZzWCBpqdphMn5psc1vhkbxP/YT8xbA9fy7iqvjOpSMhd0AUs/CHXL1l/CvdaOcAaEWa2VQQhklAPgTldMROi74lerkje0TlHqLS/GlLpVF185wFHM29pODKyqSCgFPAvjjh7Cha94dQoh5N5+xW/DTf6v6sto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cU3BPSE+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cU3BPSE+"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc335e49aso2930192e87.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718195839; x=1718800639; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p96uUxQOoHzqFpi1OyHubdPKWLJfefsiFVXI61S3V4g=;
        b=cU3BPSE+y4Uq1G6gwLaQocOFtc2EjhIQN8kFIJPJet9r5ZGGdRLvFjBpzCrKLsT/qr
         X4jtjVEh9twY/QiTl2Otnk9tWgspdWf+ECQtrD5Edb9j8l26fe0nZSJyc12/iDU+LH4k
         hrAxkk6NgdWmJ2ORWkw3czlpUmYfp1XGu3zpOFk+CfYmdEwml4EJ+0tGMAZggKxG/K4p
         FpYtdSro1gg16Q1mzyY2XT4e9qASCAimmFod+5d1KEbvU/8a7iAqAkAkaM7IoI0XWXvQ
         7COM/ymG0pBKp1LmlInPwwvjg0LyRCJF/8F0EzeRoZ2jJ156E0XlL76V8nhsT9nVDZYM
         0xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718195839; x=1718800639;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p96uUxQOoHzqFpi1OyHubdPKWLJfefsiFVXI61S3V4g=;
        b=fwBP31OQmQmgOs6Gmc+MJBTxT0TFgg2zQ65quveOiUnaX0MlqKtmomghDzUor/Or4J
         pS0fJhQ4GD9eox5lnNc576q5KIBuTedb7R78FnFu0KJ7N0/Fr57Sbbck6qUJoa3ZKFqW
         /7R1xI9wuhgByiT8L/723zdgx3klTX6tZ2cxLj4zghoyXispFVWwD8POdu3CbYxFUF8a
         h7TJyW7GfhxrRT0v1FeJ8+O17oFDq+TdeYRYvCu7IyD3Ke5D5aNqAKJTy4NujuMnB8sE
         wFEKbId8PRnv7bMFL5LKZn2I0TlJ7O+1UEipAQu/4LJ7oMvNc3XGEv4xnm5z9GpNYKi1
         t4Zg==
X-Gm-Message-State: AOJu0YwpS0eYFTkxgzdN6pEDHvgfhAH2TocnPC4K6YvlJsjOfwkkfNAD
	L6RYKhELsxnSsnP8bP+apNZOhOHX1te+WabDVqXuNs6fuOk18qf8uDxStEs/SrBellohn/fFVgr
	D
X-Google-Smtp-Source: AGHT+IH8SQN72CUC2VdO64jw0I+vX5XNyPy2ghOwARb+WCR3G73xpodE3heHPMb2zfvw7b5WH3+2ig==
X-Received: by 2002:a05:6512:3989:b0:52c:9d38:9df1 with SMTP id 2adb3069b0e04-52c9d389e68mr1313197e87.10.1718195839005;
        Wed, 12 Jun 2024 05:37:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f24ebfbbbsm8080432f8f.61.2024.06.12.05.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:37:18 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:37:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: ISO: Use defer setup to separate PA sync and
 BIG sync
Message-ID: <1fe76229-9b40-400d-9d63-03a025603bdf@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Iulia Tanasescu,

Commit fbdc4bc47268 ("Bluetooth: ISO: Use defer setup to separate PA
sync and BIG sync") from Aug 17, 2023 (linux-next), leads to the
following Smatch static checker warning:

	net/bluetooth/iso.c:1364 iso_sock_recvmsg()
	error: we previously assumed 'pi->conn->hcon' could be null (see line 1359)

net/bluetooth/iso.c
    1347 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
    1348                             size_t len, int flags)
    1349 {
    1350         struct sock *sk = sock->sk;
    1351         struct iso_pinfo *pi = iso_pi(sk);
    1352 
    1353         BT_DBG("sk %p", sk);
    1354 
    1355         if (test_and_clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
    1356                 lock_sock(sk);
    1357                 switch (sk->sk_state) {
    1358                 case BT_CONNECT2:
    1359                         if (pi->conn->hcon &&
                                     ^^^^^^^^^^^^^^
If ->hcon is NULL

    1360                             test_bit(HCI_CONN_PA_SYNC, &pi->conn->hcon->flags)) {
    1361                                 iso_conn_big_sync(sk);
    1362                                 sk->sk_state = BT_LISTEN;
    1363                         } else {
--> 1364                                 iso_conn_defer_accept(pi->conn->hcon);
                                                               ^^^^^^^^^^^^^^
then we're toast

    1365                                 sk->sk_state = BT_CONFIG;
    1366                         }
    1367                         release_sock(sk);
    1368                         return 0;
    1369                 case BT_CONNECTED:
    1370                         if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {

regards,
dan carpenter
