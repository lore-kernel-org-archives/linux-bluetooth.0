Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDD35962
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 Aug 2025 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756663392; cv=none; b=lXz0gvRzeKH4BLmxnQMjOirQYDlsixNdYnYmjxQb0EEinNc6DEjrKdSq6w4aZN7SYCIthq3UhXvB5FaWz/zV/Js755/SVnmU2TMLa8hfn+OUmH3uEMjzdssh9nl02ogknFE/OjOerG8hL7APrEV9U+TnskmP/A+Kjp2HMZGsbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756663392; c=relaxed/simple;
	bh=MMpsCduON6ZPALNrAI3SM66tEcqbq8jkZuym4R/0pVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Evcpe0aR+L+a2jcYh5gT6jMhqaAPW7acpxAIffsOA3TGUm8pyFi98ZFMT4eGVatpN4WiuoHT2wHfFoPjPlMFaTYKuWjIqJyksK1Cj3WxzN4XboSN4WvADpDMR5MF6KN2d+31xTUO9WJENqVnWm7fm96XsKGaVjdHKCLAsn/rXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=TjI6do9z; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="TjI6do9z"
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id sXMRubRcIeNqismOOu0IKl; Sun, 31 Aug 2025 18:03:04 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id smOMuTPRAE5uDsmONuwYaE; Sun, 31 Aug 2025 18:03:03 +0000
X-Authority-Analysis: v=2.4 cv=dtDbC0g4 c=1 sm=1 tr=0 ts=68b48e57
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=XW3vq5T86JFyMsJaYQInbg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10 a=mDV3o1hIAAAA:8
 a=VwQbUJbxAAAA:8 a=NHFDJVvD0WxijCQSf8sA:9 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oFjRakt6o7eOFpI4iqa2E9eFYXiPZnXO9go7BJhXWtM=; b=TjI6do9z2sTKpP4gjBuv7P+62G
	rN9FIg2U7/y8Whpug7eQidT9xF7DIITgekRo+MuMlEV9E1kpJK8Xa/aOGMg8OO9QsjJlRf0xtFqAv
	mvmHxlFnqU5aUBLB1EAqxSeHP3jqwxHPVgvytGgj0jDMaz2rwL69cqf6GZ0VWzCZvGLA6nGHqqhyg
	wm3qQFokihN1p/IKZD1NrEfIESE6p+I9vh6Q6Eqhqpdnowl+AfxeBIkX2c3lp4tUnGQprAxp/5Yg8
	GJHqQOv1rmDopXRS8ONm5GIJpqFVbDpJtxgKo9+r8XXp5jdcJBg47dO57mFlutZiNwoaop+UmO4xE
	u4ItjWkQ==;
Received: from d4b26982.static.ziggozakelijk.nl ([212.178.105.130]:41742 helo=[10.233.40.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1usmOL-00000003wne-2NqT;
	Sun, 31 Aug 2025 13:03:02 -0500
Message-ID: <f0c79ce0-aa59-465b-ae10-f48e74038f69@embeddedor.com>
Date: Sun, 31 Aug 2025 20:02:32 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] Bluetooth: Avoid a couple dozen
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aLSCu8U62Hve7Dau@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aLSCu8U62Hve7Dau@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 212.178.105.130
X-Source-L: No
X-Exim-ID: 1usmOL-00000003wne-2NqT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: d4b26982.static.ziggozakelijk.nl ([10.233.40.44]) [212.178.105.130]:41742
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEEnPFftNnOmLEc7SleJjyReBgxjoK5zJ+I5QWq7CIxv1odCmaSyj+mPgXB+NpapgOokNQk5i2lUnpIx+W2adbvvq6osJbQAoIB2DURk0wJ9IL2q/ix3
 Yh5bLu14ocWFAD0P53O0zh5le2hxWmN+GAQeIjUiQN6AgJTfMLYFkLAmmnZCvvTraSwgpVT3l3fHAH+HTZ9eyTFfm9adkj2Wk+U7BUGFWvoymU5ojGfAthha

Hi all,

Please, drop this. I just remembered about this bugfix for GCC:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=120354

which will actually catch the same -Wfamnae issues inside
struct mgmt_rp_read_def_system_config:

struct mgmt_rp_read_def_system_config {
	union {
		struct mgmt_tlv    entry;                /*     0     3 */
		struct {
			unsigned char __offset_to_value[3]; /*     0     3 */

			/* XXX 1 byte hole, try to pack */

			__le16     value;                /*     4     2 */
		};                                       /*     0     6 */
	} def_page_scan_type;                            /*     0     6 */
	union {
		struct mgmt_tlv    entry;                /*     6     3 */
		struct {
			unsigned char __offset_to_value[3]; /*     6     3 */

			/* XXX 1 byte hole, try to pack */

			__le16     value;                /*    10     2 */
		};                                       /*     6     6 */
	} def_page_scan_int;                             /*     6     6 */
	union {
		struct mgmt_tlv    entry;                /*    12     3 */
		struct {
			unsigned char __offset_to_value[3]; /*    12     3 */

			/* XXX 1 byte hole, try to pack */

			__le16     value;                /*    16     2 */
		};                                       /*    12     6 */
	} def_page_scan_window;                          /*    12     6 */
...
}...

So, I need to figure out another solution for this.

Thanks
-Gustavo

On 8/31/25 19:13, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix 31 instances of the
> following type of warnings:
> 
> 30 net/bluetooth/mgmt_config.c:16:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 1 net/bluetooth/mgmt_config.c:22:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it. This overlays
> the trailing members onto the FAM while preserving the original
> memory layout.
> 
> Also, as the structs turn into unions, both members `entry` and
> `value` cannot be statically initialized at once. Create another
> macro to initialize everything after the declaration of `rp`.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   net/bluetooth/mgmt_config.c | 97 +++++++++++++++++++------------------
>   1 file changed, 51 insertions(+), 46 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
> index 6ef701c27da4..829c9cfcea7d 100644
> --- a/net/bluetooth/mgmt_config.c
> +++ b/net/bluetooth/mgmt_config.c
> @@ -12,35 +12,71 @@
>   #include "mgmt_config.h"
>   
>   #define HDEV_PARAM_U16(_param_name_) \
> -	struct {\
> -		struct mgmt_tlv entry; \
> +	TRAILING_OVERLAP(struct mgmt_tlv, entry, value, \
>   		__le16 value; \
> -	} __packed _param_name_
> +	) __packed _param_name_
>   
>   #define HDEV_PARAM_U8(_param_name_) \
> -	struct {\
> -		struct mgmt_tlv entry; \
> +	TRAILING_OVERLAP(struct mgmt_tlv, entry, value, \
>   		__u8 value; \
> -	} __packed _param_name_
> +	) __packed _param_name_
>   
>   #define TLV_SET_U16(_param_code_, _param_name_) \
>   	{ \
> -		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
> -		cpu_to_le16(hdev->_param_name_) \
> +		rp._param_name_.entry.type = cpu_to_le16(_param_code_); \
> +		rp._param_name_.entry.length = sizeof(__u16); \
> +		rp._param_name_.value = cpu_to_le16(hdev->_param_name_); \
>   	}
>   
>   #define TLV_SET_U8(_param_code_, _param_name_) \
>   	{ \
> -		{ cpu_to_le16(_param_code_), sizeof(__u8) }, \
> -		hdev->_param_name_ \
> +		rp._param_name_.entry.type = cpu_to_le16(_param_code_); \
> +		rp._param_name_.entry.length = sizeof(__u8); \
> +		rp._param_name_.value = hdev->_param_name_; \
>   	}
>   
>   #define TLV_SET_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
>   	{ \
> -		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
> -		cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)) \
> +		rp._param_name_.entry.type = cpu_to_le16(_param_code_); \
> +		rp._param_name_.entry.length = sizeof(__u16); \
> +		rp._param_name_.value = cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)); \
>   	}
>   
> +#define TLV_SET_ALL() \
> +{ \
> +	TLV_SET_U16(0x0000, def_page_scan_type); \
> +	TLV_SET_U16(0x0001, def_page_scan_int); \
> +	TLV_SET_U16(0x0002, def_page_scan_window); \
> +	TLV_SET_U16(0x0003, def_inq_scan_type);  \
> +	TLV_SET_U16(0x0004, def_inq_scan_int); \
> +	TLV_SET_U16(0x0005, def_inq_scan_window); \
> +	TLV_SET_U16(0x0006, def_br_lsto); \
> +	TLV_SET_U16(0x0007, def_page_timeout); \
> +	TLV_SET_U16(0x0008, sniff_min_interval); \
> +	TLV_SET_U16(0x0009, sniff_max_interval); \
> +	TLV_SET_U16(0x000a, le_adv_min_interval); \
> +	TLV_SET_U16(0x000b, le_adv_max_interval); \
> +	TLV_SET_U16(0x000c, def_multi_adv_rotation_duration); \
> +	TLV_SET_U16(0x000d, le_scan_interval); \
> +	TLV_SET_U16(0x000e, le_scan_window); \
> +	TLV_SET_U16(0x000f, le_scan_int_suspend); \
> +	TLV_SET_U16(0x0010, le_scan_window_suspend); \
> +	TLV_SET_U16(0x0011, le_scan_int_discovery); \
> +	TLV_SET_U16(0x0012, le_scan_window_discovery); \
> +	TLV_SET_U16(0x0013, le_scan_int_adv_monitor); \
> +	TLV_SET_U16(0x0014, le_scan_window_adv_monitor); \
> +	TLV_SET_U16(0x0015, le_scan_int_connect); \
> +	TLV_SET_U16(0x0016, le_scan_window_connect); \
> +	TLV_SET_U16(0x0017, le_conn_min_interval); \
> +	TLV_SET_U16(0x0018, le_conn_max_interval); \
> +	TLV_SET_U16(0x0019, le_conn_latency); \
> +	TLV_SET_U16(0x001a, le_supv_timeout); \
> +	TLV_SET_U16_JIFFIES_TO_MSECS(0x001b, def_le_autoconnect_timeout); \
> +	TLV_SET_U16(0x001d, advmon_allowlist_duration); \
> +	TLV_SET_U16(0x001e, advmon_no_filter_duration); \
> +	TLV_SET_U8(0x001f, enable_advmon_interleave_scan); \
> +}
> +
>   int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
>   			   u16 data_len)
>   {
> @@ -78,40 +114,9 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
>   		HDEV_PARAM_U16(advmon_allowlist_duration);
>   		HDEV_PARAM_U16(advmon_no_filter_duration);
>   		HDEV_PARAM_U8(enable_advmon_interleave_scan);
> -	} __packed rp = {
> -		TLV_SET_U16(0x0000, def_page_scan_type),
> -		TLV_SET_U16(0x0001, def_page_scan_int),
> -		TLV_SET_U16(0x0002, def_page_scan_window),
> -		TLV_SET_U16(0x0003, def_inq_scan_type),
> -		TLV_SET_U16(0x0004, def_inq_scan_int),
> -		TLV_SET_U16(0x0005, def_inq_scan_window),
> -		TLV_SET_U16(0x0006, def_br_lsto),
> -		TLV_SET_U16(0x0007, def_page_timeout),
> -		TLV_SET_U16(0x0008, sniff_min_interval),
> -		TLV_SET_U16(0x0009, sniff_max_interval),
> -		TLV_SET_U16(0x000a, le_adv_min_interval),
> -		TLV_SET_U16(0x000b, le_adv_max_interval),
> -		TLV_SET_U16(0x000c, def_multi_adv_rotation_duration),
> -		TLV_SET_U16(0x000d, le_scan_interval),
> -		TLV_SET_U16(0x000e, le_scan_window),
> -		TLV_SET_U16(0x000f, le_scan_int_suspend),
> -		TLV_SET_U16(0x0010, le_scan_window_suspend),
> -		TLV_SET_U16(0x0011, le_scan_int_discovery),
> -		TLV_SET_U16(0x0012, le_scan_window_discovery),
> -		TLV_SET_U16(0x0013, le_scan_int_adv_monitor),
> -		TLV_SET_U16(0x0014, le_scan_window_adv_monitor),
> -		TLV_SET_U16(0x0015, le_scan_int_connect),
> -		TLV_SET_U16(0x0016, le_scan_window_connect),
> -		TLV_SET_U16(0x0017, le_conn_min_interval),
> -		TLV_SET_U16(0x0018, le_conn_max_interval),
> -		TLV_SET_U16(0x0019, le_conn_latency),
> -		TLV_SET_U16(0x001a, le_supv_timeout),
> -		TLV_SET_U16_JIFFIES_TO_MSECS(0x001b,
> -					     def_le_autoconnect_timeout),
> -		TLV_SET_U16(0x001d, advmon_allowlist_duration),
> -		TLV_SET_U16(0x001e, advmon_no_filter_duration),
> -		TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
> -	};
> +	} __packed rp;
> +
> +	TLV_SET_ALL();
>   
>   	bt_dev_dbg(hdev, "sock %p", sk);
>   

