Received: from qs51p00im-qukt01080101.me.com (qs51p00im-qukt01080101.me.com [17.57.155.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A468BE3
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jan 2024 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xAM7p4LK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1704692017;
	bh=hUGsxklP5O3HkJyMS5fG41bmmNN9Ls8F/ybWB0WkYfk=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=xAM7p4LKvU8I61YF1SdSF+A3AQ967Zb42Cf7MN8XfjCvJXdRIMvH1H2F4NyFDPfUT
	 Q222Hm1RD7GuzAUwEmR0Bpy9hdz7NN8eBuFPVoR5R5/u4aC5Z/XNa0K3zAddVdFIN3
	 w3/ZzkHHzsrayD9dBEzN49o3//fr5uM9hKgdxa8EcycnYHidvzfY/avZL1CJEM90Yo
	 /td0glt/7vhcHC8J5hXInXAO4qIihqkCEqo5N6oKrPdZML7CgRDbIju4K2ee3IzxCo
	 JIyWrjYbqrUNgKlR3w/Vghf5Km3KJXYoJuaa7PAAX0ATmAGF3o1JVO7c+CB8+iZer9
	 BVUpsieyQTzZQ==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080101.me.com (Postfix) with ESMTPSA id C09756180201
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jan 2024 05:33:36 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Sean Moore <sm00re23@icloud.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 8 Jan 2024 00:33:25 -0500
Subject: Heaing aid compatibility 
Message-Id: <56DFB399-7A22-4C36-8750-DC90BC3A2D53@icloud.com>
To: linux-bluetooth@vger.kernel.org
X-Mailer: iPhone Mail (21B101)
X-Proofpoint-ORIG-GUID: hjTFky6oFNLFub76PhcHm1OoBZdCJtm1
X-Proofpoint-GUID: hjTFky6oFNLFub76PhcHm1OoBZdCJtm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-07_15,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=604 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401080043


Hello, i am wondering if there if there is any support for hearing aid compa=
tibility (HAC). Most hearing aids use asha protocol that dont seem to be sup=
ported in anything except apple and android phones.=20=
