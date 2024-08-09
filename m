Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA1D195F3A
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216579; cv=none; b=NfW6lkRrXCt8nj3ZlsZUkkTxqASoyPdcmo7zfffdeiTt8SXkDcgFvufGLir03Y0Px9+3YBjulTfuKUxKHojhaKKINfSRdKNkLBjz21z3OKJmjBBSzIWgq3XUsVS1kuBTd33AK36UvXXykBKYpqr8WLLMLqP+R4o9DkgGX/PnyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216579; c=relaxed/simple;
	bh=7s30kl2hGwcMqB7hnUd4lnPNLIdbs15Gfco0/MIMqbI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LuhD7R4AymFO5nZL5YkXH0gtgcBZfHh6mAdD7/NNAVxMIL2DeJ2uxkojRNke0RwS62NExSp8rNYLwysLDV6RPyQo/mZIg0Sm3V453Q51df0ZZDVzR6j7qOp50WeX6K+BkUN/f1bVBNpqV71Y1cZCpvBBM1cWuSrc9KTA680eTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=g+bjIhYH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="g+bjIhYH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fee6435a34so18985315ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Aug 2024 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723216576; x=1723821376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DWhs3Eo+k6455y5cO/fF1x8nNfizkQymMg/nMoN2Y0=;
        b=g+bjIhYH+qdmZkk5yZFFGlb+K9zGlL5DiQq/li5119BTIpMXjMEOFvEPtZH0vPIBbn
         2aMQLjmCqzY0YYTLWe50rb2yYm9WwHFlHCwv7DYmh5ew8tBgQE5++YzKkTJwJM/mTAxE
         wFRai3f0rpPiraA3OUSh2ozdNn/OWJwvfduLrEP1HC3EndNcGVHMlqCKst7w6prlS/Qk
         /k4beTFIYnBF74XREH5Dwq9GlRljlaXmRBwvDjUCnFtNMdXxFf/6nfRwr6ZbzPRChViQ
         kOTIa/lCKUZ1Lmta+8BjE0tvqKs4Hvu6/tFGzV7nR4dPwfSYPtFixifklFlW7fz33L+2
         w0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216576; x=1723821376;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DWhs3Eo+k6455y5cO/fF1x8nNfizkQymMg/nMoN2Y0=;
        b=IyGn4QwqFXeuZWOtw5kanvWb6FLY73/FDSKjpMJyhZ+HdwbHrwJ6Lmg8OkgvRuQEI2
         3CE1Psr1T1FuUetK+np9vpjX1vU6m4QaE9uEZnup6HlyfSEf2pP3bNz390swyOkamVF6
         5r+zbEpZu6ddy0ScY4YT7853JrSQOR2p8aSeyU+6ElWAVaGvutXt3y7JRGSCTrFCDEG1
         98iiq8AUml10cJ4B11HlBmEiuWjqTfIOQ+IhK0pGuAr33l9ru31/ZtdxvHxJ6AvrPKnm
         uqDX5ufA71rPBz+DvI8jZTJbJKJdTzbDpyIGqgvcTkR4PKQLWXeRaRMNcngJNS3iDAJf
         oGmQ==
X-Gm-Message-State: AOJu0YzwDSYDVBUleosAM5JKd+WQ7cKoU1S3Bb/I3P3SLuA2mi+GA2Ac
	+iCLpThQwMQSADnRZJ5WPHF3oJi5oGgaE+v/FhubyPKRYwzDczKl+Ec1gmgFWeY=
X-Google-Smtp-Source: AGHT+IEppLE+Syq3Pmv/bu7PNwnYIEFtHgnnRggBHLAXMEliLCJAJH4nFmDH3pAFBjAYcrZDgAnOqQ==
X-Received: by 2002:a17:902:f610:b0:1fb:4f7f:3b59 with SMTP id d9443c01a7336-200ae4ba851mr16040405ad.3.1723216575975;
        Fri, 09 Aug 2024 08:16:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905ee07sm143960395ad.153.2024.08.09.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 08:16:15 -0700 (PDT)
Date: Fri, 9 Aug 2024 08:16:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 219142] New: Potential Null Pointer Dereference in
 pair_device() in mgmt.c
Message-ID: <20240809081613.12aa21d5@hermes.local>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Network bugzilla bugs get routed to me and I forward them to the mailing list.

Begin forwarded message:

Date: Fri, 09 Aug 2024 07:10:04 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 219142] New: Potential Null Pointer Dereference in pair_device() in mgmt.c


https://bugzilla.kernel.org/show_bug.cgi?id=219142

            Bug ID: 219142
           Summary: Potential Null Pointer Dereference in pair_device() in
                    mgmt.c
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: yiweiz.evie@gmail.com
        Regression: No

The details of the bug are as follows:


1. Affected Components
Function: linux/net/bluetooth/hci_core.c hci_conn_params_add
Function: linux/net/bluetooth/mgmt.c pair_device
Module: Bluetooth connection parameter management
Code: https://github.com/torvalds/linux/tree/master

GitHub - torvalds/linux: Linux kernel source tree
Linux kernel source tree. Contribute to torvalds/linux development by creating
an account on GitHub.
github.com

Version: the newest version v6.11-rc1

2. Description
The hci_conn_params_add function is responsible for adding connection
parameters for a Bluetooth device. It first attempts to look up existing
parameters using hci_conn_params_lookup. If no existing parameters are found,
it allocates a new structure using kzalloc, which will return NULL if the
allocation fails. 
However, the pair_device function, which calls hci_conn_params_add, does not
properly handle the case where hci_conn_params_add returns NULL, indicating a
failure to allocate memory. The immediate dereference of the returned pointer p
without checking for NULL can lead to a null pointer dereference, causing the
program to crash.

3. Technical Details
struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
                                            bdaddr_t *addr, u8 addr_type)
{
        struct hci_conn_params *params;

        params = hci_conn_params_lookup(hdev, addr, addr_type);
        if (params)
                return params;

        params = kzalloc(sizeof(*params), GFP_KERNEL);
        if (!params) {
                bt_dev_err(hdev, "out of memory");
                return NULL; // [BUG] return here
        }

        bacpy(&params->addr, addr);
        params->addr_type = addr_type;

        list_add(&params->list, &hdev->le_conn_params);
        INIT_LIST_HEAD(&params->action);

        params->conn_min_interval = hdev->le_conn_min_interval;
        params->conn_max_interval = hdev->le_conn_max_interval;
        params->conn_latency = hdev->le_conn_latency;
        params->supervision_timeout = hdev->le_supv_timeout;
        params->auto_connect = HCI_AUTO_CONN_DISABLED;

        BT_DBG("addr %pMR (type %u)", addr, addr_type);

        return params;
}

static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
                       u16 len)
{
...
        p = hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type; // [BUG] P
is NULL
        if (p->auto_connect == HCI_AUTO_CONN_EXPLICIT) // [BUG] NULL POINTER
DEREFERENCE
                p->auto_connect = HCI_AUTO_CONN_DISABLED;
...
}

Vulnerable Code Stack:
pair_device calls hci_conn_params_add at line 3458 in
linux/net/bluetooth/mgmt.c
hci_conn_params_add is called and may return NULL if memory allocation fails at
line 2280 in linux/net/bluetooth/hci_core.c
pair_device does not check if p is NULL before accessing p->auto_connect. at
line 3460 in linux/net/bluetooth/mgmt.c

4. Potential Impact
Denial of Service (DoS): If the system encounters this null pointer dereference
during runtime, it could crash, leading to a denial of service. 
Security Concerns: While the primary issue appears to be a potential crash,
depending on the context and how the function is used, there may be other
security implications such as unintended code execution or information leakage.

5. Exploitation
For an attacker to exploit this vulnerability, they would need to:
Trigger a condition where hci_conn_params_add returns NULL (such as exhausting
system memory).
Ensure that the pair_device function is subsequently called with the NULL
pointer, causing the null pointer dereference.

6. Mitigation and Recommendations
Null Pointer Check: Add a null pointer check after the call to
hci_conn_params_add in the pair_devicefunction. Ensure that the function
gracefully handles the NULL case, possibly by returning an error code or taking
other corrective actions.
Example:
p = hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
if (!p) {
    bt_dev_err(hdev, "Failed to add connection params");
    return -ENOMEM;
}

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
