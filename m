Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11DE299A81
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170094; cv=none; b=IYc8BNUmgGrAMQo5ZOMI9oOLrD3ps6dM8ayIfr8x55CDgbPQKVKsb8tR6RcRxruMJQMz9rcn9ggEb9L+3wbHseAb4hmuscDfW7N9Ff0fyFDrxILEOClpT4yvQpm+/oKiY7Mevga64VlyFhyRU8OzWKPt5HFy2DXlBjt6PQE80Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170094; c=relaxed/simple;
	bh=DLN5k4Q599sT+aUBxj2OFatcF8q/dpdktT2kq3c2t1g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aGf5Umc7W2DSanBfwssPSodCC3/KNbhoCyYPzx58drhbskiYY2KZ3OHD9YsvNXwtJjKMYBFCIr1htCPKMszJtq9/gsQfDlJR9Lw3nvZAQed50iEpLKIFYgAdRNXowBlgdo8SHXfJorq+FREZmLIkIc2Qng6cadUT5Nc7UP9gvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7kmjcET; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7kmjcET"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b704f08e73so1071629eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 04:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769170092; x=1769774892; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AmcvT/YKiN8Ee9Zv9z7nlLQTKm6x9bmMvBzdbSFsTO0=;
        b=N7kmjcET5inNbg1rEclip4kO9tOynnPhHWwDJj4az7g20zC5SA28pQLXzppxJ7OdGf
         60e0nJ+4aznGS/qcb9cY7v0Uy1esBFZLJQp3FYLJp8Lkns76zCjeQA0LMsbgSwDY2GlB
         xlcL6Ura9DBSBFSONnsTYsKxPQixWdF929i8nypSTgxA1PVZ1rQD0zDeAto8NP4gys26
         atcvVqCE+Q1YKTdSPqimdIFdDgtQKAh+gDoMr2Jg17QmQ6agSIhc/nDs8ijqnKMAOH4F
         zF9FR76Rzt7+3KJbOXowPqJ+fJToyFrIkOWG3Nebvsr1b8qXZ7mxTj2Z1bcEAd9BFmM5
         WxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769170092; x=1769774892;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmcvT/YKiN8Ee9Zv9z7nlLQTKm6x9bmMvBzdbSFsTO0=;
        b=l0vP5/6QwEHesVn5Z0utbGeCAvPsclcEfWx3X50tu9ZmjQPuX4sbg5wKjniol3pIP9
         J2lFbHcXlYpmpSrkE/7GpeArB0S+dHvVP/gbERYVr20nBxTeuGGkxFwN4trZIBCrN71n
         7uikYk8QpB9PZ/T+3/UyvFMqSn47SzLSdmiVPgsMVFxK8Z8q3OmXfKKUFri3Mi3Y9pvP
         fbMT+LaBP+ytry3GIobAL0Coy2UKdAsR1SKGs0TQ5IyxAp2gJiyahMtG0+l/FsEEBY2T
         GgNL/FCYbAkENjm+a2r6sGrJzRIvbcg9tudvGhdzVBbwrpNNO/xO01mENNn4Rm0gR+i4
         KHcw==
X-Gm-Message-State: AOJu0Yw2ovDHIQWAwZbdEi6AXMLo+78nKBHyNFliqHepgN8evl5yvlB/
	Q4rpQwQHgQ11HennTINhEhKNiNvyx2O5sVC/B/GvXLsuu7J7P1i/3lKFlbHBXdKu
X-Gm-Gg: AZuq6aL+uq6bQiLC0VrTCVF7Q13wX6AK0CzTk9bkWknF8zWS3/LS6RLVH3qJihF3mGy
	hTdlkjDYa41g1eji0eLepU57AWgdHRBqaLJx8NcEG9wQ9kLF1XjRf97ldO6q7csKG9KT28XaUA9
	NbcXdPRiLbqQphjN/CO701rlVHfr8rmU5GEznhgMhtVbtWSbkC6xZADgt74bOSyR8VgCXxOKaHF
	ypymqpGhVxPWSr3h4PSznqiA3tX831UMXnrgum8ve5+faQgBDqKUx3HGeb5ua/a0AL4Lqq1+jt+
	wk16faZVE1qcR5Q/n4gjgG1XzeKvzRXqdutswmqZ+5ktxHa5wVCqMsugGMq5kO4oMmOSQ+TkEYj
	hHB40YOXfaxrpJx22gQolFuY8wX7ie7zW4O1GmIgRcsQOMuDEfq1phZRGgiOz5KwxspDldMgAea
	RzEswchSlIoohN+ls9
X-Received: by 2002:a05:7300:188d:b0:2b7:1dd3:585b with SMTP id 5a478bee46e88-2b724715864mr3577409eec.7.1769170091535;
        Fri, 23 Jan 2026 04:08:11 -0800 (PST)
Received: from [172.17.0.2] ([52.225.25.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6f5d2asm2699118eec.14.2026.01.23.04.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:08:11 -0800 (PST)
Message-ID: <697364ab.050a0220.3b0410.f4d4@mx.google.com>
Date: Fri, 23 Jan 2026 04:08:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7261724941802846614=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ] monitor: Add support for Ranging Service (RAS) Implement comprehensive decoding support for the Bluetooth Ranging Service (RAS) in the ATT monitor, including:
In-Reply-To: <20260123110944.532088-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260123110944.532088-1-prathibha.madugonde@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7261724941802846614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1046215

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.45 seconds
BuildEll                      PASS      20.06 seconds
BluezMake                     PASS      652.37 seconds
MakeCheck                     PASS      18.34 seconds
MakeDistcheck                 PASS      246.08 seconds
CheckValgrind                 PASS      292.75 seconds
CheckSmatch                   PASS      349.63 seconds
bluezmakeextell               PASS      180.60 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      1020.51 seconds

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


--===============7261724941802846614==--
