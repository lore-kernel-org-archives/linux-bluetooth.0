Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DAB746E
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Apr 2024 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712977955; cv=none; b=TyYIhj+HhxSn8Y8tdRl66aP4/P0xYMtebfJygJ+V9JQzelZkhVtqS+ggCzt6AEDHDdpV9Chna9mz3ygsqZTL7l5FJHHm5Ogee59N7oNe/VBErdHpI3B2hEyvjFoz9HvU3PFmPkZGLAPgIl3YxkjcBM64FkAJr2oMmHzOCOb7u6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712977955; c=relaxed/simple;
	bh=XlE5SlHj3Toi51nkw3nlMcYZmCZMf7JrRVn/40wbJJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuXZarRu5uIbrc5os0P0mlmKDeGMXzIA089Cg3Zh4utqa1KLQYca0+DBoImvg0i5nlqngbC3b5Wbp6UoANaU8LBo2ZmbGVEHAwvnKNPMvk/trBRP83dHxsl0vLmHEWvrIvjNBzTuHz1aI3GFeaZLZ20VbKTMHD4NsoAlexQOd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=fiHCFehS; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="fiHCFehS"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22edb0ca19bso845861fac.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 20:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712977951; x=1713582751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mgdoiEv/k03ZgYwFdDHx0r6gwNwzox39PQEwhuXE/w=;
        b=fiHCFehSZJGf7vrZtf84c6Ju5HcEsdoWIBmv1DiEbchD2neeMK3kRkPVpyPpZLjoqZ
         a/dRAAGi7iNpB2jpJ/WyFKDv3NkdbVx/Q/rKmC98k/BEgqf64trYGHcj4JvzavuMEeEL
         Rh5l5SxbxM+4C3R2Eba8viETXUvgijOuzFXtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712977951; x=1713582751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mgdoiEv/k03ZgYwFdDHx0r6gwNwzox39PQEwhuXE/w=;
        b=f0F8F47sYqS3mhXqvpQc7ONR1JHlqG7nHX8Yu7roAoJx28k70OaATuj4mRLwzQn7wJ
         g0wqAbCeU3nasffnRH7J5EHROA9ydj1MY66w7D49ES1ffhZuv2I1CX9XbYAb+ffPEr83
         F2RTh9YYONg20lMaKftu/y3GNkISjwuUxKuHlxfVXr6bKfyefPBelT5NTB8Vluo0QEQ4
         SliA3qiBKXqXV0f3v9OtNT0pdD2il7j5ckfTDQK4vvqbYxhdvXpIswbaBFgGT0+WimDZ
         wJNetMIBHQS+5jeJR2yNkILPJ7KEXN0XpQT7DO7WBsCrQQOQlKT6yCuOV/GvC1A0m+vt
         Cp/A==
X-Gm-Message-State: AOJu0YzxE4DQHQHzSPBPBuSe+25iwQogy1hlhtZOpzY1fZJkZrSlBaxz
	6WbMvqOs1wFNQBq6B++IQLvI4GmEQGnwHO3F3j+dJPSYgvj8/XFGFl0kj381+A==
X-Google-Smtp-Source: AGHT+IFbDIYjzCM1A4VPD3jClqZSgGx3yRmMCIKd9/I/oTwkWOMOKRNc04vI+Kgn7Cu6O6NkFHGKpw==
X-Received: by 2002:a05:6870:5589:b0:233:55b8:edf1 with SMTP id qj9-20020a056870558900b0023355b8edf1mr4971661oac.8.1712977951161;
        Fri, 12 Apr 2024 20:12:31 -0700 (PDT)
Received: from [172.16.102.235] (c-98-45-34-39.hsd1.ca.comcast.net. [98.45.34.39])
        by smtp.gmail.com with ESMTPSA id ei40-20020a056a0080e800b006e6c81b6055sm3587295pfb.6.2024.04.12.20.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 20:12:30 -0700 (PDT)
Message-ID: <ce11e5ce-13ec-4e40-8083-7319f72beb20@penguintechs.org>
Date: Fri, 12 Apr 2024 20:12:28 -0700
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
To: quic_zijuhu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 marcel@holtmann.org, jiangzp@google.com
Cc: linux-bluetooth@vger.kernel.org
References: <1710914907-30012-1-git-send-email-quic_zijuhu@quicinc.com>
 <1712939188-25529-1-git-send-email-quic_zijuhu@quicinc.com>
 <1712939188-25529-5-git-send-email-quic_zijuhu@quicinc.com>
 <678721b5-4636-4268-836e-98c7a8ce36ba@penguintechs.org>
 <5bcf5034-fea4-43c6-ac7d-db6f24b88512@quicinc.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <5bcf5034-fea4-43c6-ac7d-db6f24b88512@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/12/24 7:44 PM, quic_zijuhu wrote:
> On 4/13/2024 4:10 AM, Wren Turkal wrote:
>> On 4/12/24 9:26 AM, Zijun Hu wrote:
>>> Tool btattach currently only supports QCA default soc type
>>> QCA_ROME, this change adds support for all other QCA soc types
>>> by adding a option to specify soc type.
>>> ---
>>>    tools/btattach.c   | 29 ++++++++++++++++++++++++-----
>>>    tools/btattach.rst |  2 ++
>>>    tools/hciattach.h  |  2 ++
>>>    3 files changed, 28 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/btattach.c b/tools/btattach.c
>>> index 4ce1be78d69c..024b0c7a289c 100644
>>> --- a/tools/btattach.c
>>> +++ b/tools/btattach.c
>>> @@ -97,7 +97,8 @@ static void local_version_callback(const void *data, uint8_t size,
>>>    }
>>>      static int attach_proto(const char *path, unsigned int proto,
>>> -            unsigned int speed, bool flowctl, unsigned int flags)
>>> +            unsigned int speed, bool flowctl, unsigned int flags,
>>> +            unsigned long soc_type)
>>>    {
>>>        int fd, dev_id;
>>>    @@ -111,6 +112,16 @@ static int attach_proto(const char *path, unsigned int proto,
>>>            return -1;
>>>        }
>>>    +    if ((proto == HCI_UART_QCA) && (soc_type > 0)) {
>>> +        if (ioctl(fd, HCIUARTSETPROTODATA, soc_type) < 0) {
>>> +            fprintf(stderr,
>>> +                "Failed to set soc_type(%lu) for protocol qca\n",
>>> +                soc_type);
>>> +            close(fd);
>>> +            return -1;
>>> +        }
>>> +    }
>>> +
>>>        if (ioctl(fd, HCIUARTSETPROTO, proto) < 0) {
>>>            perror("Failed to set protocol");
>>>            close(fd);
>>> @@ -181,6 +192,7 @@ static void usage(void)
>>>            "\t-A, --amp <device>     Attach AMP controller\n"
>>>            "\t-P, --protocol <proto> Specify protocol type\n"
>>>            "\t-S, --speed <baudrate> Specify which baudrate to use\n"
>>> +        "\t-T, --type <soc_type>  Specify soc_type for protocol qca\n"
>>>            "\t-N, --noflowctl        Disable flow control\n"
>>>            "\t-h, --help             Show help options\n");
>>>    }
>>> @@ -190,6 +202,7 @@ static const struct option main_options[] = {
>>>        { "amp",      required_argument, NULL, 'A' },
>>>        { "protocol", required_argument, NULL, 'P' },
>>>        { "speed",    required_argument, NULL, 'S' },
>>> +    { "type",     required_argument, NULL, 'T' },
>>
>> I am guessing this means that there is no way to determine the soc from the kernel without the assist of the IOCTL? I also see this is a required parm. Is this not something that can use something like a devicetree for discovery so that the type of soc can be a property of the system instead of being manually specified?
>>
> yes for tool btattch scenario. tool btattch is mainly used before the final board configuration phase(change DT|APCI to enabel BT), so it can't get such soc type info from board configuration.
> for tool btattach, it doesn't need to touch any system configuration and is mainly used for variant evaluation tests before the final product implementation phase
> 
> let me take below process to explain its usage scenario.
> Customer often buys a BT module from a vendor for BT evaluation, the BT module have BT chip embedded and are externally powered, the module also has a BT UART converted mini usb port,
> they connects the BT module to generic ubntu PC by a USB cable, then they run tool btattach at the machine to enable BT and perform variants BT tests, when the evaluation results is expected,
> they maybe buy the embedded chip and integrated into there target product's PCB, then change and compile DT to enable BT formally.
Thanks for the explanation for a total newb. This is really cool to 
learn about. Really appreciate your taking the time to help me out.

> thanks
>>>        { "noflowctl",no_argument,       NULL, 'N' },
>>>        { "version",  no_argument,       NULL, 'v' },
>>>        { "help",     no_argument,       NULL, 'h' },
>>> @@ -221,12 +234,13 @@ int main(int argc, char *argv[])
>>>        bool flowctl = true, raw_device = false;
>>>        int exit_status, count = 0, proto_id = HCI_UART_H4;
>>>        unsigned int speed = B115200;
>>> +    unsigned long soc_type = 0;
>>>          for (;;) {
>>>            int opt;
>>>    -        opt = getopt_long(argc, argv, "B:A:P:S:NRvh",
>>> -                        main_options, NULL);
>>> +        opt = getopt_long(argc, argv, "B:A:P:S:T:NRvh",
>>> +                  main_options, NULL);
>>>            if (opt < 0)
>>>                break;
>>>    @@ -237,6 +251,9 @@ int main(int argc, char *argv[])
>>>            case 'A':
>>>                amp_path = optarg;
>>>                break;
>>> +        case 'T':
>>> +            soc_type = strtoul(optarg, NULL, 0);
>>> +            break;
>>>            case 'P':
>>>                proto = optarg;
>>>                break;
>>> @@ -298,7 +315,8 @@ int main(int argc, char *argv[])
>>>            if (raw_device)
>>>                flags = (1 << HCI_UART_RAW_DEVICE);
>>>    -        fd = attach_proto(bredr_path, proto_id, speed, flowctl, flags);
>>> +        fd = attach_proto(bredr_path, proto_id, speed, flowctl, flags,
>>> +                  soc_type);
>>>            if (fd >= 0) {
>>>                mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
>>>                count++;
>>> @@ -317,7 +335,8 @@ int main(int argc, char *argv[])
>>>            if (raw_device)
>>>                flags = (1 << HCI_UART_RAW_DEVICE);
>>>    -        fd = attach_proto(amp_path, proto_id, speed, flowctl, flags);
>>> +        fd = attach_proto(amp_path, proto_id, speed, flowctl, flags,
>>> +                  soc_type);
>>>            if (fd >= 0) {
>>>                mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
>>>                count++;
>>> diff --git a/tools/btattach.rst b/tools/btattach.rst
>>> index 787d5c49e3bb..4aad3b915641 100644
>>> --- a/tools/btattach.rst
>>> +++ b/tools/btattach.rst
>>> @@ -62,6 +62,8 @@ OPTIONS
>>>      -S baudrate, --speed baudrate       Specify wich baudrate to use
>>>    +-T soc_type, --type soc_type        Specify soc_type for protocol qca
>>> +
>>>    -N, --noflowctl            Disable flow control
>>>      -v, --version              Show version
>>> diff --git a/tools/hciattach.h b/tools/hciattach.h
>>> index dfa4c1e7abe7..998a2a9a8460 100644
>>> --- a/tools/hciattach.h
>>> +++ b/tools/hciattach.h
>>> @@ -19,6 +19,8 @@
>>>    #define HCIUARTGETDEVICE    _IOR('U', 202, int)
>>>    #define HCIUARTSETFLAGS        _IOW('U', 203, int)
>>>    #define HCIUARTGETFLAGS        _IOR('U', 204, int)
>>> +#define HCIUARTSETPROTODATA    _IOW('U', 205, unsigned long)
>>> +
>>>      #define HCI_UART_H4    0
>>>    #define HCI_UART_BCSP    1
>>
> 

-- 
You're more amazing than you think!
