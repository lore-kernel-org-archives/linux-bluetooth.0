Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A82150980
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712952654; cv=none; b=T6G5KkEBkGTuHqDd9ZLktQTajvb7n+mJyBBYsxGTEsK2SawsJD9nz7aX0+H4MUk9BdiA3Q8WbFJ6pllr/1ixgNGrw78nmsL0Qgn4aLEEo/MUmVzhpad7VdeBKp07zv+B+0LdloiYdpRXsdr//b3XUuj1GdtUwyLGoBvlW4Kshgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712952654; c=relaxed/simple;
	bh=ZJ/CtlpptREofX0Q58zGhAZvaq5ug0/IZXNL/iDQOvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOPyQ8gGLTlNvalR3Nw3Zz8WAqPKQc/vW6QZN0T8WSY32u5bHl4qzHxOyv3FH8f4d45nHrWevQ1RIFDPGA6v9VFzyuO5Wf0usi6Ysj0CVa2Voll0i4WvdiR0XzV0N7lfv5rdqv/pt1+XrijYQwEfsfPaXNiv0SnQTuxtOsSRXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=NdU8gdRm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="NdU8gdRm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e5c7d087e1so5325705ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712952651; x=1713557451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mZlZuMl+bN48WyfYunCGzf9hPvvB70DPQTNSTlgY7BE=;
        b=NdU8gdRmOX3aGd/sRl8uq3SJ78MUfqIzlfQAV1BbfJlOQDwj8u6NFD2lcywP4PIWlq
         2Wzr7l083beec3an8hs1iLvQ709UpffmeSFrXDLV4w4axzzefdl69Nu+69pekn5mnYTk
         h9DABjS9smxrQal3dTOHwQxiY3TilSyXFJ8do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712952651; x=1713557451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZlZuMl+bN48WyfYunCGzf9hPvvB70DPQTNSTlgY7BE=;
        b=t99Mf01PXFAtzwsmYIiT9dcDk1zPSqEyn98YY9ITCnzh6MkAw7Jr07XmyGYyqi+suP
         Xe5cn2/12gBEszD6XEPRwF77flk3c4SY7Zgvs786xchZ6FPKTayc4OXyyFro38f3Lv1C
         d+Cww7uGhUNMYcPhcYVkziWfALFFUu5fmKw2NnrHq3ZQYTw7GlIqj9wHrAPWZSMCyDr6
         zOj//pIA1/vX+Bb1Ogonrq2k0BAmIqj83unaW2/7L4mCyDKF65jqy/V21SQTV3d/JAN9
         pg+3LFpNXSxwqKOqVkv6gzw079yL8E11C99RV5ar0Kc8IYsjcG9Aq+LF4Zd4OXbfb8Za
         YZtw==
X-Gm-Message-State: AOJu0YwNRR84GY/oEOgE6iOwl8t3sZniA4hwqfR2u1UZBU+oZVcFwuXg
	bkG4735khEzBOfpb4z//MoLpYIjH5pFKztRHIadBZKQ9LEQTo7lUFnAEjLV0tw==
X-Google-Smtp-Source: AGHT+IFr7yoAo5oJFhEbDrUpEkQtbXD6i+n/3k3vTkz5k6f66yGYnKU+/WWkXiwygGlM+hYe2VqUvA==
X-Received: by 2002:a17:902:ee41:b0:1e2:bf98:f1ce with SMTP id 1-20020a170902ee4100b001e2bf98f1cemr3462305plo.23.1712952651399;
        Fri, 12 Apr 2024 13:10:51 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b001e425d86ad9sm3462138pla.151.2024.04.12.13.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 13:10:50 -0700 (PDT)
Message-ID: <678721b5-4636-4268-836e-98c7a8ce36ba@penguintechs.org>
Date: Fri, 12 Apr 2024 13:10:49 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v1] tools/btattach: Add support for more QCA soc
 types
Content-Language: en-US
To: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 marcel@holtmann.org, jiangzp@google.com
Cc: linux-bluetooth@vger.kernel.org
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1712939188-25529-1-git-send-email-quic_zijuhu@quicinc.com>
 <1712939188-25529-5-git-send-email-quic_zijuhu@quicinc.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <1712939188-25529-5-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 9:26 AM, Zijun Hu wrote:
> Tool btattach currently only supports QCA default soc type
> QCA_ROME, this change adds support for all other QCA soc types
> by adding a option to specify soc type.
> ---
>   tools/btattach.c   | 29 ++++++++++++++++++++++++-----
>   tools/btattach.rst |  2 ++
>   tools/hciattach.h  |  2 ++
>   3 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/btattach.c b/tools/btattach.c
> index 4ce1be78d69c..024b0c7a289c 100644
> --- a/tools/btattach.c
> +++ b/tools/btattach.c
> @@ -97,7 +97,8 @@ static void local_version_callback(const void *data, uint8_t size,
>   }
>   
>   static int attach_proto(const char *path, unsigned int proto,
> -			unsigned int speed, bool flowctl, unsigned int flags)
> +			unsigned int speed, bool flowctl, unsigned int flags,
> +			unsigned long soc_type)
>   {
>   	int fd, dev_id;
>   
> @@ -111,6 +112,16 @@ static int attach_proto(const char *path, unsigned int proto,
>   		return -1;
>   	}
>   
> +	if ((proto == HCI_UART_QCA) && (soc_type > 0)) {
> +		if (ioctl(fd, HCIUARTSETPROTODATA, soc_type) < 0) {
> +			fprintf(stderr,
> +				"Failed to set soc_type(%lu) for protocol qca\n",
> +				soc_type);
> +			close(fd);
> +			return -1;
> +		}
> +	}
> +
>   	if (ioctl(fd, HCIUARTSETPROTO, proto) < 0) {
>   		perror("Failed to set protocol");
>   		close(fd);
> @@ -181,6 +192,7 @@ static void usage(void)
>   		"\t-A, --amp <device>     Attach AMP controller\n"
>   		"\t-P, --protocol <proto> Specify protocol type\n"
>   		"\t-S, --speed <baudrate> Specify which baudrate to use\n"
> +		"\t-T, --type <soc_type>  Specify soc_type for protocol qca\n"
>   		"\t-N, --noflowctl        Disable flow control\n"
>   		"\t-h, --help             Show help options\n");
>   }
> @@ -190,6 +202,7 @@ static const struct option main_options[] = {
>   	{ "amp",      required_argument, NULL, 'A' },
>   	{ "protocol", required_argument, NULL, 'P' },
>   	{ "speed",    required_argument, NULL, 'S' },
> +	{ "type",     required_argument, NULL, 'T' },

I am guessing this means that there is no way to determine the soc from 
the kernel without the assist of the IOCTL? I also see this is a 
required parm. Is this not something that can use something like a 
devicetree for discovery so that the type of soc can be a property of 
the system instead of being manually specified?

>   	{ "noflowctl",no_argument,       NULL, 'N' },
>   	{ "version",  no_argument,       NULL, 'v' },
>   	{ "help",     no_argument,       NULL, 'h' },
> @@ -221,12 +234,13 @@ int main(int argc, char *argv[])
>   	bool flowctl = true, raw_device = false;
>   	int exit_status, count = 0, proto_id = HCI_UART_H4;
>   	unsigned int speed = B115200;
> +	unsigned long soc_type = 0;
>   
>   	for (;;) {
>   		int opt;
>   
> -		opt = getopt_long(argc, argv, "B:A:P:S:NRvh",
> -						main_options, NULL);
> +		opt = getopt_long(argc, argv, "B:A:P:S:T:NRvh",
> +				  main_options, NULL);
>   		if (opt < 0)
>   			break;
>   
> @@ -237,6 +251,9 @@ int main(int argc, char *argv[])
>   		case 'A':
>   			amp_path = optarg;
>   			break;
> +		case 'T':
> +			soc_type = strtoul(optarg, NULL, 0);
> +			break;
>   		case 'P':
>   			proto = optarg;
>   			break;
> @@ -298,7 +315,8 @@ int main(int argc, char *argv[])
>   		if (raw_device)
>   			flags = (1 << HCI_UART_RAW_DEVICE);
>   
> -		fd = attach_proto(bredr_path, proto_id, speed, flowctl, flags);
> +		fd = attach_proto(bredr_path, proto_id, speed, flowctl, flags,
> +				  soc_type);
>   		if (fd >= 0) {
>   			mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
>   			count++;
> @@ -317,7 +335,8 @@ int main(int argc, char *argv[])
>   		if (raw_device)
>   			flags = (1 << HCI_UART_RAW_DEVICE);
>   
> -		fd = attach_proto(amp_path, proto_id, speed, flowctl, flags);
> +		fd = attach_proto(amp_path, proto_id, speed, flowctl, flags,
> +				  soc_type);
>   		if (fd >= 0) {
>   			mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
>   			count++;
> diff --git a/tools/btattach.rst b/tools/btattach.rst
> index 787d5c49e3bb..4aad3b915641 100644
> --- a/tools/btattach.rst
> +++ b/tools/btattach.rst
> @@ -62,6 +62,8 @@ OPTIONS
>   
>   -S baudrate, --speed baudrate       Specify wich baudrate to use
>   
> +-T soc_type, --type soc_type        Specify soc_type for protocol qca
> +
>   -N, --noflowctl            Disable flow control
>   
>   -v, --version              Show version
> diff --git a/tools/hciattach.h b/tools/hciattach.h
> index dfa4c1e7abe7..998a2a9a8460 100644
> --- a/tools/hciattach.h
> +++ b/tools/hciattach.h
> @@ -19,6 +19,8 @@
>   #define HCIUARTGETDEVICE	_IOR('U', 202, int)
>   #define HCIUARTSETFLAGS		_IOW('U', 203, int)
>   #define HCIUARTGETFLAGS		_IOR('U', 204, int)
> +#define HCIUARTSETPROTODATA    _IOW('U', 205, unsigned long)
> +
>   
>   #define HCI_UART_H4	0
>   #define HCI_UART_BCSP	1

-- 
You're more amazing than you think!
