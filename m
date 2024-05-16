Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43B5847C
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715839067; cv=none; b=l466mlVVTZEDK1zJGLFPVB+WBoShf8IkdbQmkZiyOg93cI1Epwl49mOaUFh4Gyh9tGIIRDWs133nO6OfdgOeKFTtLXCFrtioq9ThlQBQ8QCmBWzuPliY7hdTKMTYIru/koPaFHvfrYsQrumUD8TAPuXCG9ns8u+xRKCOA9UTik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715839067; c=relaxed/simple;
	bh=+R77cBR6G5qgw/9hn0sawnW19J5DiYo4X2ME/2ie60s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ZxD+8/0J5PWx6Z1JnZQFy1Ce2aJMCY3hwlxpLg1mXBtqM72jY2QFtiqLBFkjOSd9Xsgy4JvPIgw81+FqGFaMkVdLzNo5s3wJZo25aRdVIbtNY5pWBkOaokA9XxWFLzXu6pi9CzQl0pjXAkveKk8vdkHEJ5Way6RDxa7VoDXcdu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IS1UXAWH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IS1UXAWH"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34e0d47bd98so4905130f8f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 22:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715839063; x=1716443863; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFwY+q8HIiqdSofQfocXXp22A6xMY9J4W+q1+hi7gzw=;
        b=IS1UXAWHsdYkIJxJskZda6wCnIUruZ3vhupbCyiVOOPLMMpcH0+ttz+SQy8CKi+qhj
         c2/6+scfRe4JRcSlL0BrFi2LPWe8bADnFY5mS1UYnCPIDdPrcIEg6Xq3XPqhie8LQYIr
         0HL5qEiWAadXlbv3L+aaD2qfh9W+jDPagdF6UUoleorfR7ZzzPsw5zWexkaZHc/PZCht
         rWPIPaL0WqlbZbAx1Iztcs9RDN1ddPOATl56WrrpKIOtyEQ3CmozseIZKSCbRYO/GZfw
         UlakWDYCjk7k1OY3zblKm859qvC3KyPgO1sJ7EzjEllc+Xs59YEd4k/eztXTzpxGhSL7
         S2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715839063; x=1716443863;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RFwY+q8HIiqdSofQfocXXp22A6xMY9J4W+q1+hi7gzw=;
        b=fbchH27tVkE5pfEG3PxzeM1w8nwtEpbL0Red3zcx0NUDlUp1FJXMh4IyWQ/N5tk5V5
         pbwIPTlqfBh3ZWFbhH8GwxhUMBW6ZaaZFbu1unrn6okegchAR6aDsxCmTNq/QPMdZC+D
         T+N0Itt60e186eDIseFmC0IkJ+099oCeGF0G6kW/XMPu74L/PqEPykNjeCtUrQv2X4P4
         /AMAeWx1C+WMa7NTryNd5PPcAVoiZMJNwxDEeGfvMlFPjqswaNLFwyuyhXtrZwbvslj+
         yYo7Kzygx94HbCB65sc04uKfOpMLoFgsz6O7TtAmFIIBjSltlsq1R209l5m8PcNU6PhF
         8zQQ==
X-Gm-Message-State: AOJu0YzraoU+dXn3rbRYxsJu3QcYEOWiOW+l3CKhiAxJ6D1olqYvaX3V
	DGl3OMHD+E5z9kKgY2QAeB+LW/C+WjoaKfAF2DsTGpPi7talR9ulHV4kMS3VAhQ=
X-Google-Smtp-Source: AGHT+IGL24vo+MsBOIFxQ3pSDtxDY+ODJVhiN37n2lmf2jwFMuj9jk8sR0KsoL9J4tjkZhkrc1k5bQ==
X-Received: by 2002:a05:6000:e43:b0:34f:7845:b90f with SMTP id ffacd0b85a97d-3504979ce1amr13855384f8f.5.1715839063117;
        Wed, 15 May 2024 22:57:43 -0700 (PDT)
Received: from ?IPV6:2001:a61:139b:bf01:e8eb:4d8f:8770:df82? ([2001:a61:139b:bf01:e8eb:4d8f:8770:df82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a76e6sm18086113f8f.62.2024.05.15.22.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 22:57:42 -0700 (PDT)
Message-ID: <2ec916ce-c7b9-40f5-bb08-d1d2ba564456@suse.com>
Date: Thu, 16 May 2024 07:57:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kiran.k@intel.com, Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
From: Oliver Neukum <oneukum@suse.com>
Subject: question regarding ordering in btintel_pcie_send_sync()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I was looking at the code. I do not have documentation for the
device, but it looks relatively ordinary. Hence this piece of
code caught my eye:


         /* Set the doorbell to notify the device */
         btintel_pcie_set_tx_db(data, tfd_index);

Requesting an interrupt. However, are you sure the IO can be processed
and trigger an interrupt only after the PCI write, which this triggers?

         /* Wait for the complete interrupt - URBD0 */
         ret = wait_event_timeout(data->tx_wait_q, data->tx_wait_done,
                                  msecs_to_jiffies(BTINTEL_PCIE_TX_WAIT_TIMEOUT_MS));

	Regards
		Oliver
