Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D362D060D
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028998; cv=none; b=mmDG6ydMXZod+kEeGSKYHBkqm9CgX4JslQUIhKgdE/NCe0WCU4MXOR4LJZpzC477Ct4zaVPpZX44qsSK3Xyetmpgkb7iUWHyVXAVfT1mZS/qiNua1DtjcEOUf2gWjk8nmuZumGDWiwEB5XIXVsx2+UWtqc3LDeVWTftGN4QiYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028998; c=relaxed/simple;
	bh=ACdzbjKz1rxj2paCcL3dyvKWupDLREFlq9yOSIcwYow=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=cHDVJa4dfcjdMYPXWPfa4K1rv3nD6v9nalKhHA7Ie+mdvOnKmXNTZjShswhuc4fQ8lRIeai3U1M6W5n6myUzOf8OansR93FNXqX4rlOAwm6QSlBFgyCGnb4Rh9nrVmtSIVLiUSATkY9d4g97BfgxfZUKmOJJGovAhZPbS/M2qb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5dc555db.dip0.t-ipconnect.de [93.197.85.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 33E9861E647BA;
	Tue, 12 Aug 2025 22:03:09 +0200 (CEST)
Message-ID: <a5a68086-adad-416a-b276-ab03fa53bea1@molgen.mpg.de>
Date: Tue, 12 Aug 2025 22:03:07 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_conn: Make unacked packet handling
 more robust
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250812195323.1522605-1-luiz.dentz@gmail.com>
 <20250812195323.1522605-3-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250812195323.1522605-3-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch.

Am 12.08.25 um 21:53 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempts to make unacked packet handling more robust by detecting
> if there are no connections left then restore all buffers of the
> respective pool.

Did you find this in code review, or was a bug reported?

> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_conn.c | 34 ++++++++++++++++++++++++++++------
>   1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index e6cea51b3eab..4bd2e4cd477f 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1152,22 +1152,44 @@ void hci_conn_del(struct hci_conn *conn)
>   	disable_delayed_work_sync(&conn->auto_accept_work);
>   	disable_delayed_work_sync(&conn->idle_work);
>   
> -	/* Handle unnacked frames */
> +	/* Handle unnacked frames:
> +	 *
> +	 * - In case there are no connection restore all buffers to the pool
> +	 * - Otherwise restore just the buffers considered in transit for the
> +	 *   hci_conn
> +	 */
>   	switch (conn->type) {
>   	case ACL_LINK:
> -		hdev->acl_cnt += conn->sent;
> +		if (!hci_conn_num(hdev, ACL_LINK))
> +			hdev->acl_cnt = hdev->acl_pkts;
> +		else
> +			hdev->acl_cnt += conn->sent;
>   		break;
>   	case LE_LINK:
>   		cancel_delayed_work(&conn->le_conn_timeout);
>   
> -		if (hdev->le_pkts)
> -			hdev->le_cnt += conn->sent;
> -		else
> -			hdev->acl_cnt += conn->sent;
> +		if (hdev->le_pkts) {
> +			if (!hci_conn_num(hdev, LE_LINK))
> +				hdev->le_cnt = hdev->le_pkts;
> +			else
> +				hdev->le_cnt += conn->sent;
> +		} else {
> +			if (!hci_conn_num(hdev, LE_LINK) &&
> +			    !hci_conn_num(hdev, ACL_LINK))
> +				hdev->acl_cnt = hdev->acl_pkts;
> +			else
> +				hdev->acl_cnt += conn->sent;
> +		}
>   		break;
>   	case CIS_LINK:
>   	case BIS_LINK:
>   	case PA_LINK:
> +		if (!hci_conn_num(hdev, CIS_LINK) &&
> +		    !hci_conn_num(hdev, BIS_LINK) &&
> +		    !hci_conn_num(hdev, PA_LINK))
> +			hdev->iso_cnt = hdev->iso_pkts;
> +		else
> +			hdev->iso_cnt += conn->sent;
>   		hdev->iso_cnt += conn->sent;
>   		break;
>   	}


Kind regards,

Paul
