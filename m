Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723759;
	b=lssuJdTJw6DuDxMAzWf8VF12Fx3A/QQRUwsEuoIMhnldMMBM9yJNMNMsVM6JFYmjSUL+
	 ZrRUhHX++uYnS4bCrLunZu4FZ/VnTY3tDj4P5MmvRHh0SyPwf5tuNtA0OrlF2PFAsgx33
	 Qr9bQMPV2WTDPebbz7rllLlcqwybzrPsfMK6eAwdaKJXM28k1RsXnBSFcdJDA2l02OH5s
	 gB0/h7mKsofC9JmBmyUwDtEGSoiEctJYZriMnW4kWF3k8OBvPlgZ8G7+6hd53QA36Waj+
	 UqXJNXCPrpHTbLZAN+PDCKljPNNnQMxu612MjS0UgmwoIIeacqk3wjbDxFtNDmIZCgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=F8MAX+B5I2QEqURPNmgQ9DTVSy9qwl92VQ2uBFxFCt4=;
	b=j51AYwQ5Y8NvLCj/LWMKBJQ80D52xuS4uZPcFd/K/Cp/sIlOttkdEo7W0lg2aR1dLFKO
	 TuL83/VNtVfm0FA1tlzrp5k93O9VnbXAyyl+xdds+wJSKpEjg+0liJujE/oW6y3cu/U8P
	 KP3FEZJkoikDPb98f3mwKDP/xJH3v2+Or+9fQ4eig+PxEyVemk2z3uvXfXyT5OngzSmrJ
	 CfhbaUkmvxSkDiR/HQmfF4CD2Jdtkqf4jnIbYxdELgG40fJvq4yrHyeRxFj24Tpo5d7Kf
	 DaV9d43J4iXXMteJeN27NmPn2jfvM4F8DeZN53ArLIO3ugVEHnZaEMkZXf5HUH5VBgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e1AjSryI;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C4606D801
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 16:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D77C4606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e1AjSryI
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso3080123eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 08:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793723758; x=1794328558; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F8MAX+B5I2QEqURPNmgQ9DTVSy9qwl92VQ2uBFxFCt4=;
        b=e1AjSryIDU9eZz1kETalG3ccXjYEo3Jtuc9Eren2YPj7NiY0ixrL+pxlaDVt3Cpc5u
         b+HB0Jy+CzUJGIEvAhqUWAb53o+GtWwXecmYHcyzzLtDYdbsCOnKvKCXk3mr4aJMshCz
         RCYSL6TtckzesKOuP0ceudKFtoPpReQGZgbXx/9qeLn5tlXjfengZpFVVrQXfKqE7I8x
         g7W+x3eD3X+JqWoIze/rNGNKm2Mb20RBo+uUQEjxDUgX8qew1gzQqNMUZ4SyQUoxEa/E
         KOFuRDOXRlNzkyNrEUF/gtfGrry57eulx9NPwP+BCO6SCyIW9lxQGqKQiKNjIJrrFEuK
         3ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723758; x=1794328558;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F8MAX+B5I2QEqURPNmgQ9DTVSy9qwl92VQ2uBFxFCt4=;
        b=MElRMtaE6U+011KD2VdepKS3hVGkmqQ9PifNeVThu7TUipd18byV1CHkIxeYkg3PGO
         Wg+W4TOtHNTNs/1ybCw+Lg2zOhuu61ZM9W6h0Xum4xP//kFJTyaE+mVoP/xyFklNlfgU
         YAbwwrKiKkF+qc6s0dfAcib8KGU3pHP4UWrh9bAH3HxCGxEDEt5L2lGJzZZP31X3l1wb
         dKerZzMpi0LpVpa5lKZjmYhJdFWHFUG6oVoWtGvnkX5FR4LDvTclcR6cCl0ejJI4ClRk
         k/xwGjkqewjY91uDZu3X2yR4mw9cpUHSnnN6s7+Co4R0RqVjtt16+OVe8rhs63W3QOKi
         UTrA==
X-Gm-Message-State: APuU4Z+zgsAAbmr3vqCG9GYy/66B5GNNgZ3M9eYDIZ6I7mgXKUAJO3uR
	opa39VTMB5vxKJle75P96DNIxy122zqezfeOe9cCv2/ZtpG/UI8gP66qe8bD2w==
X-Gm-Gg: AYBFou36nlrZWJpVE1p/WQQXMucQL7tPX++QT9UhnGhjm1q8EDYz7h4wWJBQtR2goqg
	FTv+Znh7ruuYkce6oOVjJMEIqQs73qCjYzAyjREwjWKXOZekf2QdGmLpd/1V9iclgFBzVX8Ptb8
	YYnPq1H+ry0RzfXQIOdPD5WhXxf00f5Qi9HCvpz0q88zUwDCPWsfv8ZD/0p1Jl6+FuvjlOi4WmV
	mAq3NHLBAh+dvgkQpW5ELTcR3+5vF/pFmP4U00y+IE4I7/cnJQRCsGLoirBcJ5xomCfYD5spN5R
	G8aaJDsn+CsqDJ9EBE5wD16N68/z+w48PKxqgeurNuUw2G/zflUznGx3OdOc/mRdpDjy0gL8Vrf
	9vJI1eslRwmROfyrxqql6NkjOC04H26M/icA11T07fJkUKIZ2LmTD9rZ9hC4ugeYbwRS9Pd0YYA
	7PNhwzFFhf6QT9pwA68waJ2LDrribVtmkrm7cduaCVYWcOcQxhE1XhlLHO2jCv3Arjn+GebNpDS
	zBVSjt0j8eoTaFwuBDFwc3wTH96xpKl9nAEynlBwbfrdw8xz8DyifbZNjaerUiNzg==
X-Received: by 2002:a05:6820:1341:b0:6dd:a0e9:1f0e with SMTP id 006d021491bc7-714f29c7a61mr8622354eaf.43.1793723757876;
        Tue, 03 Nov 2026 08:35:57 -0800 (PST)
Received: from [172.17.0.2] ([172.169.254.168])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921a53b59sm9310818fac.14.2026.11.03.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:35:56 -0800 (PST)
Message-ID: <6aea0d6c.0327e69c.29094d.4596@mx.google.com>
Date: Tue, 03 Nov 2026 08:35:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7299607099864274363=="
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
To: linux-bluetooth@vger.kernel.org, mitar.git@tnode.com
Subject: RE: [BlueZ] mpris-proxy: Stop and start together with dbus.service
In-Reply-To: <20261103151724.598627-1-mitar.git@tnode.com>
References: <20261103151724.598627-1-mitar.git@tnode.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7299607099864274363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1200507/

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      14.06 seconds
BluezMake                     PASS      181.99 seconds
CheckSmatch                   PASS      179.86 seconds
bluezmakeextell               PASS      66.63 seconds
TestFunctional                PASS      930.63 seconds
IncrementalBuild              PASS      177.63 seconds
ScanBuild                     PASS      604.51 seconds



https://github.com/bluez/bluez/pull/2753

---
Regards,
Linux Bluetooth


--===============7299607099864274363==--
