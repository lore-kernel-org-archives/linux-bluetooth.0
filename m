Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A7F3AC0C3
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774908923; cv=none; b=ac0hJxLLdS1r5nIswSZjFOjegJT+2jsnHOP9pMQHXYa3gYRFKZwpe6aXS9GuyY02gZ//SFsJq9113oLSADsbhQPFMo6kOiLBm//QkoHKimw8C052FtXwi1FR/TSdNl6/U0wWOKlgz1oo+g9lFBWO9OKSnuxfyb9W9bqzzuuBrQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774908923; c=relaxed/simple;
	bh=pX2WKX3zToh3vvAGp3fpKMyHP0+PbOINuhyqYDLke84=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=kvHzytEkhoqt1ssyltJluNEoJm+jT4u1lrqgGwLqy4NbQ25viVWAH44RHoT6ZAjslG+rM9LNs7aTkGI5cWPH0wPw+MFwS1ZtI8XeAudk7EabB3yreOXPtXQpi+Eb/Z9XtHvsapeMvDpKfXjlhx2zGwUsgiv+OPQHWmGz03h/b4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpJfmaQ7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpJfmaQ7"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50b35f3e489so58766771cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774908921; x=1775513721; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pX2WKX3zToh3vvAGp3fpKMyHP0+PbOINuhyqYDLke84=;
        b=EpJfmaQ7x6LAgCSEhddsbzlSWSu8QsDY1iRnWhnelAsKJBUtWyRPVVYjsRgklx69vy
         gdSqX05dXQlMo1ti4e89/l1LwS8SMy4tkwUx0oWDLO7EZG3Dcu/54bMQ/rSbyN7Ymw2i
         M0oA06gssUXcwiuFY+9Sy9OaGy1zV95v6gh2nv3MQdx6MODM6DOCeyS3KuGdpXzArm2+
         xLLVdzGGsFbGRQ83P+oVmzeOyz7bSvnbLyeGgKBvUOnhNAii753rsoDuBVqq+lJdtNnx
         D4awjVCfqngRgFolb57LkV4pnFGcDwd/2zWl7301CPrZAGCcHK4eHSdHI5PoVavITEnn
         LXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774908921; x=1775513721;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX2WKX3zToh3vvAGp3fpKMyHP0+PbOINuhyqYDLke84=;
        b=d6HF7ldHMSnIMGWUrjZPXl+9o19MDD4/woqLUyZ3vtyVh6Tt6pxZgrtXdaXYuAuh5Y
         gbMM/YwB84lV0cmqZBWkbAcXojOoE0VKqRL7jAc0INbTUtifHxunjCDIo1oECOW2bjSb
         atOy+7AY71QWhH9NHY4Up6ypLeXpPl0PIWP0uBM7qeWxUYoN6kHDVIPzLzzU6Mz0aCwz
         ZF8N/pdNnpoatGvC1WPRLEx1lBeUAdsp3wL9+hQ2vBjDLmxpIpOglO+itgl9ATDSQaeb
         jqDiHObi8cdDN8Fh06mJSxfqzGH9anEJl7ATG+oFtkkBEE/Yhhu8lKNOEHdCoqOx6eGl
         qG/Q==
X-Gm-Message-State: AOJu0YxW2WzCRnaZcueAo4a7LIx8rJ7fPQhxz2NaUbsVTtVuZygvD+jo
	YYKNFF5tvolPo8tmwatE200zd9SHVRa1IPwBDbx7ob8E1+EXcvJzsRwd
X-Gm-Gg: ATEYQzz8clTN6vvS2Xqz89KATpbu4ZUAULr0M9YOWH90v8z7F8QGkGiE/R4dXN9bry0
	skow0DL34+Kd/GLV//Cdfe33c85RPExQqR1SekkiYqfGIDL5WFtgZP1O20aN5IWbLlGgQcUvJfF
	WN3V+rR/iB3Ctx+xLibhTtqTrfJOBWXxWo2drrQtwwpravE9wgciHWoF+ehoOCSTsWcLQi0fleh
	suzGaDgrth/4vY2wVNeGktdT94raSWgpu4d2ukYduN0gqEfPiQuypqIqSq5lLormL7sds67uDlA
	iJXd+VUy5/Q1RF9TLZ8v+J01oWLNaczOFcxmK20fWmvCiTKF5XuL2y5zCy7U79gWYNOqTBx5B/H
	y653YF5ZpXFV+z14nAWRk4LqmdUO/fMWurNTuY4tkq4RC6YnCXoWb4XEYUxMwi5tLRCOExE7L8C
	L2LWQVwD+386FK7KbUGgeDwbrLEHRH/2vK6GJbMgqzsh6c0xIbN1qt2Sed4oBh6QdCwfCx/BsF0
	zD1NKHr3CMrhGJxPHMPTmHBiH5Hlyjs
X-Received: by 2002:a05:622a:514d:b0:509:3fc5:a840 with SMTP id d75a77b69052e-50d2c62eb15mr17601591cf.10.1774908920743;
        Mon, 30 Mar 2026 15:15:20 -0700 (PDT)
Received: from localhost6.localdomain6 ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb3df388dsm92762281cf.6.2026.03.30.15.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:15:19 -0700 (PDT)
Message-ID: <69caf5f7.050a0220.3c2ca3.53f7@mx.google.com>
Date: Mon, 30 Mar 2026 15:15:19 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, xiaoguai0992@gmail.com, kyungtae.kim@dartmouth.edu
Subject: Re: [PATCH] Bluetooth: ISO: validate ISO_END fragments
In-Reply-To: <CABBYNZLu31g8KnERbrOSDav90OaYOoSXjcS4ALBi8RmiXMaVig@mail.gmail.com>
References: <20260328200938.140528-1-xiaoguai0992@gmail.com> <CABBYNZLu31g8KnERbrOSDav90OaYOoSXjcS4ALBi8RmiXMaVig@mail.gmail.com>

Hi Luiz,

Thanks for the feedback. I've sent a v3 addressing this -- checking
!conn->rx_skb instead of !conn->rx_len:

https://lore.kernel.org/linux-bluetooth/20260330221015.322337-1-nathan.c.rebello@gmail.com/

Nathan Rebello
