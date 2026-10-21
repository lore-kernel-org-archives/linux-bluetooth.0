Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587617;
	b=ttJ0hHcKlIeFN117McD14d08eLf0zFlC8gTB20g6CVw/BxyjBHXNiGYQWpfkjyeQ9iFK
	 xxOCu7Ol6UcaPkYevuURDP+54F02PcZdFwx0I2FvcUt95D8KxARA5tL4gTXZRYVl/aBfH
	 jsfuM5+2vVMFSi0cEqSVB49uBkadIS+DiIJSMKIdRlOGHjLVrxy9f/mEOTvx22SOzAv1H
	 ik4sRKBm4bT6iApvfr+WtsZ/a75RAoUxQQhRBpm2ji2GTePFZHgsjYl7YJL+X6gVLHGhv
	 GcQRjEcdJiX3DtXIqUGHTGmPmMNSL6OQlU2OaBcwhD/Eg1lTDJQoyWSbH921ep9QmQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=bwXHYEEgS4hScqFMZpg59mIq/wYuJxw692a4u7TnUJI=;
	b=afUfkW+U8uw1DQr0nERDiqOZ65p/O/Iemg4q/I53kFQC0enw/xIgfmKiRhOu+uABmp+l
	 IYg4LZ0eyxtf3B0WbYQLjlbngJZwI7z0NvvQKdZCMPGNw1BvJlu1CZsS6VGvsP+OW8pgD
	 QE9ncibnW5dvHhslFTDG4ESuCY2ehc3KOYoduMNra5PTW3DqkeB1GZfPSQlFkTeAK0RrW
	 YZpeQNJt6BbcD4UwQ7DxbxjiIaoo0TPXIXf6Id6TGIKHI9ZAjh3C13NZeiD/sheg7V+w5
	 sO1Mlm6VEzs9K43Y49rkoi/Pu7W84w3N+ltEx+e3mZLbpqK0wu6+kGKOabplu9Gq9lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZK8fJAMr;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD85606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 13:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBD85606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZK8fJAMr
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15dd124bbe7so1252570c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587616; x=1793192416; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bwXHYEEgS4hScqFMZpg59mIq/wYuJxw692a4u7TnUJI=;
        b=ZK8fJAMrVm1GyNp8M01/gRSkG2IzGLZ6sS3wUcSBJDlNDEoBrKZULr3oMrNpVasU1Y
         +g79W57SCr5JpBdZsBdeS0wFR/vvmCukhXDBCsaptNbuVAXuTOpXUFKk1CRjnXUT60g5
         cJtgserQwtQfjIsZjyWCdqaui+avtD0c4WqyGFBRTR3xnXsFAWIeoTtCoTagE+3QzWHS
         Fsm5wNr8fJcnZbLsjPOUklYrR1vJ+3XalRTlwSyFuFzc2r/kx374aEDOnNB22WPHkCeg
         jqgVoBUyLW2edWw0Gi4tsY3ZV/+ouAL0I7soqaayqbxGJdz6ywB79dMagvLKkwcoOxt2
         B34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587616; x=1793192416;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bwXHYEEgS4hScqFMZpg59mIq/wYuJxw692a4u7TnUJI=;
        b=HmHHsUo0DzqT2Y1C0rN2IEo358gvLuxXQuSJxtRMZm9zMk6aYAwe6Zg38gPyVlXOLk
         HTWcUcXe8R5cz8JWAWHkLDiTqx/ds1pFDBXcEBCgQX7cOpuSxhcIjviGB0xzHOUmIO0c
         YLvWNY36VkuCP2j65Jo+iClC7wS065lY2K0BCK/EmlOYt5V7SSauMJXFWVBVEL8kvScH
         WQMyDtHkfg77b2XPpd0//5SGsx4wusA2RYysvfBGYE5z4o9miVlzYp8AHzHuzF5XHEUc
         rg/Qh6ooVGWBhtdZ7dkmiOBTIFDauuYMdz7Nqiv9DxUvk9JrUCVhXUQesOen3JrK+0C2
         q1Dg==
X-Gm-Message-State: AFq9FYJGDG6g9QawRESjJmXR7KuBL0FMGUhuMJ3W4+MRW6gnteaaZzUm
	9dG/AktDDMRxzTmM7AnS0pb6iC7ISxiKk6gzMFVrqxiF31SlDLhzJP8vJa3Jdw==
X-Gm-Gg: AYBFou2JcZupNH7Uz+Fd6gNov15auYNdXxsXgtjNVhJNN7MwcyGUfidTRD3+Na+iGUf
	4BR9Zw0sOfc4lHtIEFwe+zEhL5XvnTrVpt+6tJAPy6FTXqaPM+CNnpfvtqkQnIFbjaEr657ICI0
	Acmmwy0n2b/AwwMHy6WPTiAKuSQvk+jLpI2qcCCbGb8CF5Z4rJ7N94HJLkZbulVeiB79SEzq+IS
	1fUH7D5lMJ1tcMZVyL2xcd2la9vIsEVVriwV63eALZRyW+RxJGlBsNP94oxrZMTcpKx+oys+Pin
	ODMhAwPH94nCYWqkXd+uHpem3HFsqZTsIRi27jbypM7C0UZ4LCzOXThfaQ39BlXDB6kasW2iKqC
	9gnYwaSHXa2O8+hEWlrYoxjRmgSm/ENHB4OPqdc6e2m5ALlcpGOydz9PF6mzcjMa917jmWrumE5
	ftdm1n9qsrnRbTBAk444S1r3HcCdjI4oRgHXh9HkB8DrGkVN2LQJnj5yvZvOyWBSiqr2nT0OGTu
	ZNFBPPYm1m9ni0kwCIcm89xO4Rx7k61dN+i+DzlItgU1FeIBd9K1BrN6BNp
X-Received: by 2002:a05:7023:a46:b0:186:4a57:94e5 with SMTP id a92af1059eb24-190a7195fbamr2628401c88.34.1792587615503;
        Wed, 21 Oct 2026 06:00:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.37.39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180b9esm9619886c88.4.2026.10.21.06.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:00:15 -0700 (PDT)
Message-ID: <6ad8b75f.acba1091.1be225.7f85@mx.google.com>
Date: Wed, 21 Oct 2026 06:00:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6799229883843499530=="
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
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: fix ISO data reception
In-Reply-To: <20261021084337.1515468-2-chris.lu@mediatek.com>
References: <20261021084337.1515468-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6799229883843499530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1190327/

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.71 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      21.70 seconds
CheckAllWarning               PASS      25.46 seconds
CheckSparse                   PASS      28.31 seconds
BuildKernel32                 PASS      22.39 seconds
CheckKernelLLVM               PASS      25.79 seconds
TestRunnerSetup               PASS      518.28 seconds
IncrementalBuild              PASS      28.67 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,RESEND,1/3] Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding

1: T1 Title exceeds max length (84>80): "[v3,RESEND,1/3] Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding"
[v3,RESEND,2/3] Bluetooth: btmtk: bound the ISO payload length by the controller's MTU

1: T1 Title exceeds max length (86>80): "[v3,RESEND,2/3] Bluetooth: btmtk: bound the ISO payload length by the controller's MTU"
[v3,RESEND,3/3] Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD

1: T1 Title exceeds max length (88>80): "[v3,RESEND,3/3] Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD"


https://github.com/bluez/bluetooth-next/pull/971

---
Regards,
Linux Bluetooth


--===============6799229883843499530==--
