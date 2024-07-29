Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CE328B6
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240664; cv=none; b=A8zaHK/Lb6+APm0DOhUolqo9uRxHNrF+lfutA4bXMmAa3wX7DwepMIpB+rEYskfnRFeZRQwcRicA4ux8yrPvmYR9R111EEa4r1ypK3XSNxjxRodd4exWl5sy2y3xp4tsdDz3yah0vGM7F74HEilJuhOlhwU7Yr44UgGaR/dhmW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240664; c=relaxed/simple;
	bh=8R/IoBqQhwvwV9yDnxq6Y72MnHSHXh+4iZ/7zBbgVlA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bvvaxbFuPvpBQghgFDtAO5OhSdD/YtcMpHxpyjRxYCZCfTumsQPVCvP8UukB7sLN99KJllKAqBCHjTj3qtl6QflyfJxQWeulf5FPSkybKUjNMkebZKuPl+FrVOvWewDfEj0YHXf8j4WJMO0zrNkoqlPlJuP9aaQYyrkbXPLQjOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdyomUE+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdyomUE+"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cf78366187so1553879a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722240662; x=1722845462; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/CVHGJwxh5TxfV/SZVVW7k1KfCTF6NAjK6NXwsSXB/E=;
        b=bdyomUE+MBlWG2JdMCjRtNURAK0GZ7bOks2PugatnIKxox7GQgzRXtHOVSe8IvqOXB
         a5pVKTaeLqSSxwRQ0xkEH+58HW/3kt0JB33p2+PrMKlW/e56E6OOvtnyWTrFMDAffeiI
         Ig4jSzPgF4SCJqf+L0F+i6DSAZDx4r3f7CmIj1LKNf5jnAap1GKCZ3nFF3/zZ+LB3REp
         7N0oj2dGJBnQcWkyW8E3n7570Dk/anb19c6/JDLSbRgNTHST6/ZEo/Y0Bv6KmP6qUagn
         EYbA/enx20moX3mhDgczHpzUh8rPCXrz6MC/wRBDoML4dqCPti0BNu3XzW2yFZKNQ+TH
         OcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240662; x=1722845462;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CVHGJwxh5TxfV/SZVVW7k1KfCTF6NAjK6NXwsSXB/E=;
        b=ELjLCgr5X5w1r1fBVBg6ucN3bkLA9CIYld7coRYAtCy6j6zTxNpLxIybe2dkmR1hHh
         BU1aS/ni0dHPfvBdiC3ZYyMFN+6cLGChhQvia9vE9HGl+hxUYMTA9e0fIm1Lf+XomtYY
         prtgFtK4x3jtKG1c7mJoeKeAU5T9Hgyw1DDw0EjSqSCWd1SJNoTIMQXkea8cgHWciqOt
         6+ilQBjWW7WNHE/9Y/JCUkKp5W8WeRiZ2qkQ1oNvQMyQO4i6MSnMnnR4LZNyEIKgENQ3
         vKd8+VhlKDqLeyqUvf3aCDyRimuquEUDAT/Hbro1XngsF+/1+KURdw7qUW0whcyeNFmp
         rXtQ==
X-Gm-Message-State: AOJu0YzjAvhH1fAnhe4zY1RjOIjUo0sZi/IwJV5yeF1w4JWvWbkcLs24
	hUjumnkgTAXiZs/7lQGKCZ8kpqoE5lGTOA2rFZESS99cwckOl7zDFxFw8Q==
X-Google-Smtp-Source: AGHT+IGhsIVgPJ7f/b4tohh9K7RD/2/opf96gXU2NqMmITQ6+9oxqv5F1mOkc4d8NlPJLaJy9Osyuw==
X-Received: by 2002:a17:90a:668b:b0:2c9:649c:5e10 with SMTP id 98e67ed59e1d1-2cf7e1df022mr9083844a91.10.1722240662460;
        Mon, 29 Jul 2024 01:11:02 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.99.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74e894csm9981849a91.41.2024.07.29.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:11:02 -0700 (PDT)
Message-ID: <66a74e96.170a0220.1ac8cb.80e0@mx.google.com>
Date: Mon, 29 Jul 2024 01:11:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3905205038437514782=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v7] obex: Move size emit signal to plugins instead of obex.c
In-Reply-To: <20240729062638.8796-1-quic_amisjain@quicinc.com>
References: <20240729062638.8796-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3905205038437514782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=874418

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      25.47 seconds
BluezMake                     PASS      1760.42 seconds
MakeCheck                     PASS      13.18 seconds
MakeDistcheck                 PASS      184.48 seconds
CheckValgrind                 PASS      259.22 seconds
CheckSmatch                   PASS      367.31 seconds
bluezmakeextell               PASS      122.63 seconds
IncrementalBuild              PASS      1496.11 seconds
ScanBuild                     PASS      1068.54 seconds



---
Regards,
Linux Bluetooth


--===============3905205038437514782==--
