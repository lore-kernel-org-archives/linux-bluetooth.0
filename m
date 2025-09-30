Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84B1C68F
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248923; cv=none; b=ODew7Y7/RehvHqrM1jKDtCl67hMZY8TSk4DurYNputByqscg3WzvmRIu1XlB4QPTgq/rH4iNDIx+i52qYEAAJ3FvCv0qO0d96OdmOPrOovg+JcUyuT3/QzSZe2zHpxoM83r2REQnm6vtpFNBEN3nNI/78KGbchCi1xckUAV7UiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248923; c=relaxed/simple;
	bh=7s++99y/pP1fOUn5liUZbcFBoqLBBeBHrzuCK/tEp4c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DHre8XynhHOR8b8GfuQlKIpr44MpTX7odtgB0XWYgS0TM60tiW7PnphbLw+oQ6ES2zsYN9PcQPZT1Q3L2VzerzuocBOWsryDntNfTPhFO81voqvtOGoXfud0XCkzTlThzlKc5ja+qZF927V7EFcNKfVCP9UqrZ6jdLEIYq9IGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9/QJGix; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9/QJGix"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b109c6b9fcso60501041cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759248921; x=1759853721; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6SYOzq2tAKcu8isFJ0ghIFrSQpuK8QmiQtNPZQrH0qs=;
        b=X9/QJGix1vom22aoheR2FvE4EEVszaaEOup9zeTeN6civZ6Eld14uudeNfRJFG7Yz3
         BDVnbodxTvirLk7An4bI4yT/i1ukcLFOBDnB8UVIpW3nHrZGQ6/VSAv6ouUYfkEBlsua
         IbONUwWqff2yM1HPy6XmI1PbY55YyArKhISTdxXDjMC4jng4QhRrbDd2G2dB20PIpmoC
         +uZj3x/SoN0RNEUIgO0OiJYQM+WZb8hhcr9w7oDN/YMEXHEQArlagkk3N/OYQslWHKcQ
         7/Kwh7N1OIBnsbs36Z0F1Vm5F6PpyXJpmEscL06j5O/LgLKVDXAa1ejWl5Ss3zamxmWY
         8qpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759248921; x=1759853721;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SYOzq2tAKcu8isFJ0ghIFrSQpuK8QmiQtNPZQrH0qs=;
        b=fVkXINJPoxWV8sP0QHFiKXxiuP1SqXJoGsy5fWw4motkpMbTX+A62I60GHS+GLdfQ5
         YU/7IwNQ68J9ECdh9MMtHLkYXtyaFrodQzzSh4A8z096IzKefaaIodG+y1hYu1VimwQw
         R+OpqnDT6UtK/El47Gfhj2uDAY1FtrgtEWGahwKH3N5ycr4oTd9ki3yamp9zflzgQrFo
         D2KYV1OuD2QnR+rkt6f9khig0+9C6EXhlNMrHfsQDSHlrPfZ4SwSr90VAiGXJfqzBaKu
         SpwBnAclBf3dKF+G7DEwk3BoJFj59pu4qUZMuSIZ2BgEf2PHfrYI3urBqOPCnAfIXWpI
         VygA==
X-Gm-Message-State: AOJu0Yx9qKsSIvySk+xikn/f6l20nok4VtaY4ki5fsWNimRpVTe2+HIM
	puiM2F6NWsgH05FPd8oFHdjf5LNB4PGyRaLEXSS9LKj4KR1uLzss1MXvkBdRNA==
X-Gm-Gg: ASbGncsfruJE6xj9dfXb7K1G8d4iIKEmbhu8Sr53oskokLdtYLObISwta6qkibci/I5
	YPUMGJwWkN7kKYYBBsDrs13uvTu1e6GOjVIw3mrON9kYFvLhWmMrxVKUsA93dntf1hHOHAjJyff
	cx3dqY7mrz4aFIddeWwNjSzL8iViBjOpLVAqGfKTCPrFHWbO2AGTPmZv9CufmEvPykfZsOp5hxv
	x1J1+GOGKzFeSooa+6tw6lIVTv9/2WJ0cjJZms3bVkmoz7dRrz8T3eL+hf1zQRPXrzZwAo1XVO2
	BevLBT/mWdq+sUyeSa+X1FRn+SjKpak31SKCVke3Cmnd/Dn/eRE5C0cjYbs6ezrEnTewqr8P5U+
	OdwM4OMC0ZEKyv4gE0cGQDz635TdT1S4OBIdiEumhOZKEDepB5vOLP8A=
X-Google-Smtp-Source: AGHT+IHEsJQdVcLu4hEXbziZoqT1rLWVHosXnztbj1sZoeyXODAK+FCfCl5UkFMIIbtnVgbmSUZLVw==
X-Received: by 2002:a05:622a:286:b0:4d6:e02d:6154 with SMTP id d75a77b69052e-4e41c548098mr1598401cf.6.1759248920307;
        Tue, 30 Sep 2025 09:15:20 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.165.225])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db119f0142sm100721101cf.42.2025.09.30.09.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:15:19 -0700 (PDT)
Message-ID: <68dc0217.c80a0220.300858.d1e3@mx.google.com>
Date: Tue, 30 Sep 2025 09:15:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1972966116569428354=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] device: Fix privacy
In-Reply-To: <20250930144627.1676420-1-luiz.dentz@gmail.com>
References: <20250930144627.1676420-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1972966116569428354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1007463

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      3105.36 seconds
MakeCheck                     PASS      20.35 seconds
MakeDistcheck                 PASS      187.25 seconds
CheckValgrind                 PASS      237.01 seconds
CheckSmatch                   PASS      309.03 seconds
bluezmakeextell               PASS      130.45 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      934.60 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1972966116569428354==--
