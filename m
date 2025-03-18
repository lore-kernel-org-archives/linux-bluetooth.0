Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76551224CC
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340763; cv=none; b=ApaKYDJyRqHb7yhXj8fd9Q+lVmCZ4x00LclEkD7bxveYvMHhW+TpTd2gVVmLkgq6dVg6Yk3nGrqogyfFT52Jto658NwqOyXt2/1zsrsU5JNKn7sYsxOysoGPEquU+CzWBx/Wkl6FYT76dN5vRF5oLEIFlMJedsWIuNvnNOvM5XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340763; c=relaxed/simple;
	bh=TY/e87p93/Yzr5R89b+3zpSwbJnpfb8XPKTKcSmoCpw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RhVblcaXH4ziDdlY/Jx/+9aBhLPPMJ4whJR4cZTex1ePI9TBuPjVsoQuKicYtVdh4uu+oasRDMT2zMB0g+9K4GTCaEFHqg6iqqal00a1SSRQwduitXwHF6lVr7XkQUgJ/bc1yOL+AruSt+i1RqINpgiem7nAXgyov4LGCvlEP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6eauY/q; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6eauY/q"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e90b1b20c6so34001836d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 16:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742340760; x=1742945560; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9CDYR9BTy+UUpFm3O8GLxXgjMWLomR+AkYDBqxtz+/0=;
        b=Y6eauY/qQplZ8zMDvTIs2F++Fj49vrsCQcItJeqhLWLspqLFYFGdysDyAuKq8TijmB
         /cIQwjGvKNuxKrN5kE6mPaOtq/5A/7LslC6ukb9+V59yscl3Kzik1vg8L4RgInyv5e8W
         DKtao/fSrDWNx9avcoSb0IiHu7OzX/65X95QFACqCrtMobaR0rdce9XrRmKCrI8iPC2C
         rq6U9meqWNvz07wKYolrTyCFfi8trJ6DI8JEymhymggE65K08dRSiGlpBtCpkgEoTSxt
         ck907eJBdhAU52lXSfO7MV0v47CacDaWAbbu0MKy7/DG83Nqcr5GgConKOUUE/3dBS6v
         oLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742340760; x=1742945560;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CDYR9BTy+UUpFm3O8GLxXgjMWLomR+AkYDBqxtz+/0=;
        b=gsOoP9LKoW1cNjU1XM0l1/v3o3PY59ycsOatgThUkvCST45DOC3LZ0bIZdFpjK2HIm
         3lZMWk8vs+5aKe9mngSfvfRmBh5SsqJ/IbE3Akq6+r6cYbdpKHS74mZMnzexTg1p7gj5
         AJ4hg5aNdeyfGnM5QQZRVbBfPfifo0Tsiy9gZIdqmOLR8yD8gvL7B7V3Rj/dX32FBD9c
         2+77Y/KBEnQxF5aZgfrJt+mbGwTVKMKh0/1JRUfwm8L6KYGcQEKC9mk+kVWjW6bEvLsG
         e8RKkQ0LyssBbmZFOKNS6wKTX5hDJpkrf4e0zCJxLAP7L6Gn1vGyMBP1Pf3RwD0Rb6ix
         61fQ==
X-Gm-Message-State: AOJu0Yz/EP2bCVYsoyFJ/0URXdZadijOnleLVPEjNpckCUk+KxMP3sIE
	z1uglkMxG3V/iwV/v20N/TjNd+CaJozJ9viAVdn2SA1+/yUrTNrhE7dUqw==
X-Gm-Gg: ASbGncsWb/FGjC5BmIZX+JrNEgMKX4MPLedS1hx33OcUC/AUpDUmejbL63ar8yqjP9o
	FA6ohbRuUEA6z0NnOD0yZz3N82tZ1Ifnz0JAcusp1rs8mk7YNJIRnRRKPFLT+9HG8/ZYx+ajstY
	rQwF8u+IFR0Yb6mr5BdCs0QOrr0SzJDbJ8ayAVMo89TTnb+JS5GFnK7k8n+2wubDTsvcgINdSpA
	OI0zePVLqEqp985OpkVBpm0OukeLa+NLiSGMPkcX5RjMK9GbMOLlSsNuaGeqaxT7aDSN4oXMKHL
	+qmuA0Xm852ooaThw7F+nRXqdvL+JUeClDFQTeNH/jMarJed4tgnne6pG3IA
X-Google-Smtp-Source: AGHT+IGsqw/HO9a7NtYUoxdn5KoWxpjZBdPcUXm6qfk2Huj/8daX8iFqT077x/luNq4UUp4uYAwY3w==
X-Received: by 2002:a05:6214:f0b:b0:6ea:d629:f47f with SMTP id 6a1803df08f44-6eb29444da5mr11452086d6.42.1742340759884;
        Tue, 18 Mar 2025 16:32:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.47.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209beesm73055416d6.10.2025.03.18.16.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:32:39 -0700 (PDT)
Message-ID: <67da0297.d40a0220.2160be.b7f8@mx.google.com>
Date: Tue, 18 Mar 2025 16:32:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1110973116355499364=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] l2cap-tester: ensure SO_SNDBUF is large enough for the writes
In-Reply-To: <975ef1acdd3903f4e0fcb26dc1d0046762d99140.1742336487.git.pav@iki.fi>
References: <975ef1acdd3903f4e0fcb26dc1d0046762d99140.1742336487.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1110973116355499364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945352

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.38 seconds
BluezMake                     PASS      1472.88 seconds
MakeCheck                     PASS      13.26 seconds
MakeDistcheck                 PASS      158.31 seconds
CheckValgrind                 PASS      213.97 seconds
CheckSmatch                   PASS      283.23 seconds
bluezmakeextell               PASS      98.45 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      865.27 seconds

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


--===============1110973116355499364==--
