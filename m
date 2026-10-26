Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035419;
	b=zUzJxU3iEoR7EcF+yMBlm2qNYqXh8rIdR5Cb3czPXcWc5NbuoS1P07BWj2La/7VVrWC1
	 XGS3tFpn6UowJkMo2nKjfcOKDN+2kUaBCMaUuADAkI8kxkRHCOZZTgUWq/BbXkGZMvSzf
	 3gEKp7t/JdRFAnA0rD493jDeOBXDxbLrKhZWJgm/A/alU5zmknAR4Ho+50B/7Lqq9NtNX
	 GJ3uEZlQogI6c+zV9ABbnL/94XabtLnUpM7hviSl41DXHuxvcQSpOjwvh5LhvaNbW04+Y
	 xdx5crjuLHSVYRI4FihS78LPhvy1DOkQlss9aEIT8U6lGp8vwItZGvBBCkIHsplx1uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n1T4A+3m/gR30Vx1pb1IZhOjpD85xzschYt8y7rBl3Q=;
	b=WgibsubW8EVbuU2kD9vkGPHzHiHGSvNJDLIN8WSHEeICsunwsG50J+54rMPiAtcRkx4v
	 efPusgYlvCoKY+ShUvWYpfc/zjxuNF6c0qKWuakt6/24EeFjn7SpnyHm8LSFu6NNaBV2G
	 b6mPOlg8g7WB8A0jF1gQBZSVs+aG8uiGNvhfSNWNYsu0OcRyzES03gnLJPpYSXZ/w+QaY
	 hvG4RTnMi4cgFCnpsxvGObr20/amvrlZIc+fvic/h7n4b0OBcN+SwKQIAPNuB6/W/HglY
	 /fzPMyR68BOs0LZiTVMuYqpoQbfFJ/SOfy76JLTfwdLZPWQMiSKm+WCxCCVc4V/Me1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rMyXaWyK;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796D3606A328
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 17:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 796D3606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rMyXaWyK
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ad98c3fb15so26609397b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 10:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793035418; x=1793640218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n1T4A+3m/gR30Vx1pb1IZhOjpD85xzschYt8y7rBl3Q=;
        b=rMyXaWyKYgGsfxHH+Gc0QW4ZVntC/fa8j7VCBe+9xA3c/s/ZuIYxZv6cF4lEvAblI5
         AK08Hx9SAgUKWzFw+x5uQMjs33SxhnwLzBjY+db6Sv8buiq8yZDqxWn0kOuks8GDKVaq
         i3V9P7pD/PudnkLSXxfdaYjqADIl99V2BFtxwbRZS19wLR9zGBdhkyQgyrpwoKeSS5tE
         UsXR1tvqYynFgs+FN7SDWlSuCYwRKrt9qdhkE1LQE2JCJSAhevFNwuUBu0pVCqaBfe2/
         szPA4AwmpG0toQ81mwBOYEJXYLHg3uqfuFsVFD/nMf67RMyK2U9D4cry+tMO9Z/kfUwj
         zO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793035418; x=1793640218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n1T4A+3m/gR30Vx1pb1IZhOjpD85xzschYt8y7rBl3Q=;
        b=QdIZIZvjVQIMVXmsXruaxCwRliCnTM/9LztuXB6Vc9VG2UTLy4/GWKneWdf1D5A3hL
         QroUl3hkPNBEvZ5Of3brjPpwz00N0cbX29btPFycQsOVd7UcWrINXDaMxKtx4fTFtqSy
         VeDgL0a0z0i7Iq3HneFgSaimoSBODxbWANux5I9q705gk6+0zhxcH9QRKi8/ZGdECQMd
         kZrPa+efnkTPHUG/NrwX6lsV40M2s7Tq4KH/eYCkJCIgOUgy5gDW/rjNlZd0naLIFmx7
         oOZdzAFBhUNdvA/ogVPDEdeR7FJDlrYTex8+xzODjdDTMHxRDTEQ76r9tNi/ZSgZgcXY
         BZjQ==
X-Forwarded-Encrypted: i=1; AKwUvBztIwuFepKAUlYC7BN4hStsElkQb8x84CHMe7WLwxC5EqNr/OqWoy60VMq2IisgI5osXVR+XfjuIj7AuijhJFk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2hAUJe3VTZQjV5z9Jsw2qghwP4O/frt8N2VeCLLepv4Hxz1Qa
	ZLi6wFTnmhUnC2fBbIFzh5Ze6WdHMl9x9yJqgD0jCo8B4f4Q3WWmyxVRzQowOhEqCT8=
X-Gm-Gg: AYBFou3c4Nm4oyM8y5OMyu9NIid70lv9nVkquy/6D1uMrm+DOrnCw/da7jthMfP6fua
	5bf0uu9nL/fxq0RRBTc1MSzXcwddSelUKiS/WwV+ajwcTevFaoICPfNSanW6JavU473MCcF//SL
	SGJb8LBz7U110ip2bGiWl9JFBy0x7NsKP+poh340dtLEgHBn5EoStVoZtUP6M8sqItxZ6XKD1rq
	dWu3KWTPGhz2mdm61TeSOoCEslh4YRv05/3NgOdWSWx+xDHjApsdw9nhyL3vHQK++0k+n8B07gH
	Fo8OVGRjJHh6H9xX4rfzs9/ICSK7QswS6mAASvmYaYC5yU5++EjkrNoUQ/3Uj5iuWPG1fjZ/mTn
	po57FLQFYVOY92QiEH1lFyJR9TzoWWoPBlVdkim/hzwQxYcjZQGiI7C7pjtXaME4i60JhW6Uo4d
	mELCgpbjXOvnF6r+UD54OgV/NTFWm9mKhuVVy7HyNW4Gv5SgAhTKeH5L3hhHMvM0ZLkbXKy4unz
	5sagvVxtrAkFeFrTIY2YBv+nnFwnbdw0uCYcBhxgOkznwI=
X-Received: by 2002:a05:690c:e19b:20b0:8b0:dfcb:4d1d with SMTP id 00721157ae682-8b166caad59mr45807177b3.47.1793035418519;
        Mon, 26 Oct 2026 10:23:38 -0700 (PDT)
Received: from WillzDenali.lan ([2600:1702:7a80:3c5e::46d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e9fc27sm35090107b3.34.2026.10.26.10.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:23:38 -0700 (PDT)
From: Brandon Williams <turbine.bmw@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Brandon Williams <turbine.bmw@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: SMP: distribute the identity address when bonding
Date: Mon, 26 Oct 2026 13:23:27 -0400
Message-ID: <20261026172331.33873-1-turbine.bmw@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CABBYNZKc1C=q_p3=f+jAVPUZd90=p4o=y2n22e6GoVX6YUq2nA@mail.gmail.com>
References: <20261024112435.247650-1-turbine.bmw@gmail.com> <20261024112435.247650-3-turbine.bmw@gmail.com> <CABBYNZKc1C=q_p3=f+jAVPUZd90=p4o=y2n22e6GoVX6YUq2nA@mail.gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

Thanks, that makes sense. Turning privacy on only while pairing the
pen solves it for us, with no kernel change, so I'm withdrawing this
series. Please drop both patches.

Thanks for taking the time to explain,
Brandon
