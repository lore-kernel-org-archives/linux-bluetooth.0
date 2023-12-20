Received: from qs51p00im-qukt01072501.me.com (qs51p00im-qukt01072501.me.com [17.57.155.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9236AE5
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="r4qIa4DC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1703078201;
	bh=d4UdTiNMFYHg3979+nLtYgNrNrq6PjxB8478XvGTdeI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=r4qIa4DCMaPTLezPNkuP66B2u+MMpCvzsWiFD1ox65gs+4pG9BBBc5B5Drg193pOm
	 +zagS3pKBgr3lTvcJ4vrydJTwOj4IZ0LUy7CN+AXf5WO6OGDGXh7qRbMJL/5dW7yoX
	 JZwUDYzBidFAZEaCtsKvjQKw+IjwVwVEpn3f/0/+2X7Pea4NKAH/9oHmIeiwlA+1fs
	 x5Vqz4LPvcvLDUZm2uGRL8xSPWFHfP0F5l/wr8hMwF5/K7HYs59IJ6t4Rmg2bJiKwA
	 1oe5yjZJAm32mjCgXBx31213c4qX4R363T9KamtaZn+9f0hGGQLmeoUjXYhBLWvroZ
	 SHjedUARcS6Fw==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072501.me.com (Postfix) with ESMTPSA id AC8BD44039E;
	Wed, 20 Dec 2023 13:16:39 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Celia R L R Normand <celiarlrn@icloud.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 20 Dec 2023 10:16:36 -0300
Subject: Re: [PATCH] Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer
Message-Id: <428FD6AE-6E46-4BCD-A6A0-C37C59CDB864@icloud.com>
Cc: gregkh@linuxfoundation.org, linux-bluetooth@vger.kernel.org
To: marcel@holtmann.org
X-Mailer: iPhone Mail (19H321)
X-Proofpoint-ORIG-GUID: y1AdvXSc5AmXZ_QS4BjrmegRA2Nw851H
X-Proofpoint-GUID: y1AdvXSc5AmXZ_QS4BjrmegRA2Nw851H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=404
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2312200094



Enviado do meu iPhone
