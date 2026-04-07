Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2489A3CEB8A;
	Tue,  7 Apr 2026 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580310; cv=none; b=MaIpm60gnd8TqsAv/k9glTqi6IaYQcZlEKszS8Vzij2T3Xa+f3ddpUj9WeNBdg+jitbrLGGSR1rAvzrQeWUxfds0bvTs7YQEQ7gwEMeEY+rlhgBfnXbw2jtSyWL/buGsxFr3bpB4cX3tSqHBCpCaEYkCovv9gGrFw8V9FkUMIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580310; c=relaxed/simple;
	bh=aWghbwSPtJUS+vzgpjiyJYaAA2Zszu5+lPYolEbsot8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tY27m/AkU3QHPGvYgutAsKII0vrTOhLIBS1f55hhqaHsZNKcgh6t5KYQ8GhcKKD8aw6EOouYgw9BnnIGbbQyncBSHSPQvHbD6Ov+9K7KpFh4Mfis3F7xCHNB76uGU0/dP74m+yXhNgp2+HpAzkcML9YHywl/+Ceoi58IK9z3zUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=p/Gp48Oc; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="p/Gp48Oc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=XCD3n1iAjjNwkCO48IJAl65aHao6G63FAPtFryIaWTQ=; b=p/Gp48Ocs2NoBqsP0RG9y+cOiy
	aAb2jdLbogm3M4Rh2z0H7SHKJcV/lWdlj0o+1ih2JnjHfQ/yjrDq3J90T6JaVTvTKbeZ3b7F5B2eb
	XEUTXwznVnnBdiC9Tlwg5gBnbYB+ou3PdCePe/hdqzD6YN5dAJlDm4p75Hk8MPIBXBDoKhcxWVln6
	S2pKZbvQtlkR+Ihr52NEVkJexoNggezVOzPHEH2Qgm3PXz0en/lpm7HOXRwB4Yfo5VzYifr4hTCBU
	08pJu4PiDx2+s5zVgxvx0qZbHGq+wu9/+1i8KolFQoc8szstx28pKmf21sApkEgEqx7MLPc6mj6b6
	OnC8tWN79XwlnKD+EopxK+tNzl/ChS7N/jmmrFaRzuVIMNZiQy3JEfeStD1kkvDOwb+6BH5JEZ40q
	l+qy6GNqujRMqrs7txF5C3S70/AsE7JJ+KyYBW0HNdE50fUIyWZLJ++2U6ku/s+5eSiT4tRnh+xVM
	/HJWlifHCysW6vwa1g0cY2Fe;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wA9Y2-00000007YIM-0Gyj;
	Tue, 07 Apr 2026 16:45:06 +0000
Message-ID: <4e4c1f7f-9ae9-4043-9ebc-e061e24868c8@samba.org>
Date: Tue, 7 Apr 2026 18:45:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: SCO: check for codecs->num_codecs == 1 before
 assigning to sco_pi(sk)->codec
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Michal Luczaj <mhal@rbox.co>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Marcel Holtmann <marcel@holtmann.org>, David Wei <dw@davidwei.uk>,
 linux-kernel@vger.kernel.org
References: <20260407151345.126999-1-metze@samba.org>
 <CABBYNZ+H7qnZFSz=Tx-S2Rdet9a1vEbb_kGbzv_VjC1ZGS5t_Q@mail.gmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CABBYNZ+H7qnZFSz=Tx-S2Rdet9a1vEbb_kGbzv_VjC1ZGS5t_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

> On Tue, Apr 7, 2026 at 11:13 AM Stefan Metzmacher <metze@samba.org> wrote:
>>
>> copy_struct_from_sockptr() fill 'buffer' in
>> sco_sock_setsockopt() with zeros, so there's no
>> real problem.
>>
>> But it actually looks strange to do this,
>> without checking all of codecs->codecs[0]
>> really comes from userspace:
>>
>>    sco_pi(sk)->codec = codecs->codecs[0];
>>
>> As only optlen < sizeof(struct bt_codecs) is checked
>> and codecs->num_codecs is not checked against != 1,
>> but only <= 1, and the space for the additional struct bt_codec
>> is not checked.
>>
>> Note I don't understand bluetooth and I didn't do any runtime
>> tests with this! I just found it when debugging a problem
>> in copy_struct_from_sockptr().
>>
>> I just added this to check the size is as expected:
>>
>>    BUILD_BUG_ON(struct_size(codecs, codecs, 0) != 1);
>>    BUILD_BUG_ON(struct_size(codecs, codecs, 1) != 8);
>>
>> And made sure it still compiles using this:
>>
>>    make CF=-D__CHECK_ENDIAN__ W=1ce C=1 net/bluetooth/sco.o
>>
>> Fixes: 3e643e4efa1e ("Bluetooth: Improve setsockopt() handling of malformed user input")
>> Cc: Michal Luczaj <mhal@rbox.co>
>> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> Cc: David Wei <dw@davidwei.uk>
>> Cc: linux-bluetooth@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Stefan Metzmacher <metze@samba.org>
>> ---
>>   net/bluetooth/sco.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
>> index b84587811ef4..359eabf7dddb 100644
>> --- a/net/bluetooth/sco.c
>> +++ b/net/bluetooth/sco.c
>> @@ -1045,7 +1045,13 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
>>
>>                  codecs = (void *)buffer;
>>
>> -               if (codecs->num_codecs > 1) {
>> +               if (codecs->num_codecs != 1) {
>> +                       hci_dev_put(hdev);
>> +                       err = -EINVAL;
>> +                       break;
>> +               }
>> +
>> +               if (optlen < struct_size(codecs, codecs, codecs->num_codecs)) {
> 
> I guess this is odd because there was no need for this code to exist,
> BT_CODEC should have used struct bt_codec rather than struct bt_codecs
> since we can only set exactly one codec, that said I don't think we
> can change this now thus why we need to perform these checks, anyway
> back to your changes why don't we have both checks for num_codecs != 1
> && optlen < struct_size(codecs, codecs, codecs->num_codecs)) since the
> handling is the same?

Should I submit a v2 using this:
if (codecs->num_codecs != 1 || optlen < struct_size(codecs, codecs, codecs->num_codecs))

Or can you to take it from here?
As I don't really care and the patch is not strictly needed.

Thanks!
metze
