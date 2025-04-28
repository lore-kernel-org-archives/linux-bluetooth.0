Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550B279905
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859999; cv=none; b=A+GwfvIuOUTSOF84vu/Znf9HbrrCiwytMaqfJiAaIPOMnHPcbZ2r4K0As6lcwA6MTo2/m/unZ/wP9vngp2JbiS6NNRhekrNjV0AOrf0pU18Dz9ryh6dKTc2FQStX0a4eVnQEHfKh82JnOm0gqqj6+131xvksVN73FG4j+5XWmOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859999; c=relaxed/simple;
	bh=ljGrb9S6IKiKaRjHiNDVD3xf4oT/I3KfDJPIgZugOSM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R8HfB50AdDc4vu9ydci7SUHWnxYoelKk7wKCidvX3iDljocuznk5+AGzzUJUo/DacjSDvyDeAln5zyIt1hO1KapvtFABX2XNi22kYEWr90jjAZcys77+I4UXByUcG89qpCvgURfld9vntCqhXIwFsIU4JZeKPW5gL6bd46U4enY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TG2LmJTz; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG2LmJTz"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8fb83e137so51912716d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745859996; x=1746464796; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q95Xu2IgxQyMLM7ANDfcZqlWikFR8gJMcAY2hLbhcfY=;
        b=TG2LmJTz9yA0sB1YQCs8Gwz3TAzr9Yx5Our3+ywNUVzJMTJmvq3xSU+EAlpK9j/S05
         cQRCnjI34I0/AJwnaISyNYsUAAg2+M0kWXgdcyL7SVMde2R01gGCq9jkhw1vgdnzfOZl
         53KzY+20i8KLWNh/K/06syCYLtxAMApZKAS+OQp9OCKzK5Y/vBfNffeJMh1V65evRDgW
         uNFf8eehq2ZBpblyolHBiX3aVaPxb+aCa5EnX8+xeShAizzQx36TBhQX2q8L/bAYoxWv
         FcEV4XTV09k0/UXvDtc+ZWmIUyhH1HLHBs45N5mIviZhJUf8isBrSQSRQq+rvQG8T4Tx
         NllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745859996; x=1746464796;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q95Xu2IgxQyMLM7ANDfcZqlWikFR8gJMcAY2hLbhcfY=;
        b=Lor3MBrcDFez1i4dtTdH0svYqN/ai7UsiMW8QB0dgilZ5f9VusJL+0A/v189jC+asq
         zP3HWjpI5HOxd6rLvesYLnVqBr54ZHxrXp5vwjMu2xg4LLcwbbeQqbPoteMgomDDS87I
         mtFjNHfHkqNjHKl5s/OW4pPCXMXglg8BrNiSNUc4dzTkTGzyMbDotw2i71y47FO2JNGp
         LAZ33cm7gVy+RDIUuOj5lwO+aFRAnGDxj5AqcK4gRuqX+R8NX3qNuQ5QwRgUQNa8hpWQ
         QRBkuObpTLz1ibIqVjiwiLwyjSqceJrzUfbwE+dTps4UgT2K4kDX3uIDumrjALF0St0g
         OFaQ==
X-Gm-Message-State: AOJu0YySGiFLw1INNL54dnQIUa5CwlN0tPDWk7wqRYkGBfJ1EGIu5IW+
	NipbSiy05jNmZz/Kv3VIEjyLLsLI7t//41PBp7ba3H1v3flpwogUl8Y47w==
X-Gm-Gg: ASbGnctVXDhy5ummfgLEJXVuhLWwp7rPNeGz5tlysDbP2df0mUSjyWBp1VioRJTtpd9
	+M8q7cdg8s+4W1S5/Pzb5jylfPanIbYJU49NZevl8e9ArrpHS6GA72VCqrI3JKV11/JC7kn8BJB
	59yXUO556aRisZLxQP0t/tyafwY8m0jr6J9YWFLnZ6GqxuGzfXUFROR3I4ePbbJNEa8T86dGGgw
	jWhvlvx94kxYC5OOJFPZPaweTPHiEYids4S6nAx+j5i4teiXbPv/2KQEJqEkyLhaukLf/4iY8Xi
	SyLILHh3oS4q6cREXuIJC6+0XLb4+kMOr3T0TaPrLL2LqH9hh0iYklNxKQ==
X-Google-Smtp-Source: AGHT+IHvVYkic/Ehwz6UCyT6HD0tvUVOGRJeZ92FrFbeBxwDTBn0OAfVHghX7Z03Bj3k1+JLN5MrtQ==
X-Received: by 2002:a05:6214:21cb:b0:6f4:c824:9d3d with SMTP id 6a1803df08f44-6f4cbb5a116mr223972506d6.37.1745859996192;
        Mon, 28 Apr 2025 10:06:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0a7433bsm63250046d6.93.2025.04.28.10.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:06:35 -0700 (PDT)
Message-ID: <680fb59b.0c0a0220.26007e.7326@mx.google.com>
Date: Mon, 28 Apr 2025 10:06:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1669750023386227677=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] main: Fix scanning alert no. 21
In-Reply-To: <20250428153950.1942867-1-luiz.dentz@gmail.com>
References: <20250428153950.1942867-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1669750023386227677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957766

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.59 seconds
BluezMake                     PASS      2709.25 seconds
MakeCheck                     PASS      20.07 seconds
MakeDistcheck                 PASS      200.73 seconds
CheckValgrind                 PASS      279.74 seconds
CheckSmatch                   PASS      308.95 seconds
bluezmakeextell               PASS      130.42 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      914.39 seconds

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


--===============1669750023386227677==--
