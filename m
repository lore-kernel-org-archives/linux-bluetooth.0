Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E52D609
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601247; cv=none; b=IgN1E0PyyPnq7AHNI7N2PTbdi9aLrfWE1FJ+Fb/naeG+1o18q8c65RhmpLyo61FPMrRxa/s4YE8a9X2uz7pMbDd5lPAg4Pt9VZcd1amlyFfBAqsNu9wxhdZ+vdhEQ/Svkeq+ZD3WzOqQwJ6QtFTe8ZJsLW8ZAPLLWwcp3vb9zd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601247; c=relaxed/simple;
	bh=TszZ9pN8LFiSccg1hun7aBDim/uKevyyhmJFQ1JYh+g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hymPYTm9YsWXc101M7q/HGgT8UieSM0Gzhtvsm6FRIlRvPSbfOWZdK5GVgFTfTV26lrqZwBKz8JnvbE+OVQRO/6C8S89M8KOIN6aHEvKnpYfb861EuRxYynj2VvHspZ/NlS1hrRbgk4QNJXsl6/QbbjoLMxTaIy18EGPcx0dabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+MKxeEm; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+MKxeEm"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6817a4a7bf2so12326386d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 10:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705601245; x=1706206045; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+9WXyrvUMLGuS+64eS4+9UIJ4qEhJqdx/EhWXUSkp+g=;
        b=b+MKxeEmk1XISrAXgdVLmqW0/F3m3zzpRjmmbY0fCyk2pN0Gg/dZf7Umil76o6YI6h
         sLsrIWwcYW0DDMwVBzFr0UnJlcQpz2QIPsCEIQusbXcJRIkcBr8t8jHnaGrM9R0Pq6SQ
         hM8lWTmK+QxL+B17Wdn+ZSHcFEkYnkAv0gvT+ZFU2krTDVfjspF5xsdGwqzEbVmBTmO+
         AH8373GCONxD4QYQfY9DQpqcyCvYJf9+lrZCDCfRoXfcbM2XfIik6kswGheE9KpL4SWc
         10D+pgste5+lAbTkuUuKZXhS4eg3cU74B3orPc4o4uk7rkp+o/BhqZMSxwtGADCAiJvq
         M5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601245; x=1706206045;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9WXyrvUMLGuS+64eS4+9UIJ4qEhJqdx/EhWXUSkp+g=;
        b=lrhXWxh1tmwnfZPEj2iNHQOe7F6vKnxSYKtPOOQRVF18yq1RpUsQ9K4c5bruGhr7Ej
         DxLvnhEVa8Qw9FrYTNX1oRml/JOv2WmAyplKPSKPlgXA0kZ7XCeSMXHvNkanLn1A3i3e
         AwmvpfUkGo9OIrtdzs4SRP5k2ixMVmxpObL63SAqw/dQOe3Zbkpo3nx+knrLummFZzIT
         aA7H3v/QkZr84vSzcd/5Tg8rEIcMNHMLMB3JelZNMp5j+AVTw4VXiFAWlbdwKYueEL4W
         tUhfF4duTljWTGYCHGnxA7kzw5imvV4anvkqZqQ+L+SBLeNNUDbU1A1X6hulbh2+OOoU
         VGWQ==
X-Gm-Message-State: AOJu0Yx4+IBtUqqqK6kUWbaU39mW5mi+tWhJzV7umGEN3+0A6lnmKNDR
	0ptEo0DiUPpahlH+WPylfhmQG5afbkgSzTJ+InzoVPsRgVAWFlP+wOaEnebR
X-Google-Smtp-Source: AGHT+IFnu0oU2J8+48yBq1jYRIKmQw+Sn3cC/2gLikfhzQWhoVtMOCJIgOtVqQDJ66voaThLl4Vy9Q==
X-Received: by 2002:a0c:f286:0:b0:681:241e:10d0 with SMTP id k6-20020a0cf286000000b00681241e10d0mr992861qvl.3.1705601245222;
        Thu, 18 Jan 2024 10:07:25 -0800 (PST)
Received: from [172.17.0.2] ([172.183.91.41])
        by smtp.gmail.com with ESMTPSA id oh8-20020a056214438800b0068177b3c257sm509376qvb.141.2024.01.18.10.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:07:25 -0800 (PST)
Message-ID: <65a968dc.050a0220.3cec9.34a3@mx.google.com>
Date: Thu, 18 Jan 2024 10:07:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2323646564486857433=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] player: Fix endpoint.config for broadcast
In-Reply-To: <20240118170016.2001865-1-luiz.dentz@gmail.com>
References: <20240118170016.2001865-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2323646564486857433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=817896

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.06 seconds
BluezMake                     PASS      724.26 seconds
MakeCheck                     PASS      11.84 seconds
MakeDistcheck                 PASS      164.15 seconds
CheckValgrind                 PASS      225.41 seconds
CheckSmatch                   PASS      327.35 seconds
bluezmakeextell               PASS      106.65 seconds
IncrementalBuild              PASS      689.47 seconds
ScanBuild                     PASS      943.49 seconds



---
Regards,
Linux Bluetooth


--===============2323646564486857433==--
