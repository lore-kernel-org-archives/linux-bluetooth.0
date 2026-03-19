Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C1364E9E
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912930; cv=none; b=DQxNnBousTW7NtZiKy39i8HSs8bPuTlgEmQh2pPv6I3lZHlrjlSTW1jsakQQiIklYCiDNVAnnVmw3lLckYvHuicLZZX+nd3NVLDUtnAWGawniFwzrpMU5KMvFhTkruyTf8D/tMnFUQNEfc8mYee0KqwXTCbAgaUsNeVuMRzGXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912930; c=relaxed/simple;
	bh=g1LWNtK2afsolgGOeq9xwfIE/uPBToXU24tUFiliqEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/A60pNWyNdvlFsvwkOVtlQJaRP7PM76Jz02b35C8QhXByYOUDMDhTIYEZcLdX+0wpkpQ1Vth9aHOG3hB1RRoxVLPvxn7sx3EstIVWhntpA4DdkzXpCTPms7SbhPghTXA8vdbSHx2tGKw1r3zUF04Q6GVD18FKCa1NTa051vR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBq50bJe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBq50bJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E813EC2BCB5
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 09:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773912929;
	bh=g1LWNtK2afsolgGOeq9xwfIE/uPBToXU24tUFiliqEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fBq50bJer10MVsg4hF03FYSa4cfVWRFeOuhSdcPenQpmfKVw8HF0EysCf4clNm1CN
	 8213qZMkWISXl3/UNIYXMOgazuo3NVRYPVDGfyKQWPS/W8KTjoUPAm6uPOj5PRBgwG
	 qOMvfTdHgXIFfvUUxjM2HTg3bzdekTrHo6/LlajRNI1ejroTZ92rE+jia9TcVi/73v
	 CUMYBB4gPIliJPq2O2O7qXZuo0UwGFPuA8Vk2bsTEi0GyM1HhI0gWUNe4qJz4Mg25R
	 CvXS2xiTVdXZkRRQ7NHJQS9Dzj51dFWSRAc8ZMkFNhnTSAg7j/T+UgGLy8kqxvBt/o
	 x32b4LxflyEOQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a279ce9475so1527610e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 02:35:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQWkgvG/BrMsPO8OkE1ooNVSd83+vMg9jbagZnoILhwb4Ta4HAIcxnMpiwmDrdq7wG8kgeX1MSqJd25W1P79k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMIfwEqiFsJYq8vUvuSoZh9XnJzjrdyAJflFTP3drPhiFr+AX
	MgC5xdaX+vY3RNo9aDg2C/uD5CO6FR380an7hNlDNZz7tW5DQlCTLAmnpsCwTvNHd9pvVtDJf6B
	11zoC2hslZoQKfnnNLyFt1eXpwZUnv+ZQ/0Qhub6Jvw==
X-Received: by 2002:a05:6512:79a:b0:5a1:425b:c7c9 with SMTP id
 2adb3069b0e04-5a27de293cemr556765e87.20.1773912928532; Thu, 19 Mar 2026
 02:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319075125.76539-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260319075125.76539-1-shuai.zhang@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 19 Mar 2026 10:35:16 +0100
X-Gmail-Original-Message-ID: <CAMRc=MdRGdR=FyQHWC7yfAgpAFxiK6QGjEQXVr7mavWLOPS14g@mail.gmail.com>
X-Gm-Features: AaiRm51W5vgNLXZhG86rE-1b9a2hDSmG2E6LDcCJVpoZZZP4XJEsSJ03tuKE5hY
Message-ID: <CAMRc=MdRGdR=FyQHWC7yfAgpAFxiK6QGjEQXVr7mavWLOPS14g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_qca: disable power control for WCN7850
 when bt_en is not defined
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com, 
	quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 8:51=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> On platforms using an M.2 slot with both UART and USB support, bt_en is
> pulled high by hardware. In this case, software-based power control
> should be disabled. The current platforms are Lemans-EVK and Monaco-EVK.
>
> Add QCA_WCN7850 to the existing condition so that power_ctrl_enabled is
> cleared when bt_en is not software-controlled (or absent), aligning its
> behavior with WCN6750 and WCN6855
>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---

What are the changes in v2?

Bartosz
