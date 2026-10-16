Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83973D9523
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133358; cv=none; b=df6fHlHUVt09nTIsywNSW6LXrkUhOmXefIN0KxZxeNPM0XzCxVmYX/zAMgBmESHGYbKnqgWm7eUa5APYF+KfyJIdYlNXnnecsKabGWLUjXQTswLQh08oG7Jai08/KFrGte3GL+PmMRM/O7OlpGD7amfNnu5HIvNJay/R8Jwwur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133358; c=relaxed/simple;
	bh=s3anJmAF71SGOdbmyGVbZpu/vKmD9EC36nXM/R7mmiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFhidx/Ffu/PlQPxgULvxrq7NvGAN+fCnODdfatM2wMYGIq4ZOwhdjoPPXAn2o/ApGexNgkWVEebV+9rjl3Sa2NvZxFwjCaphslIfjbKskmHQDjaU9TIMM4ZBq7lok7xyx8cu8G1I3RJ/fbBYiTqh8cY0LgODtGGs/VnhJcJKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PcpeuoIF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcpeuoIF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so34319825e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 23:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792133348; x=1792738148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:from:references:cc:to:subject:reply-to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjYKa8DIKuvjh+VVUAQH4onZZeigp/qLBTebXWbeIHQ=;
        b=PcpeuoIFPtsRL4dqinUQmmo6dMRrYt2Fgl8fSYal0jWsFGDN01mIMJsKSFkr4FxCzB
         aXe/Z192qqQ8zD9hDv/6lpYKmqZZUBfqnPVdc931mPvQ/U4x9czwDjDnByiYwqkJ5mQ3
         IPqsEVX/xUuG2ERYzgWvsSrpn0yfvJGD8ZxAOWP6fxMVDRbuYKfgtggN/eljsLKpaDBw
         yZjNQZ8HjEPMuTIuxqG3h9YYJ+XBgdKBvcDjb/G473l2GxAEU6InHXAYvbkUp7CJT4pt
         zFMg/yl0Rk3lfgPCLpXR3Yc3eaDxDp9y3Z0YlIFUlUE3fhA7ir88OuIpoPRKA3EqjrB0
         QI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133348; x=1792738148;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:from:references:cc:to:subject:reply-to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sjYKa8DIKuvjh+VVUAQH4onZZeigp/qLBTebXWbeIHQ=;
        b=KOnFr1fzanzvg7EO46+bN3GONUJiVvFeTT5uX18eBbnM7flwso8sb7ljBZln8gL7yj
         iV7LbeiUqYl+Iyc2x32VC3HB6eeToHYSucwG7XOEw1XHZj/OqAEsmoZxhh9qMTlTfqpX
         II5IgJWC9HjCQ5LT33P1MJED+iraYPbs2q+SqDAefgVW5zr5U17g4vYagDUjssPRa/o3
         cNLvmIXmRUrJC2QovEIn8weZQotnZFxA+WdUQ8nLCbrdDbdlAYCbZOWwohtM2GYqgG2r
         Ztkm/pFDUog+7dI+tbQSWsW7JyE/ETlM49b7P28Zke0RYyoAyMMJu52IRqTjnTaoMdHN
         K0yg==
X-Forwarded-Encrypted: i=1; AKwUvBwCHfGod8mQxm8qyXRKJQNG/9wNeV/wraloY1Zipk7s/Q62HEPup+Kth7TpADvq0pTsiHOr7zDdS5B4O1KgBDI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAg/NDh9po2IeasNKsbriRDP+JxO85Cj7Ps5HDY2jb3TluuM/M
	wXIbJ4nmqQ+dv+vSCUgp8cUx7KfyV66cUiaBJpB+1d19WkHwdOMNQLWYISvV7H3EwcU0tZf9iGq
	hSn++m1c=
X-Gm-Gg: AYBFou2h/SzX27KvW6AGcaEUw5u4IZSwXVsRtYjIRQkzKUsLgKGcazlDBUI9SnH06mF
	+SJIQOT05V4ixqJsjJHQPZJBy3sO4nPTDc48Gd8Mwbdyx+CuziE7trmKKaiEJitcAKr6CEKXeH1
	y4bXdhkEVHHesXM0PClObi4FHeQAZlA933TdlKXik+jhT4PR74ml8ZIpZcjgEJ1/CP/0GW7LqXC
	qgM6Q/kogQjzsADaT28XPvvX0KxHAJZmW1PYMwMOoTojc30CFPq1+ayuucOJKDV9HpUy1rLguz9
	p9NmnClk+7IejUGVbvLT1/pZlyi9Nv4XMEATHWcNN5un2rh1vXyeszyV4AVwyn5AxaU+Nls5gg9
	QZayaa/pTtZ0QbrUOCx2Gn+jtDJQAz4FlnHVun+62W+5FZPWGaF9leK4iLDSVG3QUh1fa7U9iXl
	9LJclftHnyZ+AgtPq318iaS7WGh1odO+pGofTete6sesfvNLCm9KB3nwwuqfVR0t80/AizshfH7
	HrENrwPNDAKKHjZuf05Nr/TtDxyc+FE9BHqnB1CgKPqX+ffk7TSgQ==
X-Received: by 2002:a05:600c:8106:b0:4a0:c02:938c with SMTP id 5b1f17b1804b1-4a18e4d683dmr439002795e9.25.1792133347816;
        Thu, 15 Oct 2026 23:49:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3de7:deff:62ea:d0f8? ([2a01:e0a:106d:1080:3de7:deff:62ea:d0f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8af3f8dsm33220615e9.9.2026.10.15.23.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 23:49:07 -0700 (PDT)
Message-ID: <bdb9fdd8-215d-4220-8275-5fac170ed71f@linaro.org>
Date: Fri, 16 Oct 2026 08:49:06 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3] Bluetooth: hci_qca: disable power control for WCN7850
 when bt_en is not defined
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260324023016.3889062-1-shuai.zhang@oss.qualcomm.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260324023016.3889062-1-shuai.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/26 03:30, Shuai Zhang wrote:
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
> Changes for v3
> - Add change history.
> - Link to v2: https://lore.kernel.org/all/20260319075125.76539-1-shuai.zhang@oss.qualcomm.com/
> 
> Changes for v2
> - Expand the commit description to include the affected platforms.
> - Link to v1: https://lore.kernel.org/all/20260319031040.4096297-1-shuai.zhang@oss.qualcomm.com/
> ---
>   drivers/bluetooth/hci_qca.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c17a462aef55..4512ff7cd0c0 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2484,7 +2484,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>   
>   		if (!qcadev->bt_en &&
>   		    (data->soc_type == QCA_WCN6750 ||
> -		     data->soc_type == QCA_WCN6855))
> +		     data->soc_type == QCA_WCN6855 ||
> +		     data->soc_type == QCA_WCN7850))
>   			power_ctrl_enabled = false;

This disables power_ctrl for WCN7850 soldered down on the main board and handled by pwrseq, which is a regression.

When pwrseq handles the QCA_WCN7850 qcadev->bt_en is obviously NULL, but qcadev->bt_power->pwrseq is not.

The test should be `if (!qcadev->bt_en && !qcadev->bt_power && !qcadev->bt_power->pwrseq`

Neil

>   
>   		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",

