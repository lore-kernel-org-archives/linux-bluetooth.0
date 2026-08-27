Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529247427B
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847388; cv=none; b=Xy4t2sjw51YmhxIgfOKSdznnA7VjG7KsV3u27k5FWKh+p+P/InVGUrH/5GPR60/t4EWJasWsuU5GXa6rT8T64wR5zrazQzmRztWjY+IuUY+Obkmy4utDq0HLCIKlQ7wiUsl74PYYbohx3qzfLXp3kjtznrqqmfK8XQHx7suY4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847388; c=relaxed/simple;
	bh=52AuLPfkU8mzdGLrOFclJqpdM9KWdb4TXYHkVpw/IzQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=toBMKkg8h09vHC6iYHdUqYUQpgSmTVEUmkJ5pxv9UH+BD0VliHeuAJ2LvY06FPAMR7/TBpcQjgro4H2gFVKJCN4NiM4gnEKz+W23Q72r/XUZprCiJTAos9xsTgz9txgejkH8Sccc7seU1g75489BmVVNUnxkW0w8LyFGm3M030I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dntoaMTL; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dntoaMTL"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52cd38ddcdfso403811cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787847386; x=1788452186; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GtWjDaCpIVF6/E+CQHdh/FK2kUs7zTjAfNoms0B6yeU=;
        b=dntoaMTLbLyaF7lKcjC5+1VfNZtAPcbulA4zusJnpTTUhgsgTj8PmRAuW2sDBcRfv6
         mHw1C+TTvOt1oQN75x9sroBwTOqL+4+02aPDzy+f2USqNvhgEdOxMVzQH8hraKAtVii0
         Rpyt820/pENWyc5qDCEtRqXh7z43xFV+1IJ+mbAqeEkqdOj3D7F3as9o1pgscinAkeAk
         r+4VubDbrfZX+RyTeNn97x8We+iTYdv90MBlppsKdw1Xd48Qc3M9gl/PqngJMI5WB562
         iz6FNZ6VSyi/879vKUFbl3NZbuTqGBENuHxFcUS7cpQxb9hCjNkNVoJbYN9PI/2o6yk9
         Q+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847386; x=1788452186;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GtWjDaCpIVF6/E+CQHdh/FK2kUs7zTjAfNoms0B6yeU=;
        b=iC7nFy72V9AxVm9LrHJG2T5gSDIUvWSvL4OTNlVtPGvySpLAAhHxbNxr3jbsvUvA4J
         9bDJyvMmmT3K1yvCuPS3gAk4E3hUE7OyrH2DPapoCe1PmYo99YX4T4zabt0VCqM/McES
         jvDDXUBYZHUnwE9gVibJWlsjcDcAQC9yK2TiNku4E50LMiJaqqUxsZrXtuCJESbnCEit
         K9kc6nNRCHnNnpfuBpI1DEXofqxVQkejuUpmwPH2CmCYZMUOSpy1z1eGwoueJXzEA/XU
         1J/hf92be+nPAQVVQAs4hInYgBgsHufZ4IN+XfsvZavyd08hoAGvSLVc+sO+Xnp6Ewkn
         pi8A==
X-Gm-Message-State: AFuF++nK7KdX1gnhKUH397bf+yhbEMXlfbhm11j36EeYc++8VDLCjOp+
	vkLyv7LwWeTQRg24tfvqno4Fi+57HP+Y/6LlIW7rFy6Ug9J+qcGG0NdxA6y7bA==
X-Gm-Gg: AR+sD12i+AIQVdCk1ojaGs4Cu4tBtxH/ueOHPylcJsEGZ+oGdG8AYOlOLMHVjSMORcp
	mEtkpb2zkIrxtpqrH7GqBqSevLsTCnzL2qzEUd/IYYJ5gLGj+I+hr9BZvqKl9L/8LVkOPomQ+M7
	1C0VVqlpema6Z2LFktlQ55i7enCtFShmEvZ5QFIo8zJ+iIbRJ59T7jd5ofqToI6C40DBtxEnrum
	VWpuB5P2/dlkeZYo+HXdJ5KV7mkZz4QPA00uhvpeQXmaAqKymipGOTEJNv8qrW5QCLDPsNP8Tjj
	h9kWpFD6zyxS0ZgLONKUBJH5SXBNhh8cqv2R9bErpv9Gn5IL6RTslclQywnHu4HiAcWVmFZP8ox
	oPPtNrQGTVC1auMbN/jrFt/pDmg+xjVLduTKph3h8FTPM+tqlbWg9WpM7trupk84uLSsmfNvgi/
	4SZmOjRXPRVyflw6M7LuQZTPodCPLOb3J7QKhOzIPb5/YeAx5bb2bi/wWIcZGsSM6mK3eW
X-Received: by 2002:a05:620a:7085:b0:914:b9a2:f29d with SMTP id af79cd13be357-9378041f08dmr1703651985a.37.1787847385059;
        Thu, 27 Aug 2026 09:16:25 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd73fc328sm19953626d6.36.2026.08.27.09.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:16:24 -0700 (PDT)
Message-ID: <6a9062d8.057d2789.17578e.0a82@mx.google.com>
Date: Thu, 27 Aug 2026 09:16:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7223648224369157320=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: bass: Fix heap buffer overflow allocating subgroup_data array
In-Reply-To: <20260827145652.1566826-1-hadess@hadess.net>
References: <20260827145652.1566826-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7223648224369157320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152688

---Test result---

Test Summary:
CheckPatch                    FAIL      0.47 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      568.03 seconds
MakeCheck                     PASS      1.07 seconds
MakeDistcheck                 PASS      160.97 seconds
CheckValgrind                 PASS      148.32 seconds
CheckSmatch                   PASS      301.79 seconds
bluezmakeextell               PASS      100.22 seconds
IncrementalBuild              PASS      596.27 seconds
ScanBuild                     PASS      948.51 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
bass: Fix heap buffer overflow allocating subgroup_data array
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#50: 
bass_build_bcast_src() in src/shared/bass.c parses the Broadcast Receive State

ERROR:BAD_SIGN_OFF: Unrecognized email address: '@thaidn and @bronson-calif of Calif.io in collaboration'
#59: 
Reported-by: @thaidn and @bronson-calif of Calif.io in collaboration

ERROR:BAD_SIGN_OFF: Unrecognized email address: '@trace37labs for the Fixes'
#61: 
Suggested-by: @trace37labs for the Fixes

WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 8980f4f1f730 ("shared/bass: Functions cleanup")'
#63: 
Fixes: 8980f4f1f7 ("shared/bass: Functions cleanup")

/github/workspace/src/patch/14771428.patch total: 2 errors, 2 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14771428.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2441

---
Regards,
Linux Bluetooth


--===============7223648224369157320==--
