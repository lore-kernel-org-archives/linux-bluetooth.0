Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2111A2882C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786227; cv=none; b=Um8VYKNv5bqeZTlp+hj8Kn56U0BrmbSExV/SDTjHYsCz9+x0VPlgVt6Zzr7UpgkXZNjsA7Xdd6MlESk4aZEZWZEB8Rp8k6qCnIq5T+1IjITUkl4OkG7ARHkSjoF/PXDp7bfZPt3Yq+uaV2g2IfTr5rm16JV4who3b71x1/u4klI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786227; c=relaxed/simple;
	bh=SbrPTwwqPNWzklt689JJvumPS78NRriy+ojEs9HwvEY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I8voYJcFpC6sR60TOuuZK7aUa5Uo8yZ5jfGGd02LTzDLhq/9bvkTXBFqFQaaBMlWN9IliLpL42M2ObI6vja5XKg0poFPr/tDdpgBInNpP0X1THYogmQeG7km6Ao5GRkwCYE7CW9WiKYQho5Nd/hi7CUgtxrDaA7GLkcSU1u7xl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw2i/c7G; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw2i/c7G"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e61c51f1d6so9363155ab.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755786224; x=1756391024; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7KKQ7onJeoQdamQVOpVrDm88+CodLyr9NLb33r2ggd8=;
        b=Mw2i/c7GHGb6Fmx8MIXTI86lhKV22q4rs8LPHsMpyuGGOdZxxpp4c8bLdhYTSGrtzY
         lKiRDJ15hv8TkHLSD9y1Dnq5po50nLm/5UhvNqraa+ojdIeg0KF1eG/p8KqfRvH03TAe
         rDVzlDfRk3aza7Bop0Re3Lw9Ixjsj1mOLdWUuQpPSnjli++JgCmrWq/roN7tBXC6II+e
         tIGHlzlh/Cb0oy+3HoKX5DusxZUAe6PkG823/hY6yyAtHO5x3cL+3pEAZiF81osNzLim
         gLXiX5dCgBN1OkIgSxjD+m2h3siD5SN2sAVfiXD7zNhvjfGdDOoLauQWnqapGKlN/Ggx
         R5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755786224; x=1756391024;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KKQ7onJeoQdamQVOpVrDm88+CodLyr9NLb33r2ggd8=;
        b=CMoqichUy6rROBVs4Myg2GqmH49kVIjWk8+n1HImTB1k6kkSEsbeWN4O4mu4fHQz28
         OLWW9pfc3G1erynwya3tKYbUItTlevhw79QV6A9MFhm1SC/5Efp30XYkc9HUc6Ewy58G
         y30RNF7x9j+Rqb+NsZ2QQE+A31+IHJ99TjcCvmIEcWMHaMmWDNpLMNMZ0QUOdZqdfHsP
         KERjLT5KWqHO9nQXJnre49C2a7phGI13PpaMoGUDxS8WVoy3by/ofCJSDZkoychiahts
         xNPFn3R44kFIiWfgjJm5Isnrk9Ot3j5LmEtHwLcpZ3gU82UqaPQD3OuSW/x8tv9h5AQk
         Ys4A==
X-Gm-Message-State: AOJu0YwUQLWLWAIwQgdx/ZYi+vREqVwwuJfy+bvBBkuG2hsDzQbEIeno
	xWr3/7GKLcopIjiR5CJqQGX/mTHl0RoCPEIXfjs8P7jv/2uFKx/1xxPOnGZ3lw==
X-Gm-Gg: ASbGnctMkMH5TYVRx6/Nh6kpWAsLf7PjvWqCTGgBILKLSgvvmyYidSKAFqX5bP0ZDQx
	nkV93Qq1gL5JEU270VrUYCYtzVq4ENIE2134ie+FjEEe+6DL2uL4WXiOqQCvRx8rJ/LZ8+BeoZa
	E3KM3nSEUyQZ5vMysu69LwbFxAfiWvJW155ZNazBxeeUBzVgXoVS4iDPvbYartfxA+I+D9FuzFg
	uIWFH0Dn746GkAJuDkW+lX4eqdSf1kj2TOGqhnSsbLxkoOaseXfhpGrdlZ6bhNyhVrhSNKT6CAa
	Y6uzUlblSScshRov6HUKqr4cFC97A+L9ZUiuJsBptGz13PX9Cd98qvHXwefO/PkDGZ1GpztxseU
	uiXv07JnDLR3OK62sIreWQnOmFiVwqiObpB/L/Pv3
X-Google-Smtp-Source: AGHT+IFSeCAF4u5mfvteB4a0bFJl+SVyxdKPUf1G+RpmyW5nT2ZGCYidqEE/cGsVhlC0OIzlBCzqvA==
X-Received: by 2002:a92:cd8c:0:b0:3e5:7c6d:ec8a with SMTP id e9e14a558f8ab-3e6d728b0f3mr42161165ab.16.1755786223727;
        Thu, 21 Aug 2025 07:23:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.131.105])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e66655ff35sm56955505ab.33.2025.08.21.07.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:23:43 -0700 (PDT)
Message-ID: <68a72bef.050a0220.2dc834.a3fc@mx.google.com>
Date: Thu, 21 Aug 2025 07:23:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8337165703523055163=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Fix DualShock 4 cable pairing
In-Reply-To: <20250821125844.963198-2-hadess@hadess.net>
References: <20250821125844.963198-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8337165703523055163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=994029

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      2874.11 seconds
MakeCheck                     PASS      20.02 seconds
MakeDistcheck                 PASS      189.25 seconds
CheckValgrind                 PASS      239.20 seconds
CheckSmatch                   PASS      309.51 seconds
bluezmakeextell               PASS      129.34 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      935.42 seconds

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


--===============8337165703523055163==--
