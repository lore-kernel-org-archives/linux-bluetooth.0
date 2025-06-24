Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9137281370
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780762; cv=none; b=kef0yZC4HdVhHJARLo+aK1jomfY/pXrmk4BOcRi5AEG9AnmqJV8AO43veVew12xbeXDDGkKCmo0v7FeNRqVS2RKl8YgeYM0OEvCf3g3rWLAwUoem4cpLxLVhz1xHt2nzAic6Wng5v8qMwKPQWiD1XgqIXI3uInqVhM4QJokR99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780762; c=relaxed/simple;
	bh=AT8lKrjultLn5tp4JOWqj3DwSX1mMal1bYQBSoPyWww=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i3RziG6dGtEM7U8+wjsjdUqeG8Qd4yGmZ0tkhH6dBN2FTvymyHC4QH0oOPnjEX+VIu+Ar4bhcDY2t+h8ok2MssiMOV4i0WBxCpxz9dAT1PaJ4oyFPLtf7jvj+O83i+yzpjhbKKSNldUQCUji8VLKKLCfKchkYrS0mCDAID9B+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/EGfg6R; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/EGfg6R"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3da82c6c5d4so55085615ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jun 2025 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750780759; x=1751385559; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8BMeevNSzD1TJ6IJP221zdGno3wa4jMycBw4swvHykg=;
        b=j/EGfg6RqoERUb0VnRcQZv4IxqT8UhBcseiCJv15oGhKVdJHQ3KXQfTJMW7RqEebut
         bywascEXe/b1X2kZfDs6H9mqZG2evtEblQgLeJWFc4rkNOTZVcysWqrt4zSjQlennn5v
         g3IRqCdPPAWl5EyeYyuVPKwWE9JHdEaT9FxfHcX6WvnxCAsUWc/NNPpvi2h+tbaJQyy5
         krxiDyjyokpInA45bQ4flkfKR0ratuj7jVUYtEfgaKyu43ub6ChoQub2mEiG6MUcvBvI
         2blGq9kTHpn4VVP9KAXXDKzY2GDh7iIXKRR+Excd9icSLFz0k+CDNpwSWWNc0WyGPsAH
         ZAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750780759; x=1751385559;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BMeevNSzD1TJ6IJP221zdGno3wa4jMycBw4swvHykg=;
        b=EqjrqsC5LH1EZgzsduXDi2KtrgJHzhWmWRX1Q/yR895QIcYmXzg902chspuVFz60Aq
         5RcnNxG2lCKiHbm2z3WGsVlPFt4jBEv7DEvG88U871hyEzQ9tH+JRWhoU/gNPZ9eh+++
         muaJJFWODBVFCuauyIZ9gECB6UBI148op4eJ8qgk7MDTeYDinRbSdfGge9kJscugXA2e
         lQMYF7H/ot8hHWb5dtEyS6W1fhYdqO8koi2OL5XdqmUqSe46KCLN89w4Oez93uIZixbX
         iZ8vDcWkQNphd3xBbQ08Q3vmSV2rJtzcIJBEu2pn2Teg+ck/6NdOjNBpJxaT5be2aOFL
         oDeQ==
X-Gm-Message-State: AOJu0Yz0jT+t8GXRYxBltQwTm56j0W8VI5HowfzZKIX8B/ixcGqlsNPo
	oOCSt+eKVxG9qWm0V4P17JIOPO4cvhiTK6iaqQ8Dx+Vnj95fHEvH3JAC+f2JWQ==
X-Gm-Gg: ASbGncvEbV6V3Qt5suK61IzOpu+BZOAwa3dwZ/ZlINaIDAtsIxX5rzAqQcJA4+b6/Dj
	vKqFqAh0P8+jVh/hYgrkIHwiMIEA/7nPYbU25yK5kiVjRvkZ/tH/ttaLEGTcMOkTlLaDtAz0PLB
	rlmfiLm+Cdoyyj0WVc9ehGKEWt2WF2J8CMHpyWRDUd8kvrWycox/EgTfC8qPMst9Vb0+oNdJS/E
	r5U6S6OBoEdxZDcfqNi+647z5F+uprhZ30pXotdQNUYYlQj4xM+fTbgx4zJJUqPc2cKVtVZc7fG
	lMAFWb3FF6/LdYy63cY3XPcNzfF86sxnHpDIFcInn29zOst+tO+lX1WU+nEKOPvB95cf
X-Google-Smtp-Source: AGHT+IHGseW83Fg6wHXcOlM4lgempnl0D8kkheTujSYIhmvJyR767uBtiYfzCLehRMFZVUEruSW2mA==
X-Received: by 2002:a05:6e02:1887:b0:3dd:cacb:b88d with SMTP id e9e14a558f8ab-3de38ca2f1dmr177420285ab.14.1750780759472;
        Tue, 24 Jun 2025 08:59:19 -0700 (PDT)
Received: from [172.17.0.2] ([168.61.208.12])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5019deaa0e2sm2267694173.28.2025.06.24.08.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 08:59:19 -0700 (PDT)
Message-ID: <685acb57.050a0220.3abe6b.7127@mx.google.com>
Date: Tue, 24 Jun 2025 08:59:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4321164801457189810=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pete.beardmore@msn.com
Subject: RE: Fix failure to register bt transport
In-Reply-To: <DBBPR05MB6283E530AA7B8138A19DAA008A78A@DBBPR05MB6283.eurprd05.prod.outlook.com>
References: <DBBPR05MB6283E530AA7B8138A19DAA008A78A@DBBPR05MB6283.eurprd05.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4321164801457189810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=975328

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.72 seconds
BluezMake                     PASS      3037.97 seconds
MakeCheck                     PASS      19.96 seconds
MakeDistcheck                 PASS      202.42 seconds
CheckValgrind                 PASS      279.52 seconds
CheckSmatch                   PASS      307.19 seconds
bluezmakeextell               PASS      129.87 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      928.37 seconds

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


--===============4321164801457189810==--
