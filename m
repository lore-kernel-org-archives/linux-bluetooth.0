Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EC63783C3
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591937; cv=none; b=C+oklECv97edc/pA6C7yD10kOuymYhkVGJSOf92Ut0Uet/h8CDNZ/K1IB5L7D8LLqd0XFvvO2sZSbVK4QWupOawu9/ccTNXkD1CrBUpoy4wBRXXlibO4JFySA90fVl5v9Y8IIXlmKXMpH3nmodJ9hFk1y/vMoIeuSzqDHPHH9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591937; c=relaxed/simple;
	bh=Z6velnEz/B2uUTLmaqxbse9s2ja6/VD05qH9aqa+eGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=By/RhnTAcrtsaSt8RdSANrlb3WVALEvRW1JhV1FYBqdjnM1xTr0oWat94+Cxl6ACRJVxuUTwPtJho8HfGpePleGZfcfgnFhCjT/G4Bv30xh3bYa1bfi1MCiSFjmEdsLbti6ud6K1XyzyjJEmtcBGepdvRMV35J/+mLAsV6PnGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ovYykCZu; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ovYykCZu"
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id A9newSnt6nwj2ACZcwPgjp; Tue, 07 Apr 2026 19:58:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id ACZLwyA1UFeDMACZMwCJvQ; Tue, 07 Apr 2026 19:58:40 +0000
X-Authority-Analysis: v=2.4 cv=aq2yCTZV c=1 sm=1 tr=0 ts=69d561ff
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=chC0KcwHAXg1M6QkddG+Hg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=e9iTn1YT0ADnaAsSjdMA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ftx1xvaens4tD60bx30l+0J5ZoIN5FuIm41gSlSbF7M=; b=ovYykCZudC5eWXWUoETHRq3Jh+
	9h56ItZnoxviFExq4NOVyR276Jy4LzgQ8yDpWw0QMvZKS2k31LYVaP0SwudkrsM0olfV7q3y8VXv3
	AT2zbKvPvCU34hE9GVynQ6Nzo1bUYnlGPC9cz+ZS9ULbR61xxg/kU2va4eok8lprH+ctJ8vEIOE+j
	bmz37MuAqP0j3WBFPlPHXTIVA4aio1+SgPfVFfAGfN8CSB3sbul6eK3kJggYOS9DeCIbaNUbErmMj
	rCsn8lMZBwWyCrfZl8lVrrpgyjhtyByKRvYCk7s01EABm74swPB6QWZBwFkdHSwYh54xgZLxOGAZ6
	bQWz3S3w==;
Received: from [177.238.18.219] (port=37324 helo=[192.168.0.36])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wACZL-00000003Nk6-0Fqb;
	Tue, 07 Apr 2026 14:58:39 -0500
Message-ID: <d04e11af-5c1b-44a2-aebc-a0ee4fb79802@embeddedor.com>
Date: Tue, 7 Apr 2026 13:57:00 -0600
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] Bluetooth: hci.h: Avoid a couple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aZ1FrL8qvvKuktBF@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aZ1FrL8qvvKuktBF@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.219
X-Source-L: No
X-Exim-ID: 1wACZL-00000003Nk6-0Fqb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.36]) [177.238.18.219]:37324
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEiQ+VMoMFs81IxEN7PZgmHBrUsaUdN3y8MZTaUcipDOH0YiM0nFiOLjgB21W67XXXEKtT2/dTmLQzY1+k1lkmqs8tOXBe43Tv+H4f950Tdt+VmRw/Vo
 ADhnJOVIdH85VfGY6CZiA0FoRHvouqCRbcKn/pL6t622nCIjsTnX0McF9ahv7DDFlSBRMQSfo4tEdfOtYSYcOba2MFWoUibxUJYBCXBnqnG5ln3XSWL/ITqW

Hi all,

Friendly ping: who can take this, please?

Thanks
-Gustavo

On 2/24/26 00:31, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> struct hci_std_codecs and struct hci_std_codecs_v2 are flexible
> structures, this is structures that contain a flexible-array member
> (__u8 codec[]; and struct hci_std_codec_v2 codec[];, correspondingly.)
> 
> Since struct hci_rp_read_local_supported_codecs and struct
> hci_rp_read_local_supported_codecs_v2 are defined by hardware, we
> create the new struct hci_std_codecs_hdr and struct hci_std_codecs_v2_hdr
> types, and use them to replace the object types causing trouble in
> struct hci_rp_read_local_supported_codecs and struct
> hci_rp_read_local_supported_codecs_v2, namely struct hci_std_codecs
> std_codecs; and struct hci_std_codecs_v2_hdr std_codecs;.
> 
> Also, once -fms-extensions is enabled, we can use transparent struct
> members in both struct hci_std_codecs and struct hci_std_codecs_v2_hdr.
> 
> Notice that the newly created types does not contain the flex-array
> member `codec`, which is the object causing the -Wfamnae warnings.
> 
> After these changes, the size of struct hci_rp_read_local_supported_codecs
> and struct hci_rp_read_local_supported_codecs_v2, along with their
> member's offsets remain the same, hence the memory layouts don't
> change:
> 
> Before changes:
> struct hci_rp_read_local_supported_codecs {
>          __u8                       status;               /*     0     1 */
>          struct hci_std_codecs      std_codecs;           /*     1     1 */
>          struct hci_vnd_codecs      vnd_codecs;           /*     2     1 */
> 
>          /* size: 3, cachelines: 1, members: 3 */
>          /* last cacheline: 3 bytes */
> } __attribute__((__packed__));
> 
> struct hci_rp_read_local_supported_codecs_v2 {
>          __u8                       status;               /*     0     1 */
>          struct hci_std_codecs_v2   std_codecs;           /*     1     1 */
>          struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     1 */
> 
>          /* size: 3, cachelines: 1, members: 3 */
>          /* last cacheline: 3 bytes */
> } __attribute__((__packed__));
> 
> After changes:
> struct hci_rp_read_local_supported_codecs {
> 	__u8                       status;               /*     0     1 */
> 	struct hci_std_codecs_hdr  std_codecs;           /*     1     1 */
> 	struct hci_vnd_codecs      vnd_codecs;           /*     2     1 */
> 
> 	/* size: 3, cachelines: 1, members: 3 */
> 	/* last cacheline: 3 bytes */
> } __attribute__((__packed__));
> 
> struct hci_rp_read_local_supported_codecs_v2 {
> 	__u8                       status;               /*     0     1 */
> 	struct hci_std_codecs_v2_hdr std_codecs;         /*     1     1 */
> 	struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     1 */
> 
> 	/* size: 3, cachelines: 1, members: 3 */
> 	/* last cacheline: 3 bytes */
> } __attribute__((__packed__));
> 
> With these changes fix the following warnings:
> 
> include/net/bluetooth/hci.h:1490:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/net/bluetooth/hci.h:1525:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   include/net/bluetooth/hci.h | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 89ad9470fa71..572b1c620c5d 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1468,8 +1468,12 @@ struct hci_rp_read_data_block_size {
>   } __packed;
>   
>   #define HCI_OP_READ_LOCAL_CODECS	0x100b
> -struct hci_std_codecs {
> +struct hci_std_codecs_hdr {
>   	__u8	num;
> +} __packed;
> +
> +struct hci_std_codecs {
> +	struct hci_std_codecs_hdr;
>   	__u8	codec[];
>   } __packed;
>   
> @@ -1487,7 +1491,7 @@ struct hci_vnd_codecs {
>   
>   struct hci_rp_read_local_supported_codecs {
>   	__u8	status;
> -	struct hci_std_codecs std_codecs;
> +	struct hci_std_codecs_hdr std_codecs;
>   	struct hci_vnd_codecs vnd_codecs;
>   } __packed;
>   
> @@ -1504,8 +1508,12 @@ struct hci_std_codec_v2 {
>   	__u8	transport;
>   } __packed;
>   
> -struct hci_std_codecs_v2 {
> +struct hci_std_codecs_v2_hdr {
>   	__u8	num;
> +} __packed;
> +
> +struct hci_std_codecs_v2 {
> +	struct hci_std_codecs_v2_hdr;
>   	struct hci_std_codec_v2 codec[];
>   } __packed;
>   
> @@ -1522,7 +1530,7 @@ struct hci_vnd_codecs_v2 {
>   
>   struct hci_rp_read_local_supported_codecs_v2 {
>   	__u8	status;
> -	struct hci_std_codecs_v2 std_codecs;
> +	struct hci_std_codecs_v2_hdr std_codecs;
>   	struct hci_vnd_codecs_v2 vendor_codecs;
>   } __packed;
>   

