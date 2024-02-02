Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90414690D
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889299; cv=none; b=URha2rCDa/o+isaKsJdyJ6xEiNXx1WL0ojOGTrV8lh5FREepIC8vvlxZRzHXQwllw2lK0AQxQSvOTG68YplHg4hPPnsOI53AlvnGqbfEmrdvixzehQ+rFhrkH0nGOqr+G0xgz8nqp63SZqwquvhcrZ3N7tMUvR3PfE1flHvnVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889299; c=relaxed/simple;
	bh=dtCWqVX/NT9kIZWcnFcJlCgzA/zKXjTueqyXOGLWEEQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sFFVHqmXHFil4sWMKz0sF1LzeWE+UrXip6Z+VNKQ/Rxu1Cie8j0qU/Cil34O7wckpjgfZSFe6SSALhJxfZ43JzTgeKjT38cbY6NqKDldiXx8C6MD6rWx3zNj+J2ZXqsJ9FG6OyldSOf/BI5+kEo2/MsAGdMKXxHL+/QzHP6PcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CviVEnMO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CviVEnMO"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-686b389b5d6so10099836d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Feb 2024 07:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706889297; x=1707494097; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8y3QZ6XZXSVOSXyhiieJFWe42RgN6UXzdwKfka9CQHo=;
        b=CviVEnMOnMv9Nm3wkPt7Q27cxfe3CNf+YOqXY8Fi8Z+jA8wJXhl7vPelxpS5I25fCd
         TVAaLWh9EMvZNsOZ+3WaiforEn/vFhRiULkuoKG8ZM6QV9KEVgYo4zNrCHWSX2bqHVVQ
         ZoMJ1FXDZoO3SGbcC75KW8n/IV8XSfM27rdVcpzXZzaiiTzedhZmlnwx0/aSq8s8gEu9
         T7DxST7FRNI+dt3mGzTDyhQbTZcppwg6rHr69QDw6J4nnyWhRi7sWzp+5QGlF2Ltc9jl
         Ax/Wi+uHj3Oiayoe+8zFdCriU8aBWrzs5w4yew9LitNw/laWWvNifFYSSrr2bUYafub4
         Z/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889297; x=1707494097;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8y3QZ6XZXSVOSXyhiieJFWe42RgN6UXzdwKfka9CQHo=;
        b=bwlLkqyyyqKIWyIIt8ws86Bl8Yl6UvFkEuwuSfkQp2yb826yoaWNGR6yfFK9DBl3Vb
         JXsSBd4j7xpFRdPuKabVxCLynfriM4VgdgfqPVfSxwYRqgKV/a0QtQnvWn6QSReiGDWO
         tFhmYlKLUdUgxtfo/jMN5pl5UPGMplM8ssECIKmGyojbhF5nhfLp9LX1f3GPIX2iLZo2
         y+luFYVMSoRxHZ3rR5S0kM6ksUo8ziVIVq7+8aoSIho1omnkNsBHaFzM2JHfy466zUz8
         GvmAiZfTFx4/0F9z/6qWSz0f0RxlnvWwQdRJycyi3c/SrP1rwqBHMH/EHSqN6NZgnvAH
         8pAg==
X-Gm-Message-State: AOJu0YwBQm2ntjNeNT4JB6nX3P32VjTrY11k85ljG1LgYOiFWI4F8P+E
	ARy9yRpS0nzVwPnSugqx9uFzXMcWiFuJl8DIVToltTku6M0HY47AkNlOH4wz
X-Google-Smtp-Source: AGHT+IE4lFH0xYR1X0ZVDUvs8XxZpFjP5iOB9J+a5itutV3nUyxuFOoTadHMR091mE7Xrk7pKFA59Q==
X-Received: by 2002:a05:6214:f04:b0:68c:68bd:b724 with SMTP id gw4-20020a0562140f0400b0068c68bdb724mr7556315qvb.4.1706889297127;
        Fri, 02 Feb 2024 07:54:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUXofBKArtOSJsl936gDl3jhxFYn/5rJPjN8WO6l8RS7CzHvcMTT51z55ko5XztRqvpCiDA+W7dqZZ1vsACaK4S3QP5CphOQQ==
Received: from [172.17.0.2] ([20.97.191.97])
        by smtp.gmail.com with ESMTPSA id qp7-20020a056214598700b0068c717f758asm916216qvb.11.2024.02.02.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:54:54 -0800 (PST)
Message-ID: <65bd104e.050a0220.d56e7.5954@mx.google.com>
Date: Fri, 02 Feb 2024 07:54:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3542664899036712314=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: BAP fixes
In-Reply-To: <20240202141036.9797-2-iulia.tanasescu@nxp.com>
References: <20240202141036.9797-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3542664899036712314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822537

---Test result---

Test Summary:
CheckPatch                    PASS      1.36 seconds
GitLint                       PASS      0.97 seconds
BuildEll                      PASS      24.14 seconds
BluezMake                     PASS      735.14 seconds
MakeCheck                     PASS      11.36 seconds
MakeDistcheck                 PASS      162.88 seconds
CheckValgrind                 PASS      226.40 seconds
CheckSmatch                   PASS      327.49 seconds
bluezmakeextell               PASS      107.14 seconds
IncrementalBuild              PASS      2114.75 seconds
ScanBuild                     PASS      936.54 seconds



---
Regards,
Linux Bluetooth


--===============3542664899036712314==--
