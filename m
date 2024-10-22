Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538119DF40
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621757; cv=none; b=hq8VfUk1R0JGisfjtuPBGunFrGUKFxthPtx8ax7O0MpZ7sQYdJiWSNnfkFA8m1hWH0+Vg7qhd9w7cS9Xe3ZIEI3E2DSCUnQAvuWyye904U02Y5p/7Xf5R3pOjDQvk3HObHH79iuHUaqeANhcWqfyyVuBo2Srq49LTX/2JIOumaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621757; c=relaxed/simple;
	bh=rXDPb/1V1TCF4fFPvgxHORTNF6q3F6NRtOexGOAmGVg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sSAzQnHg8J3lvYZ5XikQNr4rdKgh/Wfbxxuz663+Ri8fLJDZvxoBA4sZeiXKShEl070cW7dyF7MIuFRWoKOI7sun6XNAHxwKZWCtydZD9pP7Ybbl4ck7Y5qSOUK1gIofzIKS1cgMbnktmgLUF8PbDCx/rZEzVqn7mt1GcyhXHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qqfx/Lnd; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqfx/Lnd"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so37991516d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729621754; x=1730226554; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XoBBcpMh7LtVTYTY1GxdgGmac1DQxwZhbFSUvOJ+E3I=;
        b=Qqfx/Lndkyipjvt7U0O7w2uyQBFIlwqk6RUN8oFN0HDNNEQrGUeUAKIA457xLrJ9Eb
         iw6OVOuuxDAG2B9rMBGqVPyLYBztZjHekpengZBpiIKrMOMGGDe+RgX0/95DUAOnK6vT
         6pBx5k1O6qFDtCvNn6w3trKxtDRkzqqMePZG5Ey3R45lnkTDgEZUGzM9TobyXu2ouKBs
         zIzKetIGvdi64wkCB8loT9JIDZJhTAXmwMggjWrgZu8bxTMGHAwgcB82MCyNb98eeBxQ
         xE+VThIj1fXoox7e8j4XDSbzP9gtQ9niVRJ1jLhLCLFQn81SG0cnftBvTjHlkHBtsw7K
         sncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729621754; x=1730226554;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XoBBcpMh7LtVTYTY1GxdgGmac1DQxwZhbFSUvOJ+E3I=;
        b=dwNw3L4uUeqGPmOd7CZ42IbbTPt2Y7xecGFodQAwR/51QgZYLFvN/tkcM8psQ/9EsX
         EQaaOD25fM+PVj/zBlKAAWPBLV6D1k0RKarNU6SU7n6usWcGy695Ph4bhSvRa7IQ53RF
         cztBzzrCnkNvNT0iL3I4+4OQ/4cMvN6mvrzjrOT8LEuSwU5xoBJRwCwvaX7UHSW+IDSI
         bd8GTw4xk4hllkxnvV9FZ0ls0ie/Qjyvu+tHeaZWCA23iSWEZsK9UbGNp3NgqbfRmWnY
         oqjryNsGyohjmXcGVY3m1tAuiAh/Rr8p4kHlgWzH5vDV9kaDGyKl4cklAlNnmSzFkMmf
         Rr2w==
X-Gm-Message-State: AOJu0YySUN4z/ASy8JvuDNRCZFZ4MKiQsHtR+AEzh7OzrorbT+Tinn/K
	P5gKO9Ha9Dh3S8ZfzvnaT++vGRyNMJ3jrcTm4wE/zrR1lf/p/S+VlxR3Kg==
X-Google-Smtp-Source: AGHT+IFwkn5WspM68iYK04sO7c0Cbjxw6hXzEUIVD7Fir82XdjzLpkA8C7edOQq951bExtfc+kJf+A==
X-Received: by 2002:a05:6214:4589:b0:6cb:e53d:dd7 with SMTP id 6a1803df08f44-6ce34256af0mr788266d6.19.1729621753947;
        Tue, 22 Oct 2024 11:29:13 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.196.147])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009e4407sm31298696d6.126.2024.10.22.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:29:13 -0700 (PDT)
Message-ID: <6717eef9.0c0a0220.8c96e.aeca@mx.google.com>
Date: Tue, 22 Oct 2024 11:29:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4133855133881412992=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Fix bluetoothctl --help hanging if daemon isn't running
In-Reply-To: <20241022141118.150143-2-hadess@hadess.net>
References: <20241022141118.150143-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4133855133881412992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=901846

---Test result---

Test Summary:
CheckPatch                    FAIL      3.54 seconds
GitLint                       PASS      2.41 seconds
BuildEll                      PASS      24.73 seconds
BluezMake                     PASS      1737.88 seconds
MakeCheck                     PASS      13.46 seconds
MakeDistcheck                 PASS      180.52 seconds
CheckValgrind                 PASS      254.65 seconds
CheckSmatch                   WARNING   358.75 seconds
bluezmakeextell               PASS      121.22 seconds
IncrementalBuild              PASS      11429.59 seconds
ScanBuild                     PASS      1028.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,2/7] client: Use g_clear_pointer() to clean up menus
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#66: FILE: client/admin.c:194:
+static GDBusClient *client = NULL;

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#66: FILE: client/admin.c:194:
+static GDBusClient *client = NULL;
                    ^

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#87: FILE: client/assistant.c:393:
+static GDBusClient * client = NULL;

ERROR:POINTER_LOCATION: "foo * bar" should be "foo *bar"
#87: FILE: client/assistant.c:393:
+static GDBusClient * client = NULL;

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#109: FILE: client/player.c:5697:
+static GDBusClient *client = NULL;

/github/workspace/src/src/13845731.patch total: 5 errors, 0 warnings, 46 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13845731.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):


---
Regards,
Linux Bluetooth


--===============4133855133881412992==--
