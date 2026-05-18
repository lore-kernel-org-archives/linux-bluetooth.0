Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48993318BA6
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097708; cv=none; b=ghGZlRLj+Nidg+a+jQc7qesCNzgHNNPWJM3W7T1n3XBZI0Jowz0RoAREWu9Ead234edp285sN3EWq+aDXYQi7um+mxcwR7g7cgHyf/WlQsTjqmSQOC9VLUWXoL2wMYUESROGf6qE1iHNz86OnjbT0XUKLUwK6BGu7/RTtpWF7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097708; c=relaxed/simple;
	bh=nuPyyKEjdlfQb8iOQ+CaULWv7QJIPqpvmMYTJ4Vv9Yc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oty9rKxfLM9V5h8N4YRJgxEgMIOSAVU4EmjtjdcDcD1jZHJLRPuLc4h4Tp2kBUWmT6leZnt87ypq19PA2u+woeqw/vaWnWMkq0gOl/CH5O83NjZtTsmXZWLwagSgGbZ06y9UWTF5WiXLI36lG5YAsh06IitVjUdPVCUNeWEGmLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLXRasmU; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLXRasmU"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-911dfc86903so254631785a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779097706; x=1779702506; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yPWd3mnt1Xys8Zjbv/ZIZ+pxPI8zOiWDbgaFJGVIKRc=;
        b=jLXRasmUAwUwSNgmmFSYRPgJCeSYOSGzRRTwuLeMpClg4DrNg7ULdGR1W3JbWwFt8g
         rdc/nspzul3Lb1GhXyM9DIpPSVArdoDbdr0oi/I+Rh7UNLbNlBlQIoKfA5m3HQ5MLWuQ
         r0hyKKoumVTfYagDwLreJKFRZxKNPIvSZY8R+u4u5W+8NkQ4ucarU6He9R9y13QnkpOP
         L+7/AZOgvPQEAga9ovJ7nNBKESBXzeghtxYM8Om/GMEzyo71RIGtnfdGYDo0Xx2mKmQ+
         KVxMbriRmWnBI6nEisulgisx3R+laF53kBdIlBSkon6CUBLIFf/D0W/DSEB9t5VYmqsa
         u2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097706; x=1779702506;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPWd3mnt1Xys8Zjbv/ZIZ+pxPI8zOiWDbgaFJGVIKRc=;
        b=O3koml6minJldiCJF6QVOF+XiAHYGu8E1nNaTbfEqLIAw/fM0vKV11IioCWf8zCSzU
         qMVIBA3845yyh9ikyO12s2iF3HGOwQX7AQEJDpKreDeqeZEcUGvkvi9W1SvNWrNyJwUn
         sZ0acUL13x7Xco2adYD5LYurAb5oRDdATCHjq8iwx0W2oX6xENxrSPRLVJugicW6iGWZ
         GBJ33ap/j9ws3ExBjRp7ydmrkEQvJE38T9ke3YLqZkRh8sfFanqG9YvMWKq5xVfq/Bcy
         fILTt9eV0omyxLD9cgdk8cuoSO6y1rvZmYOcSuaRsdhJACtqKqN1+3NPbCk5BRTfilQQ
         vcmw==
X-Gm-Message-State: AOJu0YxtslWNyMVdoOa36dWwjuY5oTlsOf/iK9dN4VC8paXIvJn4/s0/
	/jKCoQf3U3F7VRSMQhhKIHsAZRBxaqQekJ5dFYcJs20BvOeOgPSThvGyVCetKA==
X-Gm-Gg: Acq92OEqUnSUd3xKShvBbdN3B7FoUJ5FLeIWZLwZLPx7RjvcBol5Z6ix6OjPPN6md82
	cq9dL7S6GxwLbxkNSlXCsgfJHOQX5id1xJElizkGmOecYIMHuLwB2hcwFHrB3i7/5V+FxPMPQGx
	MaE6JOh6uWLrx2202+h5TjX6Qdo4e3N6FusoePWRhVG2vItJ179QbWWKdinLbfxLCwqFJEP/XHG
	EacqJPa+2gIXbPjl+iiDnbHUX1lCzc5a8WWpcLgSlwYxalUh61j8+XIUBotFnnmCGQnVCLv4dXN
	gSwn6PT5gaq2kLnBP88d+Gp1PA8mLmGUClmoB0Mt8wv8qIMdsjqwcAaWY2qSmwToAwRaqIO7cbU
	6YmRrqG1xLGjyiO9rceoboLU0n3Fk/iQ7E3AjE1GkG8u2oGVFbG2rJUqeC2PB4/XTKulkorxEjM
	6ZM0zLkCos6WQjTbZPbdh59ldwJrnTPQ==
X-Received: by 2002:a05:620a:4102:b0:902:e991:f3f3 with SMTP id af79cd13be357-911d0d54ebamr2188058185a.62.1779097705766;
        Mon, 18 May 2026 02:48:25 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.135.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3619a384sm50408336d6.35.2026.05.18.02.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:48:25 -0700 (PDT)
Message-ID: <6a0ae069.47d32e62.10d8f3.fdcf@mx.google.com>
Date: Mon, 18 May 2026 02:48:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7864233887089983867=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: [BlueZ,v2] device: fix inverted NULL check in gatt_db clone
In-Reply-To: <tencent_017770C54B37BDA20BEEC119272E1AED0608@qq.com>
References: <tencent_017770C54B37BDA20BEEC119272E1AED0608@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7864233887089983867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096354

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      638.98 seconds
CheckSmatch                   PASS      329.58 seconds
bluezmakeextell               PASS      168.02 seconds
IncrementalBuild              PASS      630.07 seconds
ScanBuild                     PASS      966.30 seconds



https://github.com/bluez/bluez/pull/2133

---
Regards,
Linux Bluetooth


--===============7864233887089983867==--
