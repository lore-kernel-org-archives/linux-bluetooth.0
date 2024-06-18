Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E4313DDD2
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746939; cv=none; b=AJ2OtU0ltPfsp+bTS3ApRgbK8VkvRtAJqfqykLVMKpm8MPGKXddElSEZ9Em5VwU9JVJ4Z3qwnwSwR7Son5Md8XVWEzFTAEnYK9h1lPChrBuIJbUAX5FJmd57CxmP/G27qwObAEVpun+LkAONpjL/h7AJZUVEHg7abZdQhTEH0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746939; c=relaxed/simple;
	bh=r9b5mbuS31RXYYUSM9x57cvE5IJO04UClV+6sR25Pqg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gYlVgoCTeUQUueXPrE+QFFuBZN4xS6AXPVfNTiXpe/SoD3PNYQnW+YFkSlJIokMpGiMQXwddru/ydzccan1oSsyg8Q/Ac+zagzZm9s/x24xZvv6lhUkHmwINJwJ8puQkm5YEJ1gBI3owZjey0pkKBcgz6RG40hxtoRwgIoliqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C905l3kD; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C905l3kD"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7961fb2d1cfso505963285a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 14:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718746937; x=1719351737; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ycMwr9dFTHKdU+Q6UNjxY4gy5X1hK3nBTC//5i4KQ3Y=;
        b=C905l3kDz2uGVCRtK8vflo+Ji9iOIhyGBUuwkoNGgR5HbOcUdXsSYwmCISbKr+/63d
         1fFiYEOvCVvMBYglgcmrvDTUF1pGnoRicGMo31h1Vv4JqttZjb11FDJ2AAzUd93UZiSZ
         YW2O9ibuzcFNtVLwQbxrDG3aq9sG2TzESaKZkVaXPCTWuaITaacCDxFNdqIlTeiREdCC
         WT6KxbrZTynJNjJQjggX8H++JNTfvvEnGgcETC9RKdWZhHbBxD9M2VdBlewEXkczoaQn
         KSr8ErS1HbUugUd13dLB+DNlxSbUhSr9k6DsnUqqBlRJGVupnU77xTyUhqsbem4uBzxv
         cJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718746937; x=1719351737;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycMwr9dFTHKdU+Q6UNjxY4gy5X1hK3nBTC//5i4KQ3Y=;
        b=DdsR44l7LG65vh9Uca1H6+e07u2+KiFm2QZDDnApY6wivjVgDjXFkQhbVA4u3EBNqh
         MHP0eqRLVgtXq4AnjUzKSbyYoJhkNuzwD3shDxqOss/4ToNt4W2SM45Eq2WtVEtaFZog
         LiLFw3wx7PflzdBT1jfJB5N4MH3u0inhRWg6+cs+q7n5LbsRqt4V3m/+velaA7X8KiD+
         4gPTCdUSly7Jo8pIYZOprdRtLc8F5kOFP//U3rk113XwTRBhUz4/Cdj2Ym/LF+ozZM7x
         2/s1H4Tvhyc/5yYBu2u9TQLvgWovTpUj6NaKle2mluaDoTMP/QqE3UauesVxO6nm3EVM
         +ljQ==
X-Gm-Message-State: AOJu0YzUeP/IZae/itV+PFh1LFScYuhaYSLLcR39P0ICMHo8Tizu6bQw
	G5tlu7lnkmI15tEa0C3uSsC5inoyGDEhg2rL4+rK0Efeo1OtUo6kWwo+SA==
X-Google-Smtp-Source: AGHT+IEULxxJjKHPjDNG7o0AEtn2+0PiTWrEnxAKKTgw3yxURMxl1qR+DMy0NjT2xCqvwSBtjJyp2Q==
X-Received: by 2002:a05:620a:46a5:b0:792:f429:9e9 with SMTP id af79cd13be357-79bb3e2dbd3mr116523785a.22.1718746937065;
        Tue, 18 Jun 2024 14:42:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.52.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc09310sm551230485a.74.2024.06.18.14.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:42:16 -0700 (PDT)
Message-ID: <6671ff38.050a0220.6e4fd.1b1a@mx.google.com>
Date: Tue, 18 Jun 2024 14:42:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5551805570959143071=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] gas: Fix reading attributes on every connection
In-Reply-To: <20240618195914.2470373-1-luiz.dentz@gmail.com>
References: <20240618195914.2470373-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5551805570959143071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=863185

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      25.24 seconds
BluezMake                     PASS      1704.22 seconds
MakeCheck                     PASS      13.18 seconds
MakeDistcheck                 PASS      177.53 seconds
CheckValgrind                 PASS      251.05 seconds
CheckSmatch                   PASS      354.30 seconds
bluezmakeextell               PASS      120.32 seconds
IncrementalBuild              PASS      1491.98 seconds
ScanBuild                     PASS      1009.63 seconds



---
Regards,
Linux Bluetooth


--===============5551805570959143071==--
