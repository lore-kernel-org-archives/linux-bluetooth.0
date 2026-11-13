Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560343;
	b=m2q/hLJO9je+vv5FFI78nK135ozHL93F6u8uPWL49omgoUTSUGJwIj005iH3RHnTjw5w
	 xDku5tyHPRMs/nervfpt4ej7/VSRrgtuzBpg/SBL08USMhorb18ZvLHPjwUxnikvZ17zR
	 GR1FBefKFL9hjsvDoAFNtsC9kXlcYjhWosu8eJGPRdS9e3Ucgo3c2MwJR5db/A/qRy1E8
	 c7QzVcQ3Nn6RRsAabHlreY/jhfiEy/Zaw1VKyTfYbmaP5CkaJCdRM/AK3K2jyA0WPuTmI
	 TaXu9M1uC1spsGalTaYGWGaQ9JzFcZt7atEq4hAqCkvXofIbap2TPuqGKIgc4dF7luA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=7Tk3AtqO3C+rJXPhWomYOFCeBK41LoEO/v3tG3IczxI=;
	b=LUuAWSgJ1pXNnotX/IRUrHkrVI4uYxWwl6t+dY4FIJXENefVKBmnoUury5AlGU5R4lrD
	 c3iC0bikNodTHVIjvDCKXUz+vqQtGXLRyW4WXZSwIqqWGe4UJzOu3gDBo0dlPJoB03fqK
	 iNl0JW7a9FcE97JALWJE/gUfMAkwauJxSPjWUJAlxUcPyijRxsAT89fTM3jsJFlSeBLud
	 wqXFtsvttbTYPBQEywaZX7htuIVtEPXzky1lEDzX6HQhlj/HSnBw/3IH+2WpVZO44Gcxc
	 ov0TMyRdJlPVDUWvlExgxm/01zWi22jkHgO9a/ATnfsjcZb6/a1UCOKAjBq8IlI6Meg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QWojgHt7;
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ADD606A321
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65ADD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QWojgHt7
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67c02c106e6so618571d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 00:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794560342; x=1795165142; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7Tk3AtqO3C+rJXPhWomYOFCeBK41LoEO/v3tG3IczxI=;
        b=QWojgHt7au2WX1NBH+QY9AtHB8dMlbRGDmx0iB5yJlQeaBsVPnqyp6RxZxJYTDB9t4
         R7+9qgAtelz6IW6a9GZn89BPa5HBKrl5wgmldHwds3RGSwH0aWjo2wwlvm1WBZ1RDIjT
         +oI2eYGYAC4WXdvKeYaOalO1zXj3XhlLuFZRnc0GD9utUECxF3q8O5k7q8+iCLOoXMbz
         NHIVfsOj4gbs3YnwChaAWlmPzubUtX/yJHO+96LxhmYUe2TVkBXDms+uOjnzroTWSf0/
         fKqzDTQg4mZV8ihfJ2UaX2sQSQPZ6veGFeNgIM/FTA7VUcy9vj/BOZWLzP4PJLK6mbV4
         PFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794560342; x=1795165142;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Tk3AtqO3C+rJXPhWomYOFCeBK41LoEO/v3tG3IczxI=;
        b=rMakDnSEndkHq9vKVxe70hhZDk3sWkZPZkqJ+uB9sIODYIDtDj/mUshEUAJNLB/YY1
         IpAmk9RV3RMUGx3r9rK/oyF4MhqUQncFMZ+NpRMApVo596GtFRIQVwz0Dl2Dx+0kR56P
         9W1W4JxF/XqwzMr/9R0p2hZCMe+OsNgLtH70+a8Ami+B7L/8GMQoqSvzMAy0oHQ/BmbE
         /13y0HnSZ2HychO3pxhkfYeipGJvmkxJd0wnNhV0xSsd8HdPcr3vtg8IeUeNy4nscx4X
         H1XqsRi3XuoewatX6TD7jD00WxGqPivvhEw+bUoGwlHtizHx/vUJeHwTNCaElcwTJYdA
         D/DA==
X-Gm-Message-State: APuU4Z+eokkVFHjkFqlZ3pNcFtoLkYEtn2tcEBjoELtyBGnyES9SKuNE
	KYW6UJ7CyqRhoTqu0fLPdfkr3b/VOJAye+aWVwe2zWL5X031epIIjhHC4WQQMw==
X-Gm-Gg: AYBFou2hfymtxhSOMd/hG6jFyy6txM22UJTSEcBfc9u5Z0cBtJjoa/bgAsa5ix867cG
	8u+Zs7kwELsWTvcjCZdCchkv+73c0+gReenGqo3wOcSDQPRYJreZLTurB62wypTYA1UOxFS1dPP
	Wb9NYEbpO9UNH2syv8JF/gAu/kJT8jYO7UcIoduiVrfkCXxz8WNhQWqXU2Kex25wfw999jnBRo3
	x7tOmkDmCJ8buTRvPDoIXKxpzk+Nelj7D9ckErktyJi2Eo8BxBak69BDYm2PSvt+au/hIg0tNEY
	rD4oHkctvLJvG6JTUAOSmchVKqpBh41XHOQs8NtbOyPXxtMjF3VSc2mkpGZHOYKD4y/MbNK15+D
	42lY4fJZYVBRYD56KzRGF+u3+deHU0ukYSwfg+lh8hz7iPzRPyOCRJFihtldxlZQXl5w25LBdxR
	Fh9rdDekVZqHGcfaVAsesM9yQg3kpeANAU5mapUizy693WTZd6IEtj1fbjX8aWfPYz5TSRNwJEX
	lSNV4gnlccyA0uy0/VLp4OD6nChXu2VubLqCuXBy0DPWB1mbbJ3GgHqzhSn
X-Received: by 2002:a05:690e:191d:b0:679:985a:3fc3 with SMTP id 956f58d0204a3-67d897dd712mr1360485d50.85.1794560342180;
        Fri, 13 Nov 2026 00:59:02 -0800 (PST)
Received: from [172.17.0.2] ([51.57.147.1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a5cac43sm1498528d50.14.2026.11.13.00.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:59:01 -0800 (PST)
Message-ID: <6af6d155.b530263c.39147f.7ad1@mx.google.com>
Date: Fri, 13 Nov 2026 00:59:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7221126048141125505=="
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
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v6,1/2] Bluetooth: btintel: Add TOP silent reset hooks
In-Reply-To: <20261113052538.3030771-1-chandrashekar.devegowda@intel.com>
References: <20261113052538.3030771-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7221126048141125505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1210172/

---Test result---

Test Summary:
CheckPatch                    PASS      2.42 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.64 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      28.53 seconds
CheckAllWarning               PASS      32.04 seconds
CheckSparse                   PASS      34.40 seconds
BuildKernel32                 PASS      28.16 seconds
CheckKernelLLVM               PASS      28.75 seconds
TestRunnerSetup               PASS      672.69 seconds
IncrementalBuild              PASS      27.22 seconds



https://github.com/bluez/bluetooth-next/pull/1126

---
Regards,
Linux Bluetooth


--===============7221126048141125505==--
