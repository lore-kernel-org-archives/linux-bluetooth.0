Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39192D7392;
	Thu, 20 Nov 2025 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622821; cv=none; b=CPfxckT4PnR7KLdeJ5697GwRPfZ0vzqnsxj7ruKMUXnhpZsEFaryqjhnsK0AgaqkXdrur6mPt7CJLh4VxblVuWy7+SwojcSGG/pu7RiPYdaQlZnhFfrxv4F+L7kbtVI3KPkBwXpFVmDQuaGb0opBZubA0CEMlWI9JOewHnGkj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622821; c=relaxed/simple;
	bh=P9NZdN5Tbm6gCaksEBzX9yegGy+RHXR5dh1Ogobwh30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNOWuCHs9Udbqr+rBRyuAPkQ4yfCVayNu3loY76J4XfbRxtzSCgWRxhm2TOMt/s4Yv4A7w8htH+KHvPiSDHYIlPJ/O3d5tNsiZrUKsfmclToZxUgVWcX4sHEY2hfoMog3R3ZqtkbOayRE1qaCfHPutoFlUx4HZpvDQSeKHEcDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AflYV4WC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AflYV4WC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763622820; x=1795158820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P9NZdN5Tbm6gCaksEBzX9yegGy+RHXR5dh1Ogobwh30=;
  b=AflYV4WCT2yO9Xua0J3O29t9hgQWijram5DA9d2Eqc2Kd3ALIagzl4Gr
   SWJDNwHARYEustZ2ygWF2fVR9TbRzzq9RSvgGiVJnIYyq2hxAA0vxH2ou
   mquH7iozrLvVnxaN3bcT+jhq1DdOSDIwTcgu3lgUIYUP3+qkZJKcmZAr9
   TpIIiwhWqDxY1WbBI6UH1sG1YKgVTP6Ewp/yazJfLR/oAcM51OZP/7qXo
   bipgV1+kPt99zJyqppQykJrUVRJ1elTp1Ha46cggm58vWFcEM7fnlU0i0
   49pSX8OgCMN2U7iEuG+lOXbD1Hfv1x3BdQPaO0vdH7jg6r6aJSfP1Dg5a
   Q==;
X-CSE-ConnectionGUID: IFVAuKoLRgG1pV/jhZruUg==
X-CSE-MsgGUID: en6Ve6MlT1CshSASHxj/xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="83302290"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="83302290"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:13:39 -0800
X-CSE-ConnectionGUID: EalThrNuQyq0gokVJypuyg==
X-CSE-MsgGUID: x4taoPANTQuDtTH1uPBszw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="196404736"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Nov 2025 23:13:36 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLyrG-0003iV-0n;
	Thu, 20 Nov 2025 07:13:34 +0000
Date: Thu, 20 Nov 2025 15:12:36 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com, dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: Re: [PATCH v1 01/11] Bluetooth: btnxpuart: Add firmware metadata
 parsing for secure interface
Message-ID: <202511201312.njyFmd0I-lkp@intel.com>
References: <20251118142025.1982263-2-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118142025.1982263-2-neeraj.sanjaykale@nxp.com>

Hi Neeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neeraj-Sanjay-Kale/Bluetooth-btnxpuart-Add-firmware-metadata-parsing-for-secure-interface/20251118-223605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20251118142025.1982263-2-neeraj.sanjaykale%40nxp.com
patch subject: [PATCH v1 01/11] Bluetooth: btnxpuart: Add firmware metadata parsing for secure interface
config: i386-randconfig-061-20251120 (https://download.01.org/0day-ci/archive/20251120/202511201312.njyFmd0I-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511201312.njyFmd0I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511201312.njyFmd0I-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/bluetooth/btnxpuart.c:1284:55: sparse: sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:1292:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:1297:47: sparse: sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:1298:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:1301:26: sparse: sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:1380:17: sparse: sparse: restricted __le32 degrades to integer

vim +1284 drivers/bluetooth/btnxpuart.c

  1261	
  1262	static void nxp_process_fw_meta_data(struct hci_dev *hdev, const struct firmware *fw)
  1263	{
  1264		const char *metamagc = "metamagc";
  1265		struct fw_metadata_hdr *hdr = NULL;
  1266		struct fw_metadata_tail *tail;
  1267		u32 hdr_crc = 0;
  1268		u32 payload_crc = 0;
  1269		char *payload;
  1270		u32 payload_len = 0;
  1271	
  1272		/* FW metadata should contain at least header and tail */
  1273		if (fw->size < (sizeof(*hdr) + sizeof(*tail)))
  1274			return;
  1275	
  1276		tail = (struct fw_metadata_tail *)&fw->data[fw->size - sizeof(*tail)];
  1277	
  1278		/* If tail doesn't contain the string "metamagc", this is invalid FW metadata */
  1279		if (memcmp(metamagc, tail->magic, strlen(metamagc)))
  1280			return;
  1281	
  1282		hdr = (struct fw_metadata_hdr *)&fw->data[fw->size -
  1283							  sizeof(*tail) -
> 1284							  tail->len];
  1285	
  1286		/* If metadata header isn't cmd24, this is invalid FW metadata */
  1287		if (le32_to_cpu(hdr->cmd) != 24)
  1288			return;
  1289	
  1290		/* If header CRC doesn't match, this is invalid FW metadata */
  1291		hdr_crc = crc32_be(0, (u8 *)hdr, offsetof(struct fw_metadata_hdr, crc));
  1292		if (hdr_crc != hdr->crc)
  1293			return;
  1294	
  1295		/* If payload CRC doesn't match, this is invalid FW metadata */
  1296		payload = (u8 *)hdr  + sizeof(*hdr);
  1297		payload_crc = crc32_be(0, payload, hdr->len - 4);
  1298		if (payload_crc != tail->crc)
  1299			return;
  1300	
  1301		payload_len = hdr->len - sizeof(*tail);
  1302	
  1303		while (payload_len > sizeof(struct fw_metadata_tlv))
  1304			payload_len -= nxp_process_fw_metadata_tlv(hdev, &payload);
  1305	}
  1306	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
