Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420460;
	b=PJDya247ccKu/SsY8lGVKanbyvkta0TcJRz10zdg9QbVE5Q2PI73M8AUEvFdvuA/QUG6
	 L5ESDoUr0Lq6iZdRNap2oqzmnB6Uah6kU2x5/Fy/1N/AtJYDE0aH5dgQAg+5jzQKq+Vnu
	 IW+79Y71CWaq8f3fDkXZwbY38r8ppj4n6tJtlzPB3iSYJTPstroJQVOE9HXdASxZbGs4e
	 LhM/KvojgDQcqyWpd26yDM6widHZ9LJ74lRISN4ihVDzT04ts1EqkOUv7sWnK2HkG5eLC
	 c6H/FUKafoh0f6wUnH/SqO/bGCII8xau0AUSRR7XtXJjUfZsTNrTwTOiosapgqkZOIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=uaRD6h6HvCuPcPqt/936SAYEJdIP8UNIfThxQ3W1IUM=;
	b=Kx64c0Bhnmvz8hqSRdEB1aQ2c08KJqbVbJlTA0u6QvJKHw+MhGPH0jfviKzAy/tBuQ0r
	 TMXqMTgupwgG8vYENRfaNWI3cveGO5fGYaW+hbpPCBhA22DcS5s4yzB8kzsOO4wrux1eu
	 G9s/D7R8X1iHS4wPtiIj3rrdNBarZz+O1Eygkb/2XLSRWEzYZ+woLsMSmC2yWfxeHDw3Q
	 NsgDoltbFU4N4AM0CPNZLY3fAKPFQU5ovFA4B6BQFd9XTmicnRmQgHDDyZgvjifBFH2NN
	 IcYIhO4W6Jr04e+belYgwHUx7TGt9zYaxzOS3ZNbLqoaoANL0WbLkQC76XfML+8eARw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="d/0TblLa";
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCCF606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FCCF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d/0TblLa
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5351d76e1baso1068461cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 10:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794420459; x=1795025259; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uaRD6h6HvCuPcPqt/936SAYEJdIP8UNIfThxQ3W1IUM=;
        b=d/0TblLavBKv3FsSXKajzj4X4PdysOnMmiXxzoCCjpWgC9HtNsYntwOkZRqraFHnAE
         Rew5JRzNCDh53ZPND+lG9ba2DtgLe0wfawqtirxuDoUH7KH88817VH0yyWpcjt2DIo7b
         PCghy/wAsMwVWtXN780dHdDBQ7KiDhGZdOioR3Lj7L+DdpfZXGaDhmF2OjIupwF3hi4I
         +zqyVyw3wOPEz8ZJglOWKuUGo8zTOnodNv7P/2xJpWWVC6VlgU/770XiSYq+HniwvY7t
         wAqdWiQq1WOglmuT0ITZaYJPqWyWq2X+23jTq8sl98VuyGoEQzI3A9+NubT8JZJmcauv
         nSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794420459; x=1795025259;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uaRD6h6HvCuPcPqt/936SAYEJdIP8UNIfThxQ3W1IUM=;
        b=K8Zz4wroX0arejzSC3+J5uiJZu4l6tz04kYbvFDK7y0pqc414o25+/FKLq2U/O7pZf
         /qeCE8wTOODwkFznYQ0BvrNuLtpqIjlK5yxnpsKs06OAoXcJVT9BMj5mrosGwq2ZHLjw
         Du/70xIFkmod4Gdo14fA4bgN9UDtsUd8HQ704B2MxrpEMjrSl68N3nECi0v/uhJ+7QQR
         i+luJzLw0dmvI5gulE8dESEpEvSVZCoOZIC8pXcJw0TcG/NXIx+4ZJIyPPRhDWY51zEP
         d0NiI/nOY5FNfb9H5pEyCJBjXtEWEgGU88+5us6V+XJTcLITgZguMMOrxhFp4GyOkCvr
         CyOA==
X-Gm-Message-State: APuU4Z+BMk+3YlXsU/J9AsBNNjMIkNZ9L2H6D1WgA///OXND0YNYLzHw
	jWyjHUtL3FVg9B4FE9Ig6hVl2OkDrzH9JaeZrSzaSLZoRZlqXmvZBhiPEAFKFA==
X-Gm-Gg: AYBFou0TdssBKUIK1RFZrlfQv3HUGjdEx/2pb0HT5xJcMKZqAp5xIGSSSDGXFb+ragC
	hZe8y8myb5AHGRqSfX00hkXUq81hAwyde1IeBr+911CUF2i8XtctXWIYBwCFD+t90SNnwkrvNkq
	pFwJ72bQK5uVJ1njDqMcIr1IpBDsnzPpVAvkTBFIXPb0RJGoTequ0iYJeFVS5MZzDqc0A2zxzWK
	qtunmLAT65k9esbowPKfdXX1booT8y12PHyc9FWoaQJJz1p18tAt8omw9TK3xgcS5v1o29zWTv0
	Siyx7IHiFFNt1EwxFKqF/38wnt6w3C615mxr5RCeG5cNWSXOoxTH0q/bK0dcabZSbGgNJ8ZYxec
	pDeXbgmzER1ZQGBwiVH4UN/JhtilkksPW3ak1VTKM39Bvzt3aMAS1BoGNNwE0fmslFfQoEgnxIf
	6sYocK0C5+1ml1o7c29wONAOo1UPTN3um6bqek+moAsrd3QIr+lBVNq9nCP0AJ7JY+/DXUwfErO
	oFly8b2KaghBQrDawtWEEFwDHSx5SyF2dfwGx4xwaYupM+jWok+DKZISUQdG08=
X-Received: by 2002:ac8:5ac5:0:b0:535:f9dd:a3c9 with SMTP id d75a77b69052e-55953964036mr4930631cf.6.1794420459242;
        Wed, 11 Nov 2026 10:07:39 -0800 (PST)
Received: from [172.17.0.2] ([4.227.174.184])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b451570sm56193051cf.13.2026.11.11.10.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:07:38 -0800 (PST)
Message-ID: <6af4aeea.17e05534.2a9682.eabc@mx.google.com>
Date: Wed, 11 Nov 2026 10:07:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3634211932491300149=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [bluez,v2] monitor: Fix stack-buffer-overflow in packet_hci_scodata()
In-Reply-To: <20261027-fix_sco-v2-1-e3835bda5453@oss.qualcomm.com>
References: <20261027-fix_sco-v2-1-e3835bda5453@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3634211932491300149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [bluez,v2] monitor: Fix stack-buffer-overflow in packet_hci_scodata()
   Pull Request: https://github.com/bluez/bluez/pull/2720
   Created:      2026-10-27 14:23:44+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============3634211932491300149==--
