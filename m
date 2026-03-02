Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3387175A6E
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442016; cv=pass; b=Yh3nmrHBHCN8XWbWhkSQEFh6uM5H2+D+FAxpDcdgdynIsusFmMr4MPf0bZOy8sAHMDXUlQQJj17JB5LcFUqdOlpBFJoxQa+UbqWAlmmKO5S8/GHzbqy3GEGRVqdmDcMK7goINDGGyrBdYBbINoovzwazYDXXd//VXrFYrgwmR04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442016; c=relaxed/simple;
	bh=Eq9PLsqU6n4hyxaOIGX869l+UBMAVJ3r4TuxlH8U9YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=krJdMJOeHCPSGjyYjoDX0bs7dAbMPADXkWaNHXxO0IaRA+nEyPfPVnxpc/GJuLxaGEmhYEO35t6fRkkyhNHfOwid+SnA0Kf1HpWzuwjL2o+je6Kkr91EXEToFmbWW+TQ9iw3Fz5RqUUwbVz2TNvAOP5n/l0yya/1aSLMnUr6QiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=hkcCR/tB; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="hkcCR/tB"
ARC-Seal: i=1; a=rsa-sha256; t=1772442006; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H7295RdxDQc81piMFgNnR+oF8KdfRiNt0zWQufNRXea9NsAEOxF+ulj/TPDQWi9Zz0TMiER186HhWwEJ45/8lTbQ5LA8tkTPFJaYnGW6u43cTEsrTLTriZHs6G4Ic5ad8Yi106tF1wrLpJPyyR3Vis4y+Ydaq2p9O64iu6aeA2Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772442006; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=J5WWr7u7V8PgqoSqCoN2hfQhB6KpOUsCdjkVlhTtqg8=; 
	b=BoIZAxptYubN3O5n3U4TsRvhQFZq+pJFi5ME7i0XRNQsdi1dnsrBr1D3+kvKpGkmQzVg73to1TbDhN1mpntuKoGgYeBPUSKiGmkHZ6T90YMHykZ/9hfepPSjQ0b/pc98TGwho+fRYYTQI4+uUk2QjKsikQD56KEe28sdScPMeYs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772442006;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=J5WWr7u7V8PgqoSqCoN2hfQhB6KpOUsCdjkVlhTtqg8=;
	b=hkcCR/tBMb318STGsJCvy2VIrfX4M/Xf+LFUcXxy39sxU1LUhW0Wt2tFUuoyORQa
	XTjgH+Wxf6HtrvD2Lh91mlAAEGG7ZCK35S5dw/ijzXKCr26679u/dQdOPEUDY400lYW
	ZhNCIK597GmijPCqbMOxKI/1CkAL8kOONQRjs7dc=
Received: by mx.zohomail.com with SMTPS id 1772442004819825.569561025359;
	Mon, 2 Mar 2026 01:00:04 -0800 (PST)
Message-ID: <26087e38-531d-4cbe-b7f3-b68d39f0d70d@collabora.com>
Date: Mon, 2 Mar 2026 10:00:02 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 15/15] doc/qualification: l2cap-pts: add
 descriptions for LE CFC tests
To: Christian Eggers <ceggers@arri.de>, linux-bluetooth@vger.kernel.org
References: <20260227160022.21462-1-ceggers@arri.de>
 <20260227160022.21462-16-ceggers@arri.de>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <20260227160022.21462-16-ceggers@arri.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Christian,

On 27/02/2026 16:54, Christian Eggers wrote:
> All these tests depend on TSPC_L2CAP_2_46. Some tests require kernel
> fixes.
> ---
>   doc/qualification/l2cap-pics.rst |  10 +-
>   doc/qualification/l2cap-pts.rst  | 215 +++++++++++++++++++++++++++++++
>   2 files changed, 220 insertions(+), 5 deletions(-)
>
> diff --git a/doc/qualification/l2cap-pics.rst b/doc/qualification/l2cap-pics.rst
> index da7de524181f..31f60e144ac4 100644
> --- a/doc/qualification/l2cap-pics.rst
> +++ b/doc/qualification/l2cap-pics.rst
> @@ -46,7 +46,7 @@ Capability Statement
>   +------------------+----------+----------------------------------------------+
>   | TSPC_L2CAP_1_5   |          | LE Data Channel Initiator (C.4)              |
>   +------------------+----------+----------------------------------------------+
> -| TSPC_L2CAP_1_6   |          | LE Data Channel Acceptor (C.5)               |
> +| TSPC_L2CAP_1_6   | x        | LE Data Channel Acceptor (C.5)               |
>   +------------------+----------+----------------------------------------------+
>   
>   - C.1: Mandatory IF L2CAP 0/1 "BR/EDR (includes possible support of GAP LE
> @@ -167,11 +167,11 @@ Capability Statement
>   +------------------+----------+----------------------------------------------+
>   | TSPC_L2CAP_2_45  | x        | Send Disconnect Request Command (C.21)       |
>   +------------------+----------+----------------------------------------------+
> -| TSPC_L2CAP_2_45a |          | Send Disconnect Request Command - LE (C.22)  |
> +| TSPC_L2CAP_2_45a | x        | Send Disconnect Request Command - LE (C.22)  |
>   +------------------+----------+----------------------------------------------+
> -| TSPC_L2CAP_2_46  |          | LE Credit Based Flow Control Mode (C.19)     |
> +| TSPC_L2CAP_2_46  | x        | LE Credit Based Flow Control Mode (C.19)     |
>   +------------------+----------+----------------------------------------------+
> -| TSPC_L2CAP_2_47  |          | LE Data Channel (C.20)                       |
> +| TSPC_L2CAP_2_47  | x        | LE Data Channel (C.20)                       |
>   +------------------+----------+----------------------------------------------+
>   | TSPC_L2CAP_2_48  |          | Enhanced Credit Based Flow Control Mode      |
>   |                  |          | (C.23)                                       |
> @@ -282,7 +282,7 @@ Capability Statement
>   |                  |          | 'Guaranteed' for Extended Flow Specification.|
>   |                  |          | (C.7)                                        |
>   +------------------+----------+----------------------------------------------+
> -| TSPC_L2CAP_3_16  |          | Support Multiple Simultaneous LE Data        |
> +| TSPC_L2CAP_3_16  | x        | Support Multiple Simultaneous LE Data        |
>   |                  |          | Channels (C.10)                              |
>   +------------------+----------+----------------------------------------------+
>   
> diff --git a/doc/qualification/l2cap-pts.rst b/doc/qualification/l2cap-pts.rst
> index 93adffba81f2..043b8f20cd64 100644
> --- a/doc/qualification/l2cap-pts.rst
> +++ b/doc/qualification/l2cap-pts.rst
> @@ -14,6 +14,8 @@ Setup
>   
>   - In IXIT update "TSPX_psm" to "1011"
>   
> +- echo -n 16 > /sys/kernel/debug/bluetooth/hci0/min_encrypt_key_size
> +
>   Tests
>   =====
>   
> @@ -89,6 +91,103 @@ for which we know the test passed.
>   |                       |        |        |       |                                                      |
>   |                       |        |        |       |   - l2test -d -P 4113                                |
>   +-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CED/BI-05-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - btmon                                            |
> +|                       |        |        |       |                                                      |

Please split running steps by adding a separator here.

> +|                       |        |        |       | - Look for "frame too long"                          |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Answer PTS question with "yes"                     |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CED/BI-09-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - btmon                                            |
> +|                       |        |        |       |                                                      |

Idem

> +|                       |        |        |       | - Look for "invalid signal packet size"              |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Answer PTS question with "yes"                     |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CED/BI-11-C | PASS   |    6.1 | 5.69  |                                                      |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CED/BI-13-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - btmon                                            |
> +|                       |        |        |       |                                                      |

Idem

> +|                       |        |        |       | - Look for "invalid signal packet size"              |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Answer PTS question with "yes"                     |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CED/BI-16-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - btmon                                            |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Look for "invalid signal packet size"              |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Answer PTS question with "yes"                     |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CED/BI-17-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - btmon                                            |
> +|                       |        |        |       |                                                      |

Idem

> +|                       |        |        |       | - Look for "invalid signal packet size"              |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Answer PTS question with "yes"                     |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CED/BI-29-C | PASS   | future | 5.69  | On request run:                                      |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - for I in $(seq 255); \                             |
> +|                       |        |        |       |       do echo "$I/255"; \                            |
> +|                       |        |        |       |       timeout 0.1 l2test -n -V le_public <PTS addr>;\|
> +|                       |        |        |       |   done                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | On 2nd request run:                                  |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - l2test -n -V le_public <PTS addr>                  |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | Note: If using 'timeout' from Busybox, ensure having |
> +|                       |        |        |       |       support for fractional timeout values (requires|
> +|                       |        |        |       |       at leat 1.37.0 + CONFIG_FLOAT_DURATION).       |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CFC/BV-01-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -w -V le_public -P 0x0027 -C 0 -D 2000 \  |
> +|                       |        |        |       |                                    -N 1 -b 200       |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CFC/BV-02-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -w -V le_public -P 0x0027 -C 0 -D 2000 \  |
> +|                       |        |        |       |                                    -N 1 -b 20        |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CFC/BV-03-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -d -V le_public -P 0x0027                 |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CFC/BV-04-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -d -V le_public -P 0x0027                 |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/COS/CFC/BV-05-C | PASS   |    6.1 | 5.69  | On request run (2 times):                            |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -y -V le_public -P 0x0027 -N <PTS addr> & |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
>   | L2CAP/COS/CFD/BV-01-C | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
>   |                       |        |        |       |                                                      |
>   |                       |        |        |       | - Run:                                               |
> @@ -399,6 +498,120 @@ for which we know the test passed.
>   +-----------------------+--------+--------+-------+------------------------------------------------------+
>   | L2CAP/FIX/BV-01-C     | PASS   |    6.1 | 5.69  | On request run: sudo l2test -z -P 4113 <bdaddr>      |
>   +-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BI-01-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-03-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -w -P 0x0027 -V le_public                 |
> +|                       |        |        |       |                         -e $((0x78563412)) -b 10     |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Result: 123456780A007F7F7F7F                       |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-05-C  | PASS   |    6.1 | 5.69  |                                                      |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-06-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -w -V le_public -P 0x0027 -C 0 -D 2000 \  |
> +|                       |        |        |       |                                      -N 1 -b 200     |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-07-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-08-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - On request terminate l2test                        |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-09-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-11-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x00F2 -S              |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-13-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x00F3 -W -1           |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-15-C  | PASS   | future | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x00F4 -E              |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-20-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-23-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-25-C  | PASS   | future | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -P 0x00F5 -V le_public -E              |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-26-C  | PASS   | future | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x0027 -I 100          |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-27-C  | PASS   | future | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x0027 -I 100          |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-28-C  | PASS   | future | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x0027 -I 100          |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-30-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -r -V le_public -P 0x0027                 |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-31-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       | - Run:                                               |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -d -V le_public -P 0x0027                 |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/CFC/BV-32-C  | PASS   |    6.1 | 5.69  | On request run:                                      |
> +|                       |        |        |       |                                                      |
> +|                       |        |        |       |   - l2test -u -V le_public -P 0x0027 <bdaddr>        |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+
>   | L2CAP/LE/CPU/BV-01-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
>   |                       |        |        |       |                                                      |
>   |                       |        |        |       | - Request a LE only dongle for PTS                   |
> @@ -435,3 +648,5 @@ for which we know the test passed.
>   |                       |        |        |       |                                                      |
>   |                       |        |        |       |   - l2test -r -V le_public -J 4                      |
>   +-----------------------+--------+--------+-------+------------------------------------------------------+
> +| L2CAP/LE/REJ/BI-02-C  | PASS   |    6.1 | 5.69  |                                                      |
> ++-----------------------+--------+--------+-------+------------------------------------------------------+

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


