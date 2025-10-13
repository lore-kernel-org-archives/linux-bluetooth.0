Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8B1946AA
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350525; cv=none; b=i/DfpObUi0P5Ir63VXBpSeL3Np+o0aNdeOzxDbO0hM5CYHLBFsIBAtRWqXaYVrjvB4nBkmtwy7JdTnyqI0+neZ3Oggy5TcLZNmqihTxnUSAxQ/+QF0kQV5VTYnkUzu6nEKfZ8qLV7kbd0e653pfUIYO5iuoC8sZ/+n1ivDPFNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350525; c=relaxed/simple;
	bh=tAYmAELIWH0bGRJoG6c0Rm+LMeeQfuNKcJ14unc7UHU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DI7kWqU+KtzN1oMBsqeazUaRPRbvWYnDyPLNeQYi5u7NKclY96MojcU5Q1iRX64NSfq/3zHDelh8xhLtg21amLRXbPXEYxoIsESH1nxBsNUdYSWrtlCJzPgAQRXQKURI/yf8UTDhBMmCy4L+22DoyDoMHvja7OL5tXPb3KVlxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gprZVFby; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gprZVFby"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-85b94fe19e2so558948085a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 03:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760350522; x=1760955322; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lTbV+sfD8udociS4rpEMf/bZtZknjdp5XNrErJHvHws=;
        b=gprZVFbyWJDZdrxeQdV6ksuEVZXq82yUYHricW/dsYc6v+T6wrQemQnzF+nBnc/1L6
         qZYDjxJO75GZvWnsauP4k3dVwuWVxHrJpDCDID0vbOmZt2IBM6wgRlr4MTkkqET2q6OF
         cu57bYfNPNi1pzBD5r6sR8VeCW5tTkQElg1W/SMj7XvsEwRxzzTtgNBe3iLxAdbf/xPS
         s/6kdfVk5kJxKfbqsGEmZpyiD9s4cUfrPAgcmgTA3I/20j8a6tCZkVNNds5ncOfvElAc
         Ux3hpSIogGpiMY77CvS70yqvvtmvLJeRRALuVsQFVhHfeLTFbD0yI4pPgvXV6JwOi56n
         wYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350522; x=1760955322;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTbV+sfD8udociS4rpEMf/bZtZknjdp5XNrErJHvHws=;
        b=HXTo3+exGI1qKikUWB3WBBDeflDljN0vxmthwphNAdz38DTShK6BAfg+CBB7Epe172
         hBiD1DLKE3qpxBqSb9FyfoBUACvrsQAhyBggZSvXvId/SdhS8FbGqAUP1MhGgxGF4kvM
         +lwSp9ho4OOzHTflBGeUpqxNmDHE7xKVBRnKD9aY4qgupCkQFbePPT3ZvD73oetfWfWq
         u5dHLvmegwA1gty+wGskedUl0+H7ZBAzZ6RPu4WDA/l4cvDQieoCMfmQF0m9DZDwvFEE
         J82ssFJYXjJmYEjVpfudADo7s+w3Nu6me+MPdpYb0s5zWdWfuGOvGfc+tOU+PY9PMBvJ
         LD5A==
X-Gm-Message-State: AOJu0YxSLM8ZBcUzKfUqQ5fw3sYvhGQHowq55B5BPzvhgKMyIMX++vK6
	7+9Kq+qQHtp2EYmBv69pcwC7EL23VvsXGVw3WXhMN+Rp0sCS+vPGQ/zrsWumGA==
X-Gm-Gg: ASbGnctfzpX8+Rii60hG6Bkv0Y4dDUdYXNrC5XlTM4zv1agDuctMDRqe7a2ioYKF/wq
	YP2rSXTgUNTeqb8GEsx8EE/t/HZuU0gsui9+6e/LmktbRHfq4BVeteDkj07dZI5ttWHVWYtYevl
	37tcuUXc9QqnS+knLkAdiXRa45Xe6YglhxTgwGAvhUkPmfFhABqRWDdHc1u+TcJaASInWSkhYz7
	DDtvO9spV4qkpmqyqt5zyoKZneRPNb+OSNQ5BmadImyLcJEg6PTAR8jnNzaKXkGxezD8H8lHHhC
	QqYmb5uyyJuj0gVtF6DHuXJESbDNDGKn5Il6iDI5E55LaV4g6NGv9RvnKyoOV1ZL1f41+ccCbYu
	hwzcBiI23EG6tRmLM06liSLEAZvTNQpAGrAWKy3tPClpU+ss2
X-Google-Smtp-Source: AGHT+IGWx4nE+FJpngxGRwllXRdrAqyL3wNJe0UmpmbcDZE3z6fsu5mOjwCwSNFAqzP3rgq6TqwT0w==
X-Received: by 2002:ac8:7e96:0:b0:4b7:9efd:ba9d with SMTP id d75a77b69052e-4e6ead54273mr272180581cf.53.1760350522464;
        Mon, 13 Oct 2025 03:15:22 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.103.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc345d43csm69106096d6.12.2025.10.13.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:15:22 -0700 (PDT)
Message-ID: <68ecd13a.0c0a0220.10ce99.e8fa@mx.google.com>
Date: Mon, 13 Oct 2025 03:15:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7412653390300126214=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: build: Add meson build system
In-Reply-To: <20251013083259.3152260-2-hadess@hadess.net>
References: <20251013083259.3152260-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7412653390300126214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1010619

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.53 seconds
BluezMake                     PASS      2756.76 seconds
MakeCheck                     PASS      20.14 seconds
MakeDistcheck                 PASS      190.31 seconds
CheckValgrind                 PASS      242.62 seconds
CheckSmatch                   PASS      315.00 seconds
bluezmakeextell               PASS      131.51 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      945.85 seconds

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


--===============7412653390300126214==--
