Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CONnFlVg"
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2251708
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 18:47:04 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77f3159d822so66286585a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Dec 2023 18:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702003623; x=1702608423; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9NmyVWtYaWZQ3E9RAZhRdbWDVjXtN86SpSlvWA+fLg4=;
        b=CONnFlVg1uLbTT4dICeYrM0x+yyLbfQlPF19vB+uUhf2pl8RGIib2yCQct16VDYoky
         Q87k7/RUQqQSnib3QSTnh30es/gM4gc+WnBl7llB4Hv8AFdeB/b8kCgxnGWtkFzoHBjj
         F21KXe8JtOaEhTCskOA6dls/I/IWqdrQhPRUAXShRZW0qlViYzKXNR2iHXos67Fn7uct
         XlyuEYafpksAiFemDhQ1RxlpD2F+BaANgGBNELxAPr0YByYlR4Xzii+uON7bGdXjBmmC
         zYbJELj04XnUX03VUPnDynLDemwm3wRmgn7opgr1AQh+b+c10PHWEBl1ThRFrhPVwSR1
         lhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702003623; x=1702608423;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NmyVWtYaWZQ3E9RAZhRdbWDVjXtN86SpSlvWA+fLg4=;
        b=uBTwE3TBlZ2pTFSpXikU0vPx33A3ahoG3bkVBPXCd8jlQbJuLPfGkdDMGE9XmKyx6m
         wqYo+xUt0QYJBDmvk04fZD3Rht9G0rP11GWM9K0QYhaVCQE3mFWYK0ul08Q9b9pIfS7j
         I47hJkiz8fRJESp6PbsdE2WMR87fDLLnTUpUmO4NScKvuzPRgVx4GcNEnRJ9+j/+TAsI
         ChWKg50uFlv/MSgxYhSoXF6r3uZ5o7sYAxIxkHB8iQzkU76euudxOgUS4j8JPc66khYb
         We9/l3ajU0mnwBfbFsbZ1YiWyJ0U1t1iTcIX53CLkGBxHRmF/4K5UYJTsIrjQ0edRVt2
         tXWQ==
X-Gm-Message-State: AOJu0YzJkhrTBJWkDxvRQFd1jK7khQ3rYh2wjMj6sG0gD4I2Dr8HhL/I
	1G64wY+n6gNIShreZG2wmgUndqypBao=
X-Google-Smtp-Source: AGHT+IHUl8ngbYLkeD9GV/jJ5KmH16jqaO0O8+nxMzbzLHbnjUwkfxfiOFFC0lNh3MdfmWbZRvhkTA==
X-Received: by 2002:a05:620a:1448:b0:77e:fba3:58ff with SMTP id i8-20020a05620a144800b0077efba358ffmr2139065qkl.144.1702003623426;
        Thu, 07 Dec 2023 18:47:03 -0800 (PST)
Received: from [172.17.0.2] ([20.75.95.198])
        by smtp.gmail.com with ESMTPSA id a26-20020a05620a439a00b007788bb0ab8esm372477qkp.19.2023.12.07.18.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 18:47:03 -0800 (PST)
Message-ID: <657283a7.050a0220.9cf04.292d@mx.google.com>
Date: Thu, 07 Dec 2023 18:47:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8418100413837451287=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Bluetooth: Support SCO offload for QCA2066
In-Reply-To: <1702000287-22538-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1702000287-22538-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8418100413837451287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808064

---Test result---

Test Summary:
CheckPatch                    PASS      1.30 seconds
GitLint                       FAIL      0.87 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      27.21 seconds
CheckAllWarning               PASS      30.70 seconds
CheckSparse                   PASS      35.45 seconds
CheckSmatch                   PASS      98.65 seconds
BuildKernel32                 PASS      26.75 seconds
TestRunnerSetup               PASS      420.51 seconds
TestRunner_l2cap-tester       PASS      22.91 seconds
TestRunner_iso-tester         PASS      44.71 seconds
TestRunner_bnep-tester        PASS      7.03 seconds
TestRunner_mgmt-tester        PASS      166.15 seconds
TestRunner_rfcomm-tester      PASS      10.97 seconds
TestRunner_sco-tester         PASS      14.63 seconds
TestRunner_ioctl-tester       PASS      12.14 seconds
TestRunner_mesh-tester        PASS      8.86 seconds
TestRunner_smp-tester         PASS      9.88 seconds
TestRunner_userchan-tester    PASS      7.41 seconds
IncrementalBuild              PASS      30.27 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,1/2] Bluetooth: hci_conn: Check non NULL function before calling for HFP offload

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[v4,1/2] Bluetooth: hci_conn: Check non NULL function before calling for HFP offload"


---
Regards,
Linux Bluetooth


--===============8418100413837451287==--
