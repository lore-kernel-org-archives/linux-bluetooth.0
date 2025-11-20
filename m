Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61E248891;
	Thu, 20 Nov 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650047; cv=none; b=PPyeMurXF4YArki1fFUeOx1aXM+fnShqBNy1qlVn2w1emrl14tgKzutnvmx+wz9uL7if+EwD1uGXTIi/yXw3mCism5yfAhw16zrroI10zfjwOt1gFlW3S4Uw9YS43si4sJ9qNO7BMYvdPBnTd3eNZ2UCqeMQDB/kiq9l6r/AIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650047; c=relaxed/simple;
	bh=CL0AfZyGaf6o7tt8Zv6vmaXCHm+tuYBXPxYBDQdYbAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqJqhxKUfHvYp2M+JoLQwllNYBrFfOwLyqKenCxlIbcvZsWL4ZlUNMqDwnxWzC2crDumP2gdeibHFK7nNdn0gtTV+QkXrC0aCoaRIrdtg/MpXlzix3KBsOeO+uhFXkPDcdlz9xiOJXOcw6EqGjFHemJnba1CM4GpaMl0NdNLPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkSpRnrp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkSpRnrp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763650045; x=1795186045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CL0AfZyGaf6o7tt8Zv6vmaXCHm+tuYBXPxYBDQdYbAg=;
  b=TkSpRnrpsvOKJVubuqADVOMXO9qWNwx4QaJD3GaorH+3n29wQc9xz41y
   2WYMl/n2K8DtNUO2foeFoLeuEWwArBPKCiJSNk+ryCq7AoWw/1W6NWhWH
   27zFMb3v1L/BuYumeHkDsITuqgqzpC7/UtE6aZOm7PceNqPqOdV6TZSCB
   6WBgenPLxjeYCapg/ktmTppp7hKlgHJb9r71hieXcwFeoMG658PWaTSe5
   qefe6tUcXsehfUu0vTxpCeE+nBpt12htqAeFgGSPpyR8FF3E9m0eEYME0
   1TgXjpE0GMXdNfOxBHeJ1TZ/K2fF5h8yuakaMEWqtIB/TlBM6r/4Qq5tP
   g==;
X-CSE-ConnectionGUID: a/gQ8aE0TLu0szKEPh0e9A==
X-CSE-MsgGUID: M1e+gXrUQoq3xr1OiCKW4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65652168"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65652168"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 06:47:25 -0800
X-CSE-ConnectionGUID: WNeM5766TQ+VjRSmYA4AFg==
X-CSE-MsgGUID: O5pTTRiETqSDJL02LqydeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="190668943"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Nov 2025 06:47:23 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vM5wO-00048x-18;
	Thu, 20 Nov 2025 14:47:20 +0000
Date: Thu, 20 Nov 2025 22:46:25 +0800
From: kernel test robot <lkp@intel.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com, dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: Re: [PATCH v1 07/11] Bluetooth: btnxpuart: Add device authentication
Message-ID: <202511202234.PN8Zn4v7-lkp@intel.com>
References: <20251118142025.1982263-8-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118142025.1982263-8-neeraj.sanjaykale@nxp.com>

Hi Neeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Neeraj-Sanjay-Kale/Bluetooth-btnxpuart-Add-firmware-metadata-parsing-for-secure-interface/20251118-223605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20251118142025.1982263-8-neeraj.sanjaykale%40nxp.com
patch subject: [PATCH v1 07/11] Bluetooth: btnxpuart: Add device authentication
config: i386-randconfig-061-20251120 (https://download.01.org/0day-ci/archive/20251120/202511202234.PN8Zn4v7-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511202234.PN8Zn4v7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511202234.PN8Zn4v7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/bluetooth/btnxpuart.c:1433:55: sparse: sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:1441:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:1446:47: sparse: sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:1447:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:1450:26: sparse: sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:1529:17: sparse: sparse: restricted __le32 degrades to integer
>> drivers/bluetooth/btnxpuart.c:1758:64: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] chipid @@     got restricted __le16 const [usertype] chip_id @@
   drivers/bluetooth/btnxpuart.c:1758:64: sparse:     expected unsigned short [usertype] chipid
   drivers/bluetooth/btnxpuart.c:1758:64: sparse:     got restricted __le16 const [usertype] chip_id
>> drivers/bluetooth/btnxpuart.c:1759:58: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned char [usertype] loader_ver @@     got restricted __le16 const [usertype] device_flags @@
   drivers/bluetooth/btnxpuart.c:1759:58: sparse:     expected unsigned char [usertype] loader_ver
   drivers/bluetooth/btnxpuart.c:1759:58: sparse:     got restricted __le16 const [usertype] device_flags
>> drivers/bluetooth/btnxpuart.c:2114:25: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] len @@     got unsigned short [usertype] @@
   drivers/bluetooth/btnxpuart.c:2114:25: sparse:     expected restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:2114:25: sparse:     got unsigned short [usertype]
   drivers/bluetooth/btnxpuart.c:2186:25: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] len @@     got unsigned short [usertype] @@
   drivers/bluetooth/btnxpuart.c:2186:25: sparse:     expected restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:2186:25: sparse:     got unsigned short [usertype]

vim +1758 drivers/bluetooth/btnxpuart.c

  1746	
  1747	/* Secure Interface */
  1748	static int nxp_get_pub_key(struct hci_dev *hdev,
  1749			      const struct nxp_tls_device_info *device_info,
  1750			      u8 ecdsa_pub_key[NXP_FW_ECDSA_PUBKEY_SIZE])
  1751	{
  1752		struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
  1753		const char *fw_name;
  1754	
  1755		if (ecdsa_pub_key[0] == 0x04)
  1756			return 0;
  1757	
> 1758		fw_name = nxp_get_fw_name_from_chipid(hdev, device_info->chip_id,
> 1759						      device_info->device_flags);
  1760		if (nxp_request_firmware(hdev, fw_name, NULL))
  1761			return -ENOENT;
  1762	
  1763		nxp_process_fw_meta_data(hdev, nxpdev->fw);
  1764		release_firmware(nxpdev->fw);
  1765		memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
  1766	
  1767		if (memcmp(nxpdev->crypto.fw_uuid, device_info->uuid, 16) ||
  1768		    nxpdev->crypto.ecdsa_public[0] != 0x04) {
  1769			bt_dev_err(hdev,
  1770				   "UUID check failed while trying to read ECDSA public key from FW.");
  1771			return -EBADF;
  1772		}
  1773	
  1774		memcpy(ecdsa_pub_key, nxpdev->crypto.ecdsa_public, 65);
  1775	
  1776		return 0;
  1777	}
  1778	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
