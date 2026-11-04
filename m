Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801330;
	b=ojTG3xkfIEsZ4FW+8Ve/X+1pgeowumzn3GRC0d15cVhkKTKgSvehy7PCb6EXMSo17Oa7
	 DAG0AFymZlvVHrmo+O+6Lwyb2IRGsCesz/QtlqGO11BW4SdKB96i4OCVa08HbWZGWhOaY
	 J8KpilVWH1IYFXzn5QyzjOegezuleXXKriC/Tfzilhuj8dCvY1wNC8gwyWLNF0AYwoaRH
	 ZwqZf1mFRPqvwq6Pqh/wxxx9bkHa5LYaPq0AF2RvB1qU6Sei0arwtR0ZgFj2kvyd7INdQ
	 HJcB209spNrnbIJE2/kZzNvBRZMdWAxlJWdOsWQ22MdkP2PeM1fQ+rhlHgrUXoKVEDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801330;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FDQxvaAQImmURkc3bgaPvBRjpqmeWfgOB36Ro55edAo=;
	b=3kpOLEhvDYAp6PKbxXAwKPewt0K1XcvKfJe3lD6+N/zZz7kcnFrbz85NG+FyIDdEPMrB
	 z8v+yQ2nrYIER5nZK7nVymkrAzZCDiSzomVaylEMBAu0tpmon9FQivQgY7P0Cvozh3Vag
	 UG/cK+ukyAxV9yTK22HP2BI36yfmeHMpZF1CHCxy5uA6WredeUMf7HS7xYM+siQNYd2pl
	 sIPFNsH6dgvXhIaklWlyfgBd5Fq0gYIeMUEp80tIVUTtCjixJgjK3exJmQJADy4mrjEkk
	 FtKr03qaeiRzNGkI2jLf4JDp+cL/phXUaOQHXvWihjp4vpLWWHjsxcH8/arOXCdCmrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTYeTOBi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F36DD606A331;
	Wed,  4 Nov 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BTYeTOBi
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B28391F00A16;
	Wed,  4 Nov 2026 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801329;
	bh=FDQxvaAQImmURkc3bgaPvBRjpqmeWfgOB36Ro55edAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BTYeTOBiF62ffVdTLfLZyDiy/WfImQbBoboDPXQ/fi5TTy7fcEEbp3DFS3NCJfhZY
	 MEhiEzwLBpyLT449ce4TLyUPdF/CRqG5TvrGAacNMTgjL4g838hYz1etMBxzyiFZVE
	 e6jeTbsSIx7DhFTam8faBwQA2YJFGe4x51RfQBAvuuhi/r3OCiWvC8tELHt9QA8cPY
	 mVTUsV/AIBohTDgCt0nBYW4y75ll1I94i8BXQoj1vod7fXR4qPWbYJxKDqmpXJfRKn
	 FTHY25UmiMvvxslX44hlgspw66fGmUMIweYInwmy08v/DDt5bMpGMBbxCtQ6ph7OAc
	 cljlpkr/ZCL4g==
Date: Wed, 4 Nov 2026 15:08:46 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Subject: Re: [PATCH] Bluetooth: hci_qca: WCN3988: Drop baudrate change vendor
 event
Message-ID: <47swivwl7ex5zccgxkvj7zbdnn4qrfc7z2npxqhrcv2fjqxog6@5t4h3x5miw26>
References: <20261104095026.3414666-1-shuai.zhang@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104095026.3414666-1-shuai.zhang@oss.qualcomm.com>

On Wed, Nov 04, 2026 at 05:50:26PM +0800, Shuai Zhang wrote:
> Firmware download on the WCN3988 sometimes fails and is retried:
> 
>   Bluetooth: hci0: QCA TLV response size mismatch
>   Bluetooth: hci0: QCA Failed to request file: qca/apbtfw11.tlv (-84)
> 
> The vendor event answering the baudrate change command can arrive late
> and is then taken as the response of the last firmware segment, which
> waits for any vendor event. Its length is 2 instead of the expected 3:
> 
>   < HCI Command: Vendor (0x3f|0x0000) plen 220    (last segment)
>   > HCI Event: Vendor (0xff) plen 2
>           92 01
> 
> Drop and wait for this event on the WCN3988.
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
 
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
