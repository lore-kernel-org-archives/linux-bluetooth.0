Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FD1F176
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716229884; cv=none; b=Oo4VXgEE6zoMzM6ZyDVJE6Onh6rJ6eeMk3FBmhuuXYKWZu1mf0kfVuUCWHZdDN7rf4+R3JWI42YEwq3BVc3DNn0wsk6VeigPGa2mZ+hqByoOfyQK61Fy3npqYBD0A1s9Je0kduUnutAJ0NUtF0mNQG9s3HRCdaqG4xlAl03PNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716229884; c=relaxed/simple;
	bh=w72kuny59JBap/ZFYhR206UuFQksntuPL4eOfWayIvw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qXqoCMl0sOp+3WHzEI7RlDC3QvVgmJoqbYdytBLHUskHKCheEibTaEBKwCQJBf5vmhw7KphPTd7mrxh5DdK5xXqfeoiYLpfACK0OVKJ7lupidOUoVjLrtm1uXjD4L0u/GikR4zl5HMXjjwZoZNVW3ldDOQ7gvhNNtRiLwKvruLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp/99nUW; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp/99nUW"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f0e7af802eso1366448a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716229882; x=1716834682; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v7OXDOCXJissye4Lf+X2eJ/WcOR479oZVZ3qXv4YQzc=;
        b=Yp/99nUWoEbIBa+j3O8vpPbNJ7ErJVlJ2U1hhxJgze6TkV8fVMLZGSx2zOvI9XGIcy
         3xvwWLEK6uGFPKgnYcRjw128fm8YGPZZUwWmfuAkaBy69LqxNbUnFrRxuF3h90Axmtr7
         RGqFNKVM5k2geWC3P3DCZD8SQnzCCwZrc5EuMFwXdM3qvaobSybr9wxce9u8u8Jw9JS6
         cdWU/L75fDG1TOMOxFuRVYz0vCw0b63nbvecumFFZ8ci9vQ9DGOXQlt2Z4elDU7WKt7k
         yme5tVgzrepZCApQV5M59Vdh10BkUi469b4gfb9tiRozS3dwHtq8LEPBbjof5bd7Eys5
         QCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716229882; x=1716834682;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7OXDOCXJissye4Lf+X2eJ/WcOR479oZVZ3qXv4YQzc=;
        b=Q6R9A3jT6H495JQlW4OsnAx09Y8Qc/l5y+2Z1hRNeu0zeCuiV3CCA1J1Q0fVZaP+lL
         Nt+JsOvvmdfuN4FnLi6pFXip66NNLrnsbEJhMebYdG4eh9qsSyNxfNrSWmM42keAaTl8
         hUCT+hqHPROQ5DxobNFxlRZaNvXYPaY/ICwvJKTaOepxstlvA0y6DrjmA8XtggD7EfuA
         6VJ4Hip4YqxrJIAiE39qpHIlrR8Uiiki3/jbl+o6W5k9gLMerfSjZPo5CKt/t54IchX8
         QYUYU0ahAMlFw3bB/bT+u/fVz9+KjWEuFYE19lPmUw6x9dPiASuSZ+tR9FlA2+gXX3Hi
         83Gw==
X-Gm-Message-State: AOJu0YzS4jaw8VQLYyc3nYCJqBpfaSwTQVNdBTfNBY99CDvnJhH08dbn
	UhEfBxH3WgWVPALqjiSL5Hfthzf3oLwbCT4dfnHo1hRRW3YErPSeBa4b+g==
X-Google-Smtp-Source: AGHT+IG8XQ+652W4VhGFHIl3T+93JnKy512TXPVm1srfc7hWSiPEPKLjOlP12f/TRaj6KXTTtjQLdg==
X-Received: by 2002:a05:6871:b27:b0:244:bb9e:bdbc with SMTP id 586e51a60fabf-244bb9ed677mr25900847fac.10.1716229881466;
        Mon, 20 May 2024 11:31:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.214.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a348b0a10fsm70142126d6.126.2024.05.20.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 11:31:21 -0700 (PDT)
Message-ID: <664b96f9.0c0a0220.d3094.705f@mx.google.com>
Date: Mon, 20 May 2024 11:31:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1396519223031627920=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Update BAP Broadcast Source state machine
In-Reply-To: <20240520162757.78187-2-silviu.barbulescu@nxp.com>
References: <20240520162757.78187-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1396519223031627920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854453

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      24.44 seconds
BluezMake                     PASS      1665.06 seconds
MakeCheck                     PASS      13.33 seconds
MakeDistcheck                 PASS      177.64 seconds
CheckValgrind                 PASS      249.99 seconds
CheckSmatch                   WARNING   353.75 seconds
bluezmakeextell               PASS      119.52 seconds
IncrementalBuild              PASS      3024.77 seconds
ScanBuild                     PASS      1002.02 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1396519223031627920==--
