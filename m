Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429539B97F
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252240; cv=none; b=cpANt3AqLH1qOOHV4bZ35s3sicysxQmI42IqfngtrDlzVdZwMwJPZEG1Os1KsWXB5feFZgiXMXUzyQnLHZ2ZfsGSHLXtWhtfW7+YS5AqbTUHVv3bEfPQz39GxDp/kNYb869+wul8nFDtrZD2vh7Xx2U8D/vK+0paUMo27t4BQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252240; c=relaxed/simple;
	bh=2ooWq9yjg+xtQTD0Uk4qNycfYcJdITPAIBwYvQwsGmA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rATbO+BenYrtHhKW0N+kCZgX/2cHcj87RxdYy/p3bPj1JO5tKqsmS16RQgBPj8/1sbvMSofTa9FehxhCGvdyR8B2AXok2g8nwhiYJuMCHuLusf8ZoqK8HXshocfLBhf4XQxC/P+FtJWA5nQfe2AIW33/G1mkYwsryr8J5OnCBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ3ZHcvP; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ3ZHcvP"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb63dbd229so77284a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787252236; x=1787857036; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xP4zX0mSR8oB6OTOUBIF7CRqxGARFl4sma/WgXPuyt0=;
        b=YJ3ZHcvPRhSW/AkRAXgKugZT3NmJL8f9Af+GScwhLcOxe30/rTquLLeXwv5v7Orz/R
         z14GkcU892KQWBdsBogLeNKtlwGATdp7P+Tbhw0/UUVYeGdh+p1Mm1MXA8TdK85aONqm
         VNr6SMQihDKJ8hdljHV+m26L9dUE/d/jwvoQq6bzwRn+iMPIjEK9LC+fQHZh4zKEXxgv
         q1KuFZf2pJTExeYLb++yzAeMYnlFxrbMpttcTHIQd/I6WfO/rZ869Ky7in5ZKNGKdVhx
         WL/1tfSc1+wka2J3Y74I6kR4DXzbGEmI8VO5/yUucPquYoweKyh7D4Vf9jBeHXrtlzI1
         qs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787252236; x=1787857036;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xP4zX0mSR8oB6OTOUBIF7CRqxGARFl4sma/WgXPuyt0=;
        b=BB8EnWvMG+fwJ9y2S5/004XO6EPqOwRU+QjyQXo6eJA3snUwg0TdwuDfPiqrCa73H9
         kOnmZu097Resxc6hyr899du3VYF1uRl1NBGnd7V+YVXEfqeF7P1SyIBbAgQQWYzbBUma
         KnlIWkVBrj+5noXZRHsZd9SS3YYibbR9vCDhq4aOLPl3ZDAWEVejTXZEazkjEeWm5vqQ
         /As+TFbj8lO1hUQG1Ljwttz4uyKTjsBipBXViIyfg0Ok1I9D4VZUw+4Kn3YvhZ80twA4
         Jc1jG5DR5aX39s4TGfGylR2rMpXzjp8O4K8Pyj8eBRI1DBHE7sl1e01Cyt4PKwMtnMii
         OIjA==
X-Gm-Message-State: AOJu0Yx7Q9wFRbxI6nNAOEGuye8WBDczUwjMoi4U2YtGwMfn2uOAEirG
	LdYC2iV1rV53rsh9Q3GzzcxaOR8XpRpIxXUzMyhEvyWlbw2PSPfJELBPyPQSMy+F
X-Gm-Gg: AR+sD11sJHCA9w2KteLKHTZLKpZr8yaUmqKklLJatrP66fNFmVddRCXeg0yeJK6jSR9
	I7V2H7/ceBVqKEyK1X4he7E5nd4Fns0O82i6BdAQxjBR1YNraTIx5jGg2hUr6S1vfjfILv9J/JH
	vBlqpSg1WnudvFcuCpf+zeqj9Gx7bJe8FUS/P9OLiIpusWC+3ZkMnxDt2WTfKVZW6cNfaZFQaBv
	ZQDVFrmMf7Ojx4YvDMXzSC3Va+csBrw3IPujx0uaAPLwAiHOtsWuLopUSzuvZlU7Uv/Y0Ya9Qf2
	eSfhJa/3jVn3mMC04eLtDmuVygc3A2eh9Bl5lHKa8MMGLvVhPQWkE5x3sR8b16lG9Co7CXgjnVd
	2KQjcJ45qzQm/oJ1TJhWV5bFa13Rjx706FhNjjisRNCJpv9ZAQQ9ekfi8Kp2+ZZ3Omlb0wZqiwG
	LQ4Qr7I/mzK6N15dtH/+NISjDIx/xM+aAr71PjLQdEHJvsXiXXxwD+Q37+efqJnkrLTUgr
X-Received: by 2002:a05:6830:6758:b0:7e9:dd46:b9f8 with SMTP id 46e09a7af769-7f44c0e6e2amr8007662a34.15.1787252235971;
        Thu, 20 Aug 2026 11:57:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.237.216])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7029dsm5214799a34.2.2026.08.20.11.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:57:15 -0700 (PDT)
Message-ID: <6a874e0b.b3d68efa.f5164.854b@mx.google.com>
Date: Thu, 20 Aug 2026 11:57:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2631924909045544807=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: ranging: mode validation and
In-Reply-To: <20260820174910.559116-2-naga.akella@oss.qualcomm.com>
References: <20260820174910.559116-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2631924909045544807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149256

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.55 seconds
BuildEll                      PASS      20.52 seconds
BluezMake                     PASS      564.82 seconds
CheckSmatch                   PASS      299.95 seconds
bluezmakeextell               PASS      96.83 seconds
IncrementalBuild              PASS      552.85 seconds
ScanBuild                     PASS      891.92 seconds



https://github.com/bluez/bluez/pull/2420

---
Regards,
Linux Bluetooth


--===============2631924909045544807==--
