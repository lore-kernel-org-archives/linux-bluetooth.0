Received: from sonic308-3.consmr.mail.bf2.yahoo.com (sonic308-3.consmr.mail.bf2.yahoo.com [74.6.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A04311977
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046088; cv=none; b=OyBp1GWoLfAOEIEMI607DxwX3UBHr//WS9a13zMtNw5+PqH+VoSveILau9PUDcniq159zZLd2lv5K4hfmWNY9DLRqGXHUhkwfeBaNxCp3z1EKCEqXHAcs7hkkCDKvrdl3BF5ISyayGEERgQH6EGPCOCg6lBtbo4EL3Lqz2VOZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046088; c=relaxed/simple;
	bh=M69x0aqCF6oiv3HOsvWjK9BqgjEoU0/1TCky7rbvixM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAkQ5pNe4BcKeNttdejQzbBwafUjwzR2fZxEJ6W+sIhYyMtLep9Rfbcf641aeNcorubchFIy+RjBfItXzg9jkXsDkJ0OqdeOjqj8jVKDuGwHD7AzSXMOmNfExh4iV0+Ld8HKYdrGT9uMgmGrYJ8BcCYPv8DHJ+Pf7yKDrKRxNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IpOucBMq; arc=none smtp.client-ip=74.6.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IpOucBMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790046085; bh=YEmmChf+epWup6RqSFhltCuFNz7hbH+toteeObo8z7U=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=IpOucBMqznCpj+cwXcdyhJz697cQ9HG6TpYfGPVIUW3lX/vF/ihOvwXDO7z1ZTWJGjSniOMt7PzaAE1fCMZvNWhkD9vB/PAcaGKxPZL1NhSB/ipFjOVCSPMPKzuk1UcV0kGO985WcC5B+KLb8yToWGdK5VlVIyDhN2OWVdSmw24xHYbr0EozrP8J/1sYOtKtMuWkIqWxgO2+WtpSwaaV2+0l47IatJswaIoB8cmiUWBfEMENlZvPRSXTLoUGqwsFxvPZGNsDXjHaQ2Jx2Lv2ZmDEHwbtsvsEldQn36Gr2VOmFsy7Fy6yOcICeEt2DSG/659TfXxFKeL/2iC7Jqwe5A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790046085; bh=cqgxfJAexHWpayVSKfBD7tLtyllMQ4Zi36jhPjOOh61=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=M3nKlkSgBOHz8L2iBfBWP4/WhLzp/BgtYpkimfngFPC70NdGred3wB2TIV8VICbnN8ymSN7GYhg06aZvd/rqez+AgSyhiImyPnbxEHCgZy+1kMOIyHjBbhfwBE7Fg11UdavblUvHWx1oZ8pRwGSkZjsFnAsgGUPaQUgSUhA/n7P+Du30UYUFx8uMI1GEXXNUIXe/rHQ94fRdXhON8VPSM6GFloUBEM396h9OBDDhNg9yAR9+7niFpmWPecFeirEvzmo0FG2ndHcDD4CFON3YS5jgENqo++v7HtT/M19/rPnOWq3F/3BHJuVgfEC5WnUu4KY4582pv1rhMTRPLuVPRw==
X-YMail-OSG: QbjFSMcVM1nVOSqbRC3nzSquDu1JOYFU_hLO_bqUeg5B48wgMRXRylQ9tYOJgfz
 OVmN__V0lkCE0cwWJWlxOkNlvVw_DCKEdAt_j76X50CVsSkBsG5ggXBbF5iiKM2ckcJm3ol_eLe1
 hTlaKh4USwGyB5ZvTIkDgbTGSW4sf_fKwE9jyjO6rR4QCLqFMcdhmtQQEdTesjuEmLUNSdWhwD1f
 WXWNsqWLYAnjI4RqgdFTfaXHhrBebe3QsfjI4wD5byVlRwl8SWkUQW1Ns8EIg8Z5fYI24U9oqCE3
 iVdsxFmhd1IUb9llKI9LUCaAT1bXHbp18_Bq1GrSL0T2Lgt2wVD8GEiLpLF7jR9yXXlNl9dKRZEF
 9FioHEeBsgnuPgrUduzX_sMbeVYD2Yu8Htv7Y4S1egn.PL54Wi9f8Fl9ljDvGaA_m7r4R9xjd83B
 Ultxy3cCDWHDtrSkUtpdx9ZD9tSqIQRFLVjvjfLwvC.YNinsYZXf3jSYsyZAXaHGGkTS8dtuUV_6
 suwVf5yPivEpmtlSMLBaSYHJUWChWhkYyUyu0kyddBHGF1QxXsUKY2fPJfHeZzpSQ8bVuoiiApWv
 Muc5aAZBZyFxdZKlcUQJa8qN.wnofYbjLCnxSd9GPNlEwFBlqabGbYAUYnllZLX5Dq4rcc0zbwZE
 KPXIyJ_HHHw4X2QeSLECkURWWFa5Z_8nM2y1pbGW7faDe40JuKaHrplefCec20AAaDthlVlohAUs
 I9AE27_.fE5BdRvioCSX9Wjr2LaVwknUtln5TGWEqVtK.c.98VUMv8IB11TjwHEwEbY1caOhhWij
 JgE4JqLWPkh_BSBYkgezd5yZfaxpB84ciN8uQU7mUykgAB6pQIs1SVCzPZoe4bcSyPFoMR_ayN71
 aAIw16TFXUTI3hNLANDp5FHuLpCVwxb9T8c3Mtd7E9zIwfPqAhFfs_GT67fgFNQycb7go6tqKEEs
 OVTS_QIB_IPuaQJ61FQopi_uRxrhLFkdzOvRm.FViYfuSEMClE3Z0w5gktlZdqiye.howDRv26g3
 M99yaPR53Zpzz5.y9PGNJS3mQgbUq3_W54poTsW.b711z6uw8d5su8A16S5raBDPyni2BeWBrn68
 vGenFpi.X4EDP6EJIaMC9oEYQ9m3QXP32MdfFbKHCldUGxlRFY6DmvUsEy21HJhYR_PTRl5snrbl
 OO2iI5U2BuA6syDegO9Vf3vugM.5QZOfqEfhbNh3dZznop1wPCU1vXUvY6hMKsof00K7T1F6bNFo
 ZzmWnBv5iQbUJQ7UUa4V.qkkRVuO3gHFWfJ763hBp4UADr3RxkHMEyl_sXBevjnWZMS17VJ5vmWf
 JJtI3scJ2ZDdfcD4s5PgWcGQfljQU90HWdYKeX586UIyLtBUDEsgJMiWSFZvFL54izLvpU1ek10F
 nSELxN6oCx8N0h7.vnPZNcPMWy3eLO7VISpAtSTPrNjdDn1f5XgTtOBcLUGefDvEMpuqhzIA9qha
 GMA_MAVtdxCQ3zx7GVJf.27HzN.dn_2k0gwPqIL5T5OIZyBKYoalpTzmklCdXEBEi7IRsXlrGvGF
 QIEjEvtIjK4p519uFR.yc2qEF.EzNEP7F3goxFEyawjVxOTgiy_D9VLRT6hB_UnBSpPCpEgft2Rn
 QUtpuFD1PzSt_YBrj73Iwx28hYjYs4N4InF1n7rQt2j5V5RmMYeanF0aUF8YARbfvYe8pVCz7RC8
 xNjH9mwLYbZYDLTsAr97d66b4O0aj5kY.E004ixecCmN.Qhyl3B6XrXStZ41pc8rWLpeTgXz4aP0
 6iisYqmynNZ3VoaBX5e8Jbs3phH.QVNHMrTPHyKPmyoD3yAeARflYKMMqsY_1og0FEOs4rG4faPA
 y5tK9ElImBx9ColXQ8a.qPAc4B.ine9Y_kJfiUfGopgEeaqsWKTQHtULWIh0KWqQuuoFNCQl0UMO
 vXlPbjTEB5RAZEqqgsgTY3cw3nbZ5Xo6jbXlaHY6MgmXbnMV5d7iQVei8Y6ihIEpqCmwvbA6zpuI
 c.VZhgKVB4LruP4zb6WD9Ac4ejJP6LzBJLzx6c_WsMoFrUWcoAI9lapbQ3f4.nUkv0Es1oMLn9.D
 0NgcRr7O7xqDpKJmG11dj7FCNdRhVJBO0QPCpRrRKI1hKn4VOJwTf47jMWOCUOanha4HjZWXLXLF
 v6J3dCetSECtaX1_YtFz9fF0Np2CgqEKxPYy0WH4uZGU0iI7AoJTJooB6rDgI5RX78bFDbH6WdOV
 it98Lx8Gn_zHI0A2CcK_xhTt8d0tq
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: e31c7aa3-6d32-413c-b674-226308120b9a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Tue, 22 Sep 2026 03:01:25 +0000
Received: by hermes--production-bf1-54b5569bdc-ssl2t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 09a0407219f3495d733b1aa163761047;
          Tue, 22 Sep 2026 02:40:47 +0000 (UTC)
From: Jeremy Dean <deaner92@yahoo.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: validate DDC record lengths
Date: Tue, 22 Sep 2026 02:40:34 +0000
Message-ID: <20260922024034.2186-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918083838.23676-1-aluvala.sai.teja@intel.com>
References: <20260918083838.23676-1-aluvala.sai.teja@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sai,

A couple of things could be worth a second look here.

cmd_plen is still declared as u8:

    u8 cmd_plen = fw_ptr[0] + 1U;

The addition itself happens in a wider type due to integer promotion,
but the result is truncated back down the moment it's stored in
cmd_plen. 

So if fw_ptr[0] is 0xFF, cmd_plen still wraps to 0, the same
as before this patch. The commit message says this parses the length
"in unsigned storage so 0xFF does not wrap". It will wrap as soon as it 
is placed back into the u8 cmd_plen variable.

It happens to get caught afterward by the cmd_plen < 3 check, 
since a wrapped value of 0 is less than 3. Is that the intended fix?
The commit message seems to mismatch what is diffed.

Also, the cmd_plen > U8_MAX check can never be true. Since
cmd_plen is a u8, its value is bounded by U8_MAX by definition.
There's no input that will make this branch fire.

Regards,
Jeremy Dean
~             
