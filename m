Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C8D3987D
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718927197; cv=none; b=II0aHDbSW8VL/OR517qBkRPkDFu+hrFBN4xZoecUh0v7D5pKe585DM8J53pU5wZdr+vY9p2K5eAwCj6BoHlSx2lHk5GkcKZL7WKnNaPY3/duJsK7VRh8C4SdU8cZN97BRcWHgtVlcDtJ4k7LLvzxdT/ACqcnnkUW0Av/xxzncrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718927197; c=relaxed/simple;
	bh=2bpWyHIZOsgubBVePt47OHtU+kJ8Myxt9Kt0c50kCT4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dxoZuqR/sYm5lFN6RuuegfDhtnoOY+X40XPvLoOUOmoybeYp3Yihx/eheP/VADLlrhnk8Keiyj99fQThA7Nw+5Qp0CTx/1TnApN31hwitDDXRQ5t3vmVlnWtTTVABtS5psOVfEGy98u/UI238ZcMRckBecD6g+2xheqJKqUdebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jj3K2/k6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jj3K2/k6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718927195; x=1750463195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2bpWyHIZOsgubBVePt47OHtU+kJ8Myxt9Kt0c50kCT4=;
  b=jj3K2/k6M4ZZVRamMu1xx8SYx1tDNxZYP9c91XgPr0/h0q16Eam0STXm
   dS7wutUnwWlswuKBL9GwXA0Mk0evQgs9Dh0H0zc/BNpBxlVe6xXBQKKXJ
   8NQR4t4EYUZ54rJ5VYTBIk+6LU3SGG/OoABQdHQIyeaegJYX1/bcC3/Q3
   HW/KacolukruewO4dDqqADYUCn8eMsamThWnrEEQM58homimHZd/fy9ot
   WMR8xOXTfRxzO2iotAxHoW3jx/6N1yyURZdwqZQ83qTJY8V+Kz7ifSlAv
   tuA6OjSRXCKDEkdgidi6cXprZtVBo8qYj+UYnAl62xlsUkM+oVPZdGXka
   g==;
X-CSE-ConnectionGUID: MgcvLwo+SJGxpx25iUbZVA==
X-CSE-MsgGUID: OkL+goLxTCK5ce2KWlMwLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15771442"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="15771442"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 16:46:35 -0700
X-CSE-ConnectionGUID: btvds8KaRZCUDcyrrR0QDQ==
X-CSE-MsgGUID: FQGSAHy5SGioMGLmMk9zOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="65654087"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Jun 2024 16:46:33 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKRU6-00081m-2V;
	Thu, 20 Jun 2024 23:46:30 +0000
Date: Fri, 21 Jun 2024 07:46:07 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [bluetooth-next:master 14/15]
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddrfacmn-supply' is a
 required property
Message-ID: <202406210706.WvRRDs6P-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   4029dba6b6f105e052272bed37bc82f0ce3e0de3
commit: 251180e6dba54e9bc83b2e85680c536e7ae02219 [14/15] dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
config: arm64-randconfig-051-20240620 (https://download.01.org/0day-ci/archive/20240621/202406210706.WvRRDs6P-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad79a14c9e5ec4a369eed4adf567c22cc029863f)
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240621/202406210706.WvRRDs6P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406210706.WvRRDs6P-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/qcom/sm8250.dtsi:4837.27-4908.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae94000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/sm8250.dtsi:4929.27-4981.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/pm8150b.dtsi:165.9-180.4: Warning (avoid_unnecessary_addr_size): /soc@0/spmi@c440000/pmic@3: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddpmu-supply', 'vddrfa0p9-supply', 'vddrfa1p3-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddrfacmn-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddbtcmx-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddrfa0p8-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddrfa1p2-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: bluetooth: 'vddrfa1p7-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
   arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: phy@1d87000: 'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-ufs-phy.yaml#
--
   arch/arm64/boot/dts/qcom/sm8250.dtsi:4837.27-4908.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae94000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/sm8250.dtsi:4929.27-4981.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/pm8150b.dtsi:165.9-180.4: Warning (avoid_unnecessary_addr_size): /soc@0/spmi@c440000/pmic@3: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
   arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: bluetooth: 'vddpmu-supply', 'vddrfa0p9-supply', 'vddrfa1p3-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: bluetooth: 'vddrfacmn-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: bluetooth: 'vddbtcmx-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: bluetooth: 'vddrfa0p8-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: bluetooth: 'vddrfa1p2-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
>> arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: bluetooth: 'vddrfa1p7-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
   arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtb: phy@1d87000: 'power-domains' is a required property
   	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-ufs-phy.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
