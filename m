Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795590701;
	b=iQsuKBfie9QDqHDt6hPfcCf4X1xcmd/q4HhLyAdVJipetxfotm+lVCNKDNpvJuntFjBa
	 NYj5oNq7V8dSJHaI1LwiQlRsCnKAn6C0Z8Q2RWNboD8F2YyC0IcurEJkXtR8ZHOzbB2h/
	 fLZsj5Hvjkj5Ny+brM6bu8NsAKCXY3x+foKIYvWLCcV1XjqeUUlAl23hCBimzVIVhzqKt
	 qedKrfIEpaZ8wmZX+dVCcyLNIqbnXh8KRn6djb9K/7id0uG349hrY4H1WE8vkgBHVPO12
	 RFAbxHYWJRg3VIzXU40XK7+6kBVcp5q72CL9N1K/hQQZDqBy8PQ0pW6hz1VMWBw6mwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795590701;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6A/xOgrEoperC/hazMKVGC8Rci1HbBlmDTVjZLyiHns=;
	b=ujbHokWBztj2JEcH72RgV0QGk62fVg2Pvx6N9YrcDdwtOyowla5+OAzHr1zMJ1OtiF4J
	 hX0K8ojBivF6dzss+i1IOh5zzRA+U6wO3MifT2bEN5bvRir6JNxjcUFlFOdn0Q/u2Io1T
	 0DwqTgeKnMWweLfG5mFG3KtnOsbl+95yeNnentFymHpx85i/OyZlNYjQDEe7dL+9dsU/m
	 9o8szJIu9jLqUD8z+TfpfQKdHhs8/TDq6VtDk9I+K+Hty8Pkn7FIdZ5nJPanRZ2r7S8b6
	 HrLUd55IcYe555MT29rORrLhTHpBrzs0vpEpXPz1zDwzCNGsb3BAw6YHKRHSsXeYkpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bxgg4Rzp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V0mUju5q;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9830A606A6AC
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9830A606A6AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bxgg4Rzp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V0mUju5q
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP69tAV1006331
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6A/xOgrEoperC/hazMKVGC8Rci1HbBlmDTVjZLyiHns=; b=bxgg4Rzp/fJWpTeB
	uxmZr+b6v4fSyAwN5IeJ5013iZSqwPpoOXcEPP8MP75eEAUmE8sXy0sBUsk8DFkT
	anAn4NCQiFhLUb5gti141J6EWCWRHwxkeIfLJS2EO6l3VJ1t62X1baZeDT938Cn7
	RoIP6Mhu65W8UVZ6vpAEnxospKg+VZ5CZQHGxZfLTNwAgMAnWdrnahifJ7oywYnV
	qYzUr3sRz701cYNBrJBYz2jHlg9lwFhA+P4SLb+3xc/sxtHUZnDL3GXT4f7Uv6Rs
	c4gsV3OUknE3Kmm5NBUR49mQIditf3h10QMiZ0XLa2Eyi9peOuy2OAClEa/iC+Q7
	a8UtYQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5qa28u0t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:11:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e876e33e6cso7165055ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 23:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795590696; x=1796195496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6A/xOgrEoperC/hazMKVGC8Rci1HbBlmDTVjZLyiHns=;
        b=V0mUju5quIUNMppH+k3NQvCWYtZAYYWJrrimj8engmHwircPnI2Q9VkullBWE5h1UO
         q5byYN5J4mxEwR9l4Jatqzr8+cz6zJxHgFd9jeJ6xv5ve2w8PleN1qGhGCL26hZQCloa
         N/P33NyYa6LEGCbQw1PL3OxqxzmSSm40FBb2Vs9HYveg0P5uFtrwF4zgHsgmbr/WojrL
         AJqdfAezJMbsmDB3Y4GHIKv/P7zLh81/oj8tLJTbxcTQsd8YYcpYG8InkTmd1lsjFP9q
         8It9GP0kpQ8pzU5NGEMKB4auHIi1MjN/I1EKNdGYi5ZbEgCcqCZyqTIth9ZdSvLQfsNp
         iQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795590696; x=1796195496;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6A/xOgrEoperC/hazMKVGC8Rci1HbBlmDTVjZLyiHns=;
        b=W1/yJyNxsEUAk+F37btMZgqcV69i/bEiwbCsJwOwP8a5GXxsXmhFxccY4MtQmXs6MT
         cL+roghXdln/1/QWGBVpGn/B3t+/OD6A2u+gLN+7yAfuudyHmh6xnCgQeqp+nkrbRXqP
         vxxvxCc/pa0TD7JKSr8+r17zdO1MlZMdq30fffyCAmm9wkzAsbYcIF0jyWjmmaa4xMHe
         Lz/dG5YliAwaAuo8UcUy0oE9QebGIlKTyS1t8NJpDGDHS1eIv/1FgJfhwcM73L4dmrB8
         wxoUK3iZ3+SVkR7jec2Ymcd8+9lk/QvrdxGS0Iqnhbsq27i1peabVZo/HNClFIroVrZN
         J95w==
X-Gm-Message-State: APuU4Z+xmitwGwCFDgOvODYfZ1UaGGRkaj7seuIeQVfxRomd4UyHWYEo
	b9R4A/ROF6+d1c+l6LkZptsehShmyIlJGpdibpY5lybpDzZFNqB8kRQEgRar1G5lwvPJJpWVLVg
	X1GFqBkS9/alHkcA+TMK6Qc0J3+PfFj+FF5I8XbIAdZ30opu+VnPTFGUArfJ7D9XjSZIFrOc=
X-Gm-Gg: AZFdTZe6i8+26MWxWtrNktV5sYoYf7iZ7/aNUQvL0y6LSp8xR2+0ZdRb+lBOhyWp20X
	TMKkuWeXqud/FKcmSxIfR5ecdr1yBb1MkpLEh2aRC66ri0U2Yka1/oALlWMhFY6+txW32sGtsFM
	PvUqbb7ycxFGEqK5oMIRseeueLp6A9UHddGIlt2rrN2VrPU1dmy7jjkXn8pVOUIqrqUOGhahgip
	K0b4If+XP/KZL8Qa36BMxuuc/z8jYM7wM72H5EldIH+bdpjPVok0xvuCO2zz23rf7n7OfmYjXY5
	tryz/o0ujOkQeoE/5TjKr+shSBT9phdJLPTyrIo1+9vD73pkt2/WIrHWG1nu4SUXF2r7s2PyusA
	fBRSR/LkDB5wYpsFyOaWo//9kGYL/jKAhz0lcJeI/mvm8mAhVDvSCEgxCnEdcJNHzdN7qyHFzul
	b+WJOo5cKViWTpOx8etfX+saoA2zRgp5W5C94cmTc=
X-Received: by 2002:a17:902:ef45:b0:2ef:d8ce:83e6 with SMTP id d9443c01a7336-2f03edf6f5cmr258244805ad.0.1795590695830;
        Tue, 24 Nov 2026 23:11:35 -0800 (PST)
X-Received: by 2002:a17:902:ef45:b0:2ef:d8ce:83e6 with SMTP id d9443c01a7336-2f03edf6f5cmr258244485ad.0.1795590695265;
        Tue, 24 Nov 2026 23:11:35 -0800 (PST)
Received: from [10.249.17.192] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0b8a43768sm24561095ad.31.2026.11.24.23.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 23:11:34 -0800 (PST)
Message-ID: <6956c4b4-d096-42ed-ae49-c15ddf5893be@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 15:11:32 +0800
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez 2/3] tools/test-runner: Support running on arm64
 hosts
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
References: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
 <20261122-tr_arm64-v1-2-4eccf35daeca@oss.qualcomm.com>
 <edb6288e11cf9eab058cada5151c0c071587eb3e.camel@iki.fi>
 <249d8212-f68a-4eee-b92c-efb339dd9de4@oss.qualcomm.com>
 <CABBYNZ+-8kb2wA4fd5oYq=_hi9BSfFwie-RSpsZdVbCM57qCUQ@mail.gmail.com>
 <eb42aa05-3065-446e-b257-b08477e04c6f@oss.qualcomm.com>
 <CABBYNZJbEbXWVocnyvr2_Yb46xC9_1vJv2tULuZ4sFWu4SRjiw@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZJbEbXWVocnyvr2_Yb46xC9_1vJv2tULuZ4sFWu4SRjiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: y6awHk47JG-2bccTWSPPqm0LixCDT3yn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyOCBTYWx0ZWRfX4OyJ5lHaYT0a
 HWffv8v6pmaoS8eEyHFBIaNtgZ/RIybzKEYhY9uSEURAl9RQP0RmoqaRoCX8RIEx41ehtSjlYdr
 ZLfGAc7gpOgvSOOSIBQNpSTD69hcUh0=
X-Proofpoint-GUID: y6awHk47JG-2bccTWSPPqm0LixCDT3yn
X-Authority-Analysis: v=2.4 cv=CKu/zhrD c=1 sm=1 tr=0 ts=6b068a29 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=L2Cj-ZBLs4x9qKkbYQAA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyOCBTYWx0ZWRfXz/F9PeY4eL+l
 3Jsj+8r3MuzVUqOeCioyhfzte/Z7LI5zOnES4mM66tCIJDbOIHmz7Qfu2r9GeWJ42dPGKOVJeC5
 PCQvFPU2uZOQKH3cbhFAuzlfJY6ykEtPmg43QiZVZCSv1cCmBAY7tEiWyg1DY6MLmeOItUxRtyK
 PsfrASZul04hWrP+PpOu4mCrN6YPOZzE1tYRfmzLX//u9mL3cCrTG3TOWSJTmYgs8mn/tyAS3fn
 YcibV8szyN9BCmLFj74KatU2hK4x3bC79zdOODHgnJnUQ8RKNxoxYcEGYjjcjs8/v6jwgKQHvix
 xfvas8f2NoxTdu08asNWceop1qGABq23YEbyx7ezwheA6rNMya/erTQ/lMV4k89rMEZ6DgKOvTw
 6qoDB+Xuvsl7Ukud5149Pn8O2sQvpwYX/i0cMuAPF//wXv/0HMumvY27VH4PrWq2qrfGF1k1PwR
 RULP1LCo1kY0OLsACgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250028

On 11/24/2026 11:20 PM, Luiz Augusto von Dentz wrote:
>>> I guess that is a fair point: the tools binaries would have to be
>>> built for the same arch of the kernel image. However, that doesn't
>>> rule out running test-runner on an x86 host while mounting the rootfs
>>> with a cross compiled tools. I guess we shouldn't recommend that setup
>> That doesn't work, e.g. on an x86 host:
>> test-runner(x86) -q qemu-system-aarch64 -k arch/arm64/boot/Image -- /bin/bash(arm64)
>> since test-runner(x86) can't run in the arm64 guest as the init
>>
>>> since it's counterproductive and considerably slower to compile and
>> Agreed. Actually, test-runner requires:
>> arch test-runner is built for == host arch == guest kernel arch
>> and failing when this rule is violated is expected.
>>
>>> run. That said we could perhaps print an error if the user attempts to
>>> pass a kernel image of a different arch; test-runner should probably
>>> fail with a clear message stating that this is not supported.
>> So, is it acceptable to illustrate this rule in the ARCHITECTURE
>> section of doc/test-runner.rst instead of parsing the various guest
>> kernel image formats to detect the arch and print an error?
> Well, I'd think it probably trivial to parse the header to check if
> the kernel image matches test-runners arch, or you have a problem
> doing that?

For arm64, the check below has two issues:

1) It has false positives, since unknown files are accepted and
   check() may return 1 for a file of the wrong format
2) It is a lot of code, already ~90 lines for arm64, and x86 needs
   more on top

So I'm not sure it is worth checking user input this way.

Do you have a simpler and better check to suggest?

struct kernel_image_desc {
	const char *name;
	size_t min_size;
	/* -1: unknown, 0: not supported, 1: supported */
	int (*check)(const uint8_t *data, size_t size);
};

#define KIMG_HDR_SIZE	128

#if defined(__aarch64__)
static int arm64_image_check(const uint8_t *data, size_t size)
{
	/* arm64 boot protocol magic at offset 0x38 */
	return memcmp(data + 0x38, "ARM\x64", 4) ? -1 : 1;
}

static int arm64_image_gz_check(const uint8_t *data, size_t size)
{
	/* gzip magic and deflate method */
	if (data[0] != 0x1f || data[1] != 0x8b || data[2] != 0x08)
		return -1;

	/* gzip carries no arch field, accept it and let QEMU decide */
	return 1;
}

static int arm64_efi_check(const uint8_t *data, size_t size)
{
	uint32_t pe;

	/* MS-DOS magic and LINUX_PE_MAGIC of EFI bootable Linux images */
	if (memcmp(data, "MZ", 2) || bt_get_le32(data + 0x38) != 0x818223cd)
		return -1;

	/* PE header offset at 0x3c, machine type follows the signature */
	pe = bt_get_le32(data + 0x3c);
	if (pe > size - 6 || memcmp(data + pe, "PE\0\0", 4))
		return -1;

	return bt_get_le16(data + pe + 4) == 0xaa64;
}

static int arm64_uimage_check(const uint8_t *data, size_t size)
{
	if (bt_get_be32(data) != 0x27051956)
		return -1;

	/* ih_os IH_OS_LINUX and ih_arch IH_ARCH_ARM64 */
	return data[28] == 5 && data[29] == 22;
}

static const struct kernel_image_desc arm64_kimg_table[] = {
	{ "Image",	 64,	arm64_image_check	},
	{ "Image.gz",	 3,	arm64_image_gz_check	},
	{ "EFI image",	 64,	arm64_efi_check		},
	{ "uImage",	 64,	arm64_uimage_check	},
	{ }
};

static bool validate_arm64_kernel_image(const char *kimg_name)
{
	uint8_t data[KIMG_HDR_SIZE];
	size_t size;
	FILE *fp;
	int i, ret;

	fp = fopen(kimg_name, "re");
	if (!fp)
		return false;

	size = fread(data, 1, sizeof(data), fp);
	fclose(fp);

	for (i = 0; arm64_kimg_table[i].name; i++) {
		if (size < arm64_kimg_table[i].min_size)
			continue;

		ret = arm64_kimg_table[i].check(data, size);
		if (ret >= 0)
			return ret;
	}

	/* Unknown image, assume it is good */
	fprintf(stderr, "Unknown ARM64 guest kernel image: %s\n", kimg_name);

	return true;
}
#endif

main():
#if defined(__aarch64__)
	if (!validate_arm64_kernel_image(kernel_image)) {
		fprintf(stderr, "Unsupported kernel image %s\n", kernel_image);
		return EXIT_FAILURE;
	}
#endif

