Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8915667D
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736771885; cv=none; b=b7Njwd42wWnQ34EUcm4Hs3UmqzXbCA3CS93ecvGRcD8gqALY0k/xpmtFjYafjomuG40r+7B/Ffa5Qu2WmzKZ0N+17Y2b038U8DujkP6l37c7bDXVIfnWTl+XW/bgMohEoZ17ePsfUvK56Lu0WnKRl7e3USz8mNtmZi3v4oZOKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736771885; c=relaxed/simple;
	bh=Cq99J4gcgYO0rKOCpC0Yoo5nKPwdwSdo3juaUq3rrKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqZByCkIruNRhm90hpNlLVOYWJnJ6bluvC9rxqmw0rp8Iz4T06UEzXJ3H6QPjcEdDMCI07EwZB/jz2dox1CPTf//yzDNTU8MuoIRwJyvm6heXEkBO+n6AziMjdVb1/tu8ua9ALoiRcpKoWRfWp1+kgFHyAps+FHDOaFMe89IFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tmRJruHo; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tmRJruHo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1736771883;
	bh=f1Qt6NsMApyLTlUymw127A7H5gbCRRqBATfe8t+ZXHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=tmRJruHozyU/hE2U8lJX0lGGaIvJ3oPoQOcjBljGi4fLg1IylvAjxeZrZ7bGKBv4B
	 r6d6MkPnYLG4wQzS9H0b8Mo6GTTya1rbbnW3sAONFb+oQq0dZ33yZjxiYCaxZbftBe
	 T+oy1pVpg1fC3zA9Azo+Npy8v7FHDQNYqRLyJi5RGIJVTvKT961j8p9hVN7mV4kYpn
	 jnTZViKiKa4cqOgb1rbYnzDHC9/nRKS1Rn153re0FzXarVw9dE8RNtIeepCAWBldWP
	 nFZ9TTIDxRb93jBeC5BsgziVn/LzqZaKkiM+sB5T5sZl4cn6BpUnIL0wf2aCHTN96a
	 NtjGMMZPyBQ8Q==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id F33C6A0144;
	Mon, 13 Jan 2025 12:37:57 +0000 (UTC)
Message-ID: <5a5df3a9-e9ff-48f4-804a-1d5d035f599f@icloud.com>
Date: Mon, 13 Jan 2025 20:37:53 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Support downloading board ID specific
 NVM for WCN6855
To: Johan Hovold <johan@kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Bjorn Andersson <andersson@kernel.org>, Steev Klimaszewski <steev@kali.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Bjorn Andersson <bjorande@quicinc.com>,
 "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
 Cheng Jiang <quic_chejiang@quicinc.com>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, stable@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>
 <Z1v8vLWH7TmwwzQl@hovoldconsulting.com>
 <Z4TbyIfVJL85oVXs@hovoldconsulting.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z4TbyIfVJL85oVXs@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9UfWYEaUXTbayRm_9U-9oMYSHcaRE_zi
X-Proofpoint-GUID: 9UfWYEaUXTbayRm_9U-9oMYSHcaRE_zi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_04,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2501130106

On 2025/1/13 17:24, Johan Hovold wrote:
> Hi Luiz,
> 
> On Fri, Dec 13, 2024 at 10:22:05AM +0100, Johan Hovold wrote:
>> On Sat, Nov 16, 2024 at 07:49:23AM -0800, Zijun Hu wrote:
>>> For WCN6855, board ID specific NVM needs to be downloaded once board ID
>>> is available, but the default NVM is always downloaded currently, and
>>> the wrong NVM causes poor RF performance which effects user experience.
>>>
>>> Fix by downloading board ID specific NVM if board ID is available.
> 
>>> Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
>>> Cc: stable@vger.kernel.org # 6.4
>>> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>>> Tested-by: Johan Hovold <johan+linaro@kernel.org>
>>> Tested-by: Steev Klimaszewski <steev@kali.org>
>>> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>>> I will help to backport it to LTS kernels ASAP once this commit
>>> is mainlined.
>>> ---
>>> Changes in v2:
>>> - Correct subject and commit message
>>> - Temporarily add nvm fallback logic to speed up backport.
>>> — Add fix/stable tags as suggested by Luiz and Johan
>>> - Link to v1: https://lore.kernel.org/r/20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com
>>
>> The board-specific NVM configuration files have now been included in the
>> linux-firmware-20241210 release and are making their way into the
>> distros (e.g. Arch Linux ARM and Fedora now ship them).
>>
>> Could we get this merged for 6.13-rc (and backported) so that Lenovo
>> ThinkPad X13s users can finally enjoy excellent Bluetooth range? :)
> 
> This fix is still pending in your queue (I hope) and I was hoping you
> would be able to get it into 6.13-rc. The reason, apart from this being
> a crucial fix for users of this chipset, was also to avoid any conflicts
> with the new "rampatch" firmware name feature (which will also
> complicate backporting somewhat).
> 
> Those patches were resent on January 7 and have now been merged for 6.14
> (presumably):
> 
> 	https://lore.kernel.org/all/20250107092650.498154-1-quic_chejiang@quicinc.com/
> 
> How do we handle this? Can you still get this fix into 6.13 or is it
> now, as I assume, too late for that?
> 
> Zijun, depending on Luiz' reply, can you look into rebasing on top of the
> patches now queued for linux-next?
> 

sure. let me do it with high priority.

> Johan

