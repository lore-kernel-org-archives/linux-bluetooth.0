Received: from sonic316-11.consmr.mail.bf2.yahoo.com (sonic316-11.consmr.mail.bf2.yahoo.com [74.6.130.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF403D3012
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348283; cv=none; b=KAiNnJRrzT85D3XF1Aa32paPY1UQemLK1dlllifyq7pR/Okc84k+Yuezv0gjTBQ0OgLRhLIQzhQW+eWBfV5Yy9oJm4uRZu+QPD+CNDXpzqG2w5Gn/EIjdYKHjClCzPmG+64XiI78wirTXjX6WHZgRIhIOsDC50H5F3IkKP4tsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348283; c=relaxed/simple;
	bh=o0zlS+G3bVU4GkC2oeKgR/wyk2/s4HXf19ThJ8VKR1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGb28fZ5lPfcxVFfqWdq7W5MbjdlH/CkHv91Ht2jZ+W9s/iXgP4dMyY1pth7laxUqDDtKuU176XjRn7RZFauwuJ241A2Ox8nQEijadBrUZaUI1Hcb56ZGnd4AjW/508wa0SwBVirtHTJnA+QbO/JrEYVIZ78JgrDtr8H4tzKN8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WT0sgXKK; arc=none smtp.client-ip=74.6.130.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WT0sgXKK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790348272; bh=vcE2TYxOIRQwc3jbFqRc+h3qiX7m3Q/hSKXJBScSH+k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WT0sgXKKMCjmPQF95KW8/+/PmjsU+IOf1keF5JQe9OATVzrYPUvXmmTqyVhP7YnHCVwzkXUDtS5zwWqT2E4pw1/E23TwkKZZ6y8AjcZHqZuhv6wbP0UwR4tvzOXd0PSzqd3rzlDp6B4fUItkb7hfwqGijZFpRqD6h/ih2cnDknLBTOeWYGhX0wzanPWPFEmWyWQkDWc3l7Dzrfxbv/Ka5OvEme2jklSRJgOgY/0SFTIrytV6z3+TfAVblUz4UIPtm/AtkfOvXqis1bhu/Lrzg5JFO6Yejanoe+Vq/WwIPLmZlNUI7jtGhJoWyVwD495XdQMSef1JJsYzAtpe35rZGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790348272; bh=jNlFrHVd52lgBoMhWlRpbfnrVklWQBGTpT5X1AoVZcS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UdLDMnM7WtQBxcZ1vhTSyuztnCUBb3xe8SvY7aaq5bI0n4SqUEUIy1WJkm+6NpjG7YN5JCqg5MehhpGPUytHUJnQzs9Nvly3zjHpYQ9IRApIRLvENnvZkfcqqIL8a31qywU8rkBrLKlZhRdSzkvug2ZZiB4NrACxQTTwIEI5fBY+LPNpTsFRmz0qid/p1pv/JPb3j78FWBiQ6f8KadpWunIeAQQeJofywoUU0ZeT096po1+1jALSA1EzI3u4EysWvZyYpqhDYrgM8WQ09t3ZyDC8nWMjekGvb6xVoiTJQIr5LOiXTBujJjq0JlgywcyEp7VvieaSROjNXZ32JLdBEA==
X-YMail-OSG: hNf3aasVM1kQz8S2KeqSM1HBAiBeFrA6QW9btiofWj84PxlDK_bqytHB6.mNn.K
 MSRZoO8y4RubHDj2YVEtKfBrS28Gy7j002tUmlDv4NB0adl7wcLCRMTtSQnKTE.kMn34oYA99NhN
 nF4lvQTcdkyXjIBtZpUFhOzQqmZzj27QbllUbcRvOILWF06uwP6Ri5SQkPiThPC7PNGVeDsjA5BH
 3BaX4Qgcd18PJqpTU11f27Ps7d9qYjKdn2QMrj28BLk5fCc44BDwUjQNZnL7Ww9EzAdGLZ4hRkhX
 WkhBR9K9xNWSKLk4NtP6CUM7dAe_XKwBcirPJTIuqMoe1wnFldf.sTmTAPexCtz4nBFS35X.u3zJ
 6cZp5qW5V_lYbqsQhZ8817DZ40r.QFMM74S2ttoOcDs5Tc3TxBQWu7rYhguSrKQ_EuZ.6oy_yoF6
 AueP56oYEDkdQmO0.G068adI578L1UHa5mRgt6KXVpXix1XpaBfvYvi7tUgKCh631rQkuRvaGVXO
 PpugF7CajbYE21Y2.VMKMlaZVXlb..mURQeqo_1z4RljjXNJmBiXAuLhfN2plM_l7Q1A0EyVjaTk
 cgun2uw4VJxk4hb813I5BwYNld22QifdKO_i7y5RfoQyB0X13pACze0Z2M5lpDtIrDgoFDD4zUir
 3Y2Ec2tOfAneOINkVG4CcT7mH9yyWBLpnESpjuqtce69R2m8LJ.MBu9V28tVKB1GynHi6ez2seEQ
 O1KF73Kno7PgEzcQYARyhVOd_QILJTadx1PB5iyaM6aQVtHHcq.NpCGIkvUQdhQVF7CFSOd0.cXE
 rWaVPDg0Pi.ZFmJuPBcPVCJuzSHhR9eX7FA67vD84_u6fZLpyy8s8DWn2mC6HY2SJK3M2XKoAqd4
 6ZktmwFmVn98arqkx5m1cWFS7dfIIhq9_1IY8LfBb9g9Wlz70Eoyf4Zqq.U63jApNYMAScZqwrBE
 GIQxEapEUq2EYoyFf48NWI7kHoOyUfWubAS0e4fbjilsS1e4cxkOygHVpAKOM9HEeXXrH7LtEHFz
 rlmQ52DQb07gjeY7C9JBP.McmAzGjh05Omv3R5Fot_FC_u0vPYp.JZi.7zLOlMyWxjX5rbmX9gfT
 IbYcojgo.0AxEyXdTkNcXxh_qsAWzmG00ZP18d0vXMB1xmRdNHELjlPbEvQBR30CZ8EcO1M8Q_Fn
 nScGSZKLPbDOj0TEVwHMvdUSKwiVUP4VEfVm5I3QrzAOE1p_r2abetZRGJSXR00tECwIUW9OaXSr
 ysM92__hAY3bCsuTu6VTQwlBW4kGMp1Uxgm1WBS2R_IKk22aG_D_w0r4uYaoC5V7cRHwfktQRE1u
 3yU4oPJ4JGEd3W6par0Ji29apuTZgtmFCc_wsk26H3VIrefPHCj61k9mzb8E9hZxNj8yYtuKZsO7
 TPfJ5e4_NzBp81iRBMLBPIWw5JSsNVTE6jx9.X7n.EMsA3plpHfreRc9EDeYMLO.3VLuO2.vJoZ0
 TeCQ2MCqNMRVvQd0RAMmRGJ13wCu8ax1.sdMhn9h4aAjrB1kdmpPrDT1HMjvq6K08N9ngVR65n6U
 s9iLJBR8mjus39r1k36M.XCwH8raXrm77F0C3XTVWOEUA3.HZKG22onapEB5nhM90_yiyikzwrhV
 uGh9DPJ.QbKXFdMkhf8K0y7DC5Mq.8V2jCFtiLnX5Co3AImmXTgHhnfZycvLmdYx6ETM975hlVci
 oihRZZfHEVFEF5cHhetKvBXcmWRBr5kW8W8.U5dzkaOqUQaa7b1d9hO3nhp3Fp_qdcfFyFQby2vF
 Ao9Gc3krk3EqBlPXGfWWglGFqqK1nWIkYESfGdKBX86w4EsBD1fQlahsK2quuPFPoDli2zfVhRyP
 En4L3qwaPR15oEGHsnghMJae2zTENHnvzYMBWA9VO.Ftk1_cI7JElwaIlfUc9TbcMejOs09Fyp8v
 8BmtgO8.l36l.fpfenP7Nlgc8Wh6kb9zrXJj.CXoY_ML7ewkFuYnyDYzBxmK9x9C88aOErzZ8FFX
 WZPTRNUpnFUfV8KLCp1jAcffQu.ACVOAuR6yK_fqt9Dc4vmlHO2d5wCM3dQFJYHTjyXJh9AGA5gp
 YmPcGxcz4ovvAGY_p4t7UAkrgvO4vPlxYwV.GxfJeP2f1ws9zYG8dD5qsbisoKIBXTSL74u5MXfq
 5jDyP79dp76cUZ5DF5JlJOKQi9idAS_waL_qfHZAit6mkqOPLNX.w93PehZTLz1M6Jtqs90S_BmA
 ZPV0edcovjlGOZ7qH47_f0BNXi8xDZ8..ZA--
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: fb53b779-a561-4827-b81f-a29461624a08
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Fri, 25 Sep 2026 14:57:52 +0000
Received: by hermes--production-bf1-54b5569bdc-kpwjr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d23fec05b19ccab13857221882d08c80;
          Fri, 25 Sep 2026 14:02:47 +0000 (UTC)
Message-ID: <44c92556-0d48-423f-8491-6985b86cd000@yahoo.com>
Date: Fri, 25 Sep 2026 10:02:43 -0400
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel: validate DDC record lengths
To: Aluvala Sai Teja <aluvala.sai.teja@intel.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "K, Kiran" <kiran.k@intel.com>
References: <20260918083838.23676-1-aluvala.sai.teja@intel.com>
 <20260922024034.2186-1-deaner92@yahoo.com>
 <MW5PR11MB5881C7B240C7AB3285E25C5DCC832@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jeremy Clifton <deaner92@yahoo.com>
In-Reply-To: <MW5PR11MB5881C7B240C7AB3285E25C5DCC832@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26577 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Sai,

If you are busy, I am willing to
send a follow-up patch myself with cmd_plen widened to unsigned int,
referencing your original patch.

Thoughts? Is that proper etiquette?

Jeremy Dean

On 9/22/26 8:43 AM, Aluvala Sai Teja wrote:
> Sai,
> 
> A couple of things could be worth a second look here.
> 
> cmd_plen is still declared as u8:
> 
>     u8 cmd_plen = fw_ptr[0] + 1U;
> 
> The addition itself happens in a wider type due to integer promotion, but the result is truncated back down the moment it's stored in cmd_plen.
> 
> So if fw_ptr[0] is 0xFF, cmd_plen still wraps to 0, the same as before this patch. The commit message says this parses the length "in unsigned storage so 0xFF does not wrap". It will wrap as soon as it is placed back into the u8 cmd_plen variable.
> [Sai] : Agreed .will change cmd_plen declaration to unsigned int in v2 patch
> 
> It happens to get caught afterward by the cmd_plen < 3 check, since a wrapped value of 0 is less than 3. Is that the intended fix?
> [Sai] : Yes. DDC format is Length (1 byte), DDC ID (2 bytes), and DDC value . length and ddc id of 2 bytes are minimum expected bytes.
> The commit message seems to mismatch what is diffed.
> 
> Also, the cmd_plen > U8_MAX check can never be true. Since cmd_plen is a u8, its value is bounded by U8_MAX by definition.
> There's no input that will make this branch fire.
> [Sai] : Agreed. This check will become valid once cmd_plen is declared as unsigned int
> 
> Regards,
> Jeremy Dean
> ~

