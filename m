Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372046;
	b=gexneA2NKfibvtp2JQF/IFl7S5azkpqCPZwvGmK4OhcjiGeOy0yGxWFjf9K+nw4W89HJ
	 WlU5hyfHOpQW+5XaEHgS0HJiHoIAuGt5LApEN/T3IEe95wtwie69THbL1ZTrT/dWzt9Bc
	 7KjgeoARdY3XOtg4i5Qj55HAc6MnsFwvCr5byibPbbxXtOdO7t70RIqn0FFtXk/E9SWC7
	 nr4ZZ9dWH43EcoIaAwD+bz3BDK5mC7katfDsGnd7akZlSoQBoY8S1wqYBikoSmiGcDFs3
	 aTk5pvg7obelb8uJP4NvLxYkar7Sz4q1SlimDeHjRS6FjUI+PRCDSzPIEKkew0ZqLAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ZjH3Hn5F4++vYDxVYFdTrNZfBM6aXpdkUNn8R9XRPWY=;
	b=LCdL9vZlMp+dsWW/lzvs74/a1/VLvf/GoJHzSegt8LjgeOL/sdDrQoBH37MX3XEacTHh
	 ruBmIi0RpHFIywxVM53ro+NJAURazxqCTQmI2/5yvnOFoAzoiokwnwPV1dC668EYWtY9w
	 +NvuMw6leVDvSLd0AfraeLhDIVsh1jH593cEFdNBg4f8NGAKPFc172HJhDd1/RjDKQw1Y
	 oFY9rQ8XcREXAYbJ0jD6qewHJ25x2qNbL00lzOI6g7+BX5Bm/0FWCXPrI9h5SQ2MyMEwb
	 EdVXLn929OSwVfdB4iZWx7ZFNtPrO8Xw+Y7zXhOOmZnyuYGGS80a9UIXpE6Kj1yjF2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CaCKxcAx;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB730606A32C
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 18:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB730606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CaCKxcAx
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-57728d87699so1012876b6e.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795372044; x=1795976844; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZjH3Hn5F4++vYDxVYFdTrNZfBM6aXpdkUNn8R9XRPWY=;
        b=CaCKxcAxVTEEnnIgqLmJrFAf3XA/90xkasxVxyl/QV3kzxWiv8L9m6aOwZj7zr3LJA
         b+LGSykMLoVcDhNUJE9S6Ke8KcTjBFUiVKfpR0WKSjWLDHWrduOp5Q8ct9mm9JiyCjX4
         naDpMLZA4vc/T9r/sniXcZqhAVtmhmdVPMHn5ggww0QVWmnUAUMZW+XRsAqKb5WyZT/y
         KMaeWmh1GufIizjN++HbZIC/NhwueO1VIMufEXMaUF1n/PsVRGZDSQqcwGnMrTCkS34i
         v2q88734WP8xcDDYIq/V76ywU6fJfTeU1nPG15gcxp2YhVf3xqoql10TqMrvehKZJOk9
         rQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795372044; x=1795976844;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZjH3Hn5F4++vYDxVYFdTrNZfBM6aXpdkUNn8R9XRPWY=;
        b=oedcCEdWb/BkQPitIOfXkCQs8cknO4kVKVOhFrn6Ba1YQ14CWrdT+4OrZVutZHMlEe
         ZgTSdz6z5YwECmTmJ6tGdGVRjN1XLxvL5UxPxqrJnek4A8GwWxHC+J6fleEtlYBYQMeu
         gwUUPiDZ07nVCJxhMKBXLxmKI/6vBHhS0n7lihi52mALAGmPJ/CyFcEm7mkx/OEZh8fN
         R6a1GM9ZBM4Y/kZI20hf1RGcBcBtGbA2TtTGasYsm87SljiqFcroBq1CY/zig55gkWah
         UYc5fh8dgIPQDoR2zny0boRHWpN4II2086r25TZ/AQSz6zsPfsmxNjIUgk8TQGah+Cnx
         /Icw==
X-Gm-Message-State: APuU4Z8Gl6/uVRLMOuIAVCyuSh1i4MeoBUhEKruzQirrm1ccdbPseS6Q
	uvY2eFz33l15AresjJROvRI5j0b9qBPZYWr9UQHHfXbNoc5BrwjHiyvEdfvoP2P1kDc=
X-Gm-Gg: AZFdTZelFuAZrmZFD3WZR5cskmyUOS+6L/7jHWDa+DtaJl56igu8am6LTK9ay1clH7J
	4/ZkETl7G5zrV45BHQV67/JZw8ITJk9vYvnFGLUb45Icy6BK43d+oU98TdoAIyRDPyRNMFH0+sS
	rgMadT7f20SVqy5F6ValCWSM6YcpjifNpWWC8W6qO06kLCsLwbmrUoqizbXP/aQvUtoHfawMzzV
	29zWWDoCjQurH79O1EN09TG1Z3XitDesOgBWx6UmQhr7tHqYe+RQzjvYge3uXdp0fmWBqtfRyJV
	176jsScSN8PZ2EnEO0nasZv57h5ruSU5cMeHu5HKkiITfhEZyCVAbX9XvkXKoRIH7TUo0yt0DFI
	IiCamCPu6d50VRL3NWsPfk6Tq2TwiEj2xcH5Xx2NXZMutt1yGNuZ17TRpX5e1fWbqrpP9fUj29o
	aMms90qWY54NFQdp++VC0ByrGVP9Sdg4PStGBed/aUBEc/CtsUyDZhxajVX3cfonlz63iYqO+zX
	6LgnPcH6WtrkVdrWZUEjxhaqenSI3/90FJN+hbcadpt1ktV1oaoAJjcFkxyPCBe
X-Received: by 2002:a05:6808:16a7:b0:567:c40e:c79e with SMTP id 5614622812f47-57a0a7199a1mr9287549b6e.24.1795372044487;
        Sun, 22 Nov 2026 10:27:24 -0800 (PST)
Received: from [172.17.0.2] ([172.202.54.180])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc61081159sm8847326fac.15.2026.11.22.10.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:27:23 -0800 (PST)
Message-ID: <6b03340b.73f9ae50.260d4d.6be3@mx.google.com>
Date: Sun, 22 Nov 2026 10:27:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0598906704658209326=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] adapter: Fix discovery filter RSSI and Pathloss matching
In-Reply-To: <20261122104139.714101-1-simon.mikuda@streamunlimited.com>
References: <20261122104139.714101-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0598906704658209326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218575/

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      14.91 seconds
BluezMake                     PASS      197.94 seconds
CheckSmatch                   PASS      192.93 seconds
bluezmakeextell               PASS      62.79 seconds
TestFunctional                PASS      886.67 seconds
IncrementalBuild              PASS      207.21 seconds
ScanBuild                     PASS      675.94 seconds



https://github.com/bluez/bluez/pull/2869

---
Regards,
Linux Bluetooth


--===============0598906704658209326==--
