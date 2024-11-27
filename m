Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D86203706;
	Wed, 27 Nov 2024 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732749275; cv=none; b=gT2l3ZDdccNWy8pHhgqIlAXRkR4nRr8l9mvVMWkm7Qbnwbxmt6YbZB5Msq229Sm7sq7DPR1pLZnmIsvfjDJ7OiGGU7aJDQ4J9TzajkV2MihgWjMAKLU+lZ6YAkfZKfKPg+U0vjFEcD8GOD7i9Vi+5tpxOKGxs0+z3IDpmLe+aK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732749275; c=relaxed/simple;
	bh=6Ltkmyej5Wke/PPGa8ytesCUrUFYIIc0zVEnWqiEWaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=co2zFs0R+LjXxGeK7hOIxcN4C2EAWFHpptGD10t+5ma0dfPGBb0Re15PvhEaaPwC9EJN9KGM0LmXspjbgpI/ab0MBx48fApNLbjRn3lWwjNFbU0zDQTbeldMvEC+zFFrGIQTrXamXE8ETQbsnfQtkgWdwu3HCopL91G/r1ssXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qcx5LKEd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcx5LKEd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21285c1b196so1923745ad.3;
        Wed, 27 Nov 2024 15:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732749273; x=1733354073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Qbsfa3oGMzg1U/98CAfEMqAXTtrg3Szco6BJfPedmc=;
        b=Qcx5LKEdZQqO0l4AbPlwYLqgd8coEs88Lz7GBSw2bBpvl2XBmY3Fk66a3BhcW30VpR
         X7WP3q3Jym7dCW5JdChcMUL+DNCUAGi/lIWp6mVXZP7Q70/lEjq34BtBGEoK2DcVJj3c
         0ldOH2FgcLDjtB34n8CnAoHSypSQCZ63Q7VmUyGudtmPm109gGPFTygZHJTnTfvcxu0t
         MYQgVlvIbUkc+fXedmJ01PWY1keFQgwRjPgd1NB5nETxQeRbVBPauPgNC6uE2GquS0mN
         n/hXiFKn601Dk6AFLXdPOQIQN9LLS2kMFNEfr3l8JDqZp0k+lAlN6vH1kmPle+NHAsF9
         FBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732749273; x=1733354073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Qbsfa3oGMzg1U/98CAfEMqAXTtrg3Szco6BJfPedmc=;
        b=qsyxtly0oCY36dmLzJFM7XZRQHJKuxKTeriId/W5FvKyuX66c/N3PIJTTCuWGVxLM0
         zM4I9wuWn6JfXMJCA8kLGILQXobZFzavLhHjnii7d4isrijjHLE+DIybKtDXYBFjTyA0
         khCGNq5MU16MCEF6VB5sOqE6tjPm2qoiR6iw+wkYb9E/bIYNaF6zge8keoaTHug0Zhg2
         V6yO1ThZLyikmn/64r8uwbR37h6493hh12mIh5guUl/TPVHN2JyAIMLIk5JGmXmZxkZr
         uE3acsCe8DDf4kRrGlKO2wfP6+ZqcicqC+o+OLVEBw7ABPbZgOd30TlLyV+lLP6Op9SA
         C9iw==
X-Forwarded-Encrypted: i=1; AJvYcCUJhq2MailIj876sua3FGLoB8B0kIa7pZ3k+5kmfRwZmRwOwpjYh970IuwzGiW7V9HiyxwPDIlmSsev5+E9mWo=@vger.kernel.org, AJvYcCVpg9W4/X8vSh9z3649pnBQjkI7Lq08Q3Lx5B3bpu9MTzrNhYsTFXN+ZR8398Z308WKCbcX+wBNBFnSE1SC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywua2Ffy1U/8Fw6Ey5SXF2wrhncvZLumZ64oBl+EiS5B5Nlq1Re
	ezHuWUCuSel7IvxGfI5hI2IbIxKPfbhMXSdn3vT0sbRG+YSVSHlP
X-Gm-Gg: ASbGnctlxWc72sulXGUtlOLLvaGvDmSKUYSSlSGYdwsGDdvZ828P0ZQ8sSc73tTgACd
	IgYu1KvIqOlsv0T6LKexzENMFcGqljwXK/l7p5/J+/KyaRl3ZKPqZ9f5RKOKrSXVWWncHHo2JG9
	d+6IeiYSzchVuII2+XInQZizbgc2KrJsNNPAw+5WKH5KTuUPWDDnlLxPFqjj3ohIXb0J+gK4MMO
	78prQ2qmdZNJ1jYsrQvvZc7wqeXOX7w5wO+PxcxgrnAqhQquISHQSBIcZvBLFbDNSD3ZwOzinHj
	dvMkwEP0
X-Google-Smtp-Source: AGHT+IG42zwk9rVSv3JinSJ7jGPo3cY4n7KHciWkVFVdIkqCjPRr7Vl0KdkjQqjmAh8XeOcmAt858A==
X-Received: by 2002:a17:902:dac4:b0:212:1abb:fe75 with SMTP id d9443c01a7336-21501f64128mr57312355ad.54.1732749273617;
        Wed, 27 Nov 2024 15:14:33 -0800 (PST)
Received: from amdora.. (c-76-146-136-228.hsd1.wa.comcast.net. [76.146.136.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219c49ebsm903255ad.252.2024.11.27.15.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 15:14:33 -0800 (PST)
From: John Glotzer <jglotzer@gmail.com>
To: regressions@leemhuis.info
Cc: Aaron.Hou@mediatek.com,
	Chris.Lu@mediatek.com,
	Deren.Wu@mediatek.com,
	Hao.Qin@mediatek.com,
	Sean.Wang@mediatek.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	luiz.dentz@gmail.com,
	marc.payne@mdpsys.co.uk,
	marcel@holtmann.org,
	regressions@lists.linux.dev,
	steve.lee@mediatek.com,
	tiwai@suse.de
Subject: [REGRESSION] bluetooth: mt7921: Crash on Resume From Suspend And Hibernate
Date: Wed, 27 Nov 2024 15:14:32 -0800
Message-ID: <20241127231432.8112-1-jglotzer@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <643d8055-5a9f-4f5b-865b-830d33651dfe@leemhuis.info>
References: <643d8055-5a9f-4f5b-865b-830d33651dfe@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been following this thread since hitting this issue on my AMD Ryzen 5 7600.

People have reported being able to mitigate by either turning off Bluetooth in system settings
or by using a systemd sleep script like the one below (this is the approach I've taken,
it works fine.)

cat /usr/lib/systemd/system-sleep/sleep-fix.sh
#!/usr/bin/env bash
case ${1} in
    pre)
    rfkill block all
    echo "Killed wifi/bluetooth"
    ;;
    post)
    rfkill unblock all
    echo "Started wifi/bluetooth"
    ;;
esac

In following the related email threads it seems that this particular email thread has
not had any activity since 10/21/2024. Now the focus seems to be on firmware download which
in my admittedly non-expert opinion seems to be not clearly related.

There are multiple reports of this issue on various user forums (Fedora, Arch, Redhat, others)
but it seems that we've lost focus on the kernel side on addressing this regression.

Thanks all.
