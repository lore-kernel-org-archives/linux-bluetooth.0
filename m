Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB9379EF6;
	Thu, 16 Apr 2026 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353305; cv=none; b=VP8LFvfj8OOBeJ3VZ3522m+E82GfAL3H+nRDnKsumjnX2ArHix2MDxofeELOdgf77LHA5/RRnsgv2UOvefPjiNiONTGlUp8HGE1F5p7muKSG25z4rxRELvBObx7FqGCjKxoUF+IFOEEma55CDAv+LGUo6F0baLkcqORGpP9Ivko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353305; c=relaxed/simple;
	bh=hihRgoTi2GkqFzYr+lxGSflesasvcNOhnAzpOMBeVU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hn76aikhjkJtquHyROu4WEJ40wtaeei5J2KXHWpI5X/hyzuJTx1ExyTpn4GOchrzAa/A7mC+o4NAypg+R/Vm8uCmVStNyPR0Djq5uJeqq5PWoulL8CJp8b2KrQ76hh+m2bVSYIEV98poEONW1h/e+V3oT2Xsj5Sv8tNwMMVsGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TC6kAGPC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TC6kAGPC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G3PlDE522535;
	Thu, 16 Apr 2026 15:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5xkHEwPM/pl9OM65OXh1DAQw0Nz6h3Gs+IaNCUXEz
	ZY=; b=TC6kAGPCTr4Jk/vWZ5DOBFe6eVcuSBIn7L4wo1Y4G6UG6FRBiausv1Rf4
	reFZyi25sBN6klf63fiOJWkMZK58QN7m9e/jKBd5s4yRXH3WXkUO7r1sZne+OX3Q
	54htG7OxvOMDPNksXUaDlL2V90Whtnwmb9Evq6kvNwlusorDJ6D2MWC/Id314YB+
	AYec/c0NJmyyofUgds6dhuSmGeVqL6zQKxJ6RidwkjQykIRJfbaLHHUIfjwyLY7m
	4vHy3MNd5DqYXCiCHDb/inksHYVO6ZTV3W+NvMwUEEaeP6yCcKIhoeyqN3lXXoDt
	SeGGG8AI4wG/psGFZ4FlDstyZ9fKg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mx77j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:28:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GBPOI6003514;
	Thu, 16 Apr 2026 15:28:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnkekm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:28:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GFSGYk24772890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 15:28:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3AA320049;
	Thu, 16 Apr 2026 15:28:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBEB220040;
	Thu, 16 Apr 2026 15:28:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.248.41])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 15:28:10 +0000 (GMT)
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: marcel@holtmann.org, luiz.dentz@gmail.com,
        chandrashekar.devegowda@intel.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: venkat88@linux.ibm.com, rafael@kernel.org, christophe.leroy@csgroup.eu,
        maddy@linux.ibm.com, riteshh@linux.ibm.com, broonie@kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: Add ACPI dependency
Date: Thu, 16 Apr 2026 20:58:03 +0530
Message-ID: <20260416152803.54396-1-venkat88@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0NiBTYWx0ZWRfX6k2Cn0SPnGf+
 9D2CiZuozfjuiEomR5NGwy2vZKOWIHhU5iS6zxbv4pAa6gsg3n9eddmk3fyJotNjtMnfbusXx5j
 Li63bIl+ZDaODpmewfPIKV16GmTWWro5wCbFh1ofAdAjBDAe2w61CXmGxjf9bvqgx5o3Xg5+vT9
 pOr5h6DKNZawXzLJPHxh+1PF/E6/48Kao5fngfFKU4iJdZePAwiwwbMwJzd8eXF7ifst257Ztk2
 y9flTMKvusuCDung0yP0DV9VTYmC1fNaIBRJoTSj6Sa7uDT7Z9hhlVxWREgq3jesUHB2F6vwhgJ
 7BuBz9m8meWLl6MpVfqaOsXBhfXrwGIsw6SQTGKTwW8oUE+HqVfDHhA76YnC1c9StuGu/Z9zm9F
 0hcjebilYTPLTEeZ7zhhBCp8AzwJqkXVFFcatBBZ3lx/3AYxW4jy5oE/IFswOQrOCpNLCVIvPVP
 Mo7nFZJCzyJZWlIbR+w==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e10015 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7B7D4v-UKSC2LpcJZicA:9
X-Proofpoint-GUID: n3Dq4EwukET4urK1A6n5ac0I8NzGIoE9
X-Proofpoint-ORIG-GUID: n3Dq4EwukET4urK1A6n5ac0I8NzGIoE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160146

The btintel_pcie driver uses ACPI functions (acpi_has_method,
ACPI_HANDLE, acpi_evaluate_dsm) in btintel_pcie_acpi_reset_method()
but can be built without CONFIG_ACPI, leading to build failures
discovered by IBM CI:

drivers/bluetooth/btintel_pcie.c:2309:14: error: implicit declaration
of function 'acpi_has_method' [-Werror=implicit-function-declaration]
 2309 |         if (!acpi_has_method(handle, "_PRR")) {
      |              ^~~~~~~~~~~~~~~

Add ACPI dependency to the Kconfig entry to prevent building this
driver when ACPI is disabled, since the driver requires ACPI
functionality for its reset method.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/ad624e0d-cfd7-4521-ae33-c5c3287b4204@linux.ibm.com/
Fixes: 912a499a7955 ("Bluetooth: btintel_pcie: Support Product level reset")
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
Hi Marcel and Luiz,

I'm submitting a fix for a build failure in the btintel_pcie driver when
CONFIG_ACPI is not set. Christophe Leroy helped identify that commit
912a499a7955 introduced this issue.

 drivers/bluetooth/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index c5d45cf91f88..fc1b37044a9b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -502,7 +502,7 @@ config BT_NXPUART
 
 config BT_INTEL_PCIE
 	tristate "Intel HCI PCIe driver"
-	depends on PCI
+	depends on PCI && ACPI
 	select BT_INTEL
 	select FW_LOADER
 	help
-- 
2.45.2

