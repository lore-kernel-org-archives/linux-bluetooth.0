Received: from out.smtpout.orange.fr (out-17.smtpout.orange.fr [193.252.22.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9CA8F4E;
	Sun, 26 May 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716720003; cv=none; b=pStvoKFyII9eBxeLfiClRU82lhGRhuZTgU9sf/MJSar67LS/cGZFWxJGcyLBfX27houkQU42pLA3apDdGHpARtqi2rP688XKwjgzpE+lZlI47qoY6SkeGNrYphJjmaG/Wd713ue9qHfWZMtxBr3H60Xsqsq9q9LRPSeJVZ5RhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716720003; c=relaxed/simple;
	bh=ABKkFQje7ZO0Xq2B2Vy/IfAlIAoW0dsuFwwptNEUZ1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3mFuODbd043MByHNeIjaqMxxIuBwFB6CyzamK4ERjmFpsreeL/lbSjPd9OGdNOXf3chZIqADRHylt0Ku4Ah8MnMm7bV26O6WoCg4ecATn2sZg2IcCsHFOeTCM44P4/xJE/I58NKdT9eTLDGQHgXFkAAYxyzPoqXT9uvr4j1XCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CVuMyDRI; arc=none smtp.client-ip=193.252.22.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CVuMyDRI"
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id BBH5su3rUWLctBBH5sRads; Sun, 26 May 2024 12:38:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1716719928;
	bh=RZoKiF0VbGitkMBWjUFlo2g+BnlJQuteJAm55UMz3vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=CVuMyDRIr84fG3FaKPfFroOvIXOd3eJvkBd2gegI2vB4BztPsDfmJiTNbiCP5u1Tv
	 dDEoBj6aw7dDQiOWC/dRHbpo0Tfd9X/4q8A+0OyDflaBSWvkBSGbeJBfVE9apx7wnW
	 vyXWX2fzltPe/tyOw4e5mWVUKdhOQ5nYWjWf9JM+iLnbBxcE8OnWW59eFyjq8Jqv27
	 sNZ24iRWQ9c508bqVyjfE9Z+YslefAeHd9gLAoFj4vee/sAM0jeHF1f8ph7fR2dQqw
	 iUJ7DggAFGrm6euvkBNR74lXuyHNxuXpvslE85QOj4ao5rCXQlJebplywuqolB/3wM
	 BYJw6kKfWacDg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 May 2024 12:38:48 +0200
X-ME-IP: 86.243.17.157
Message-ID: <45007327-9d45-4a4e-b88f-ebb9a195e76c@wanadoo.fr>
Date: Sun, 26 May 2024 12:38:46 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Fix the error handling path of
 btintel_pcie_probe()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Tedd Ho-Jeong An <tedd.an@intel.com>, Kiran K <kiran.k@intel.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org
References: <692b4749f4267436363a5a8840140da8cd8858a1.1716190895.git.christophe.jaillet@wanadoo.fr>
 <CABBYNZLeM7MQrBuGE49KN9Xm1EQ-cFK3nR57sg2hWB0jOUFn7A@mail.gmail.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CABBYNZLeM7MQrBuGE49KN9Xm1EQ-cFK3nR57sg2hWB0jOUFn7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 24/05/2024 à 21:39, Luiz Augusto von Dentz a écrit :
> Hi Christophe,
> 
> On Mon, May 20, 2024 at 3:42 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Some resources freed in the remove function are not handled by the error
>> handling path of the probe.
>>
>> Add the needed function calls.
>>
>> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested only.
>> Maybe incomplete.
>> ---
>>   drivers/bluetooth/btintel_pcie.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
>> index 5b6805d87fcf..d572576d0dbc 100644
>> --- a/drivers/bluetooth/btintel_pcie.c
>> +++ b/drivers/bluetooth/btintel_pcie.c
>> @@ -1280,17 +1280,17 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>>
>>          err = btintel_pcie_config_pcie(pdev, data);
>>          if (err)
>> -               goto exit_error;
>> +               goto exit_destroy_worqueue;
>>
>>          pci_set_drvdata(pdev, data);
>>
>>          err = btintel_pcie_alloc(data);
>>          if (err)
>> -               goto exit_error;
>> +               goto exit_free_irq_vectors;
>>
>>          err = btintel_pcie_enable_bt(data);
>>          if (err)
>> -               goto exit_error;
>> +               goto exit_free_pcie;
>>
>>          /* CNV information (CNVi and CNVr) is in CSR */
>>          data->cnvi = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_HW_REV_REG);
>> @@ -1299,17 +1299,25 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>>
>>          err = btintel_pcie_start_rx(data);
>>          if (err)
>> -               goto exit_error;
>> +               goto exit_free_pcie;
>>
>>          err = btintel_pcie_setup_hdev(data);
>>          if (err)
>> -               goto exit_error;
>> +               goto exit_free_pcie;
>>
>>          bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
>>                     data->cnvr);
>>          return 0;
>>
>> -exit_error:
>> +exit_free_pcie:
>> +       btintel_pcie_free(data);
>> +
>> +exit_free_irq_vectors:
>> +       pci_free_irq_vectors(pdev);
>> +
>> +exit_destroy_worqueue:
>> +       destroy_workqueue(data->workqueue);
>> +
> 
> This looks a bit messy, perhaps we should really be calling
> btintel_pcie_remove instead and adapt it to check if a field has been
> initialized or not then proceed to free/cleanup/etc.
> 

Not sure it would be that easy / readable.

It would look like something like:
static void btintel_pcie_remove(struct pci_dev *pdev)
{
	struct btintel_pcie_data *data;

	data = pci_get_drvdata(pdev);

	btintel_pcie_reset_bt(data);
	for (int i = 0; i < data->alloc_vecs; i++) {
		struct msix_entry *msix_entry;

		msix_entry = &data->msix_entries[i];
		free_irq(msix_entry->vector, msix_entry);
	}

	if (data->alloc_vecs)
		pci_free_irq_vectors(pdev);

	btintel_pcie_release_hdev(data);

	flush_work(&data->rx_work);

	if (data->workqueue)
		destroy_workqueue(data->workqueue);

	if (data->dma_pool)
		btintel_pcie_free(data);

	pci_clear_master(pdev);

	pci_set_drvdata(pdev, NULL);
}

The added tests don't always look related to the function call just 
after it :

   - data->alloc_vecs vs pci_free_irq_vectors(), ok why not

   - data->dma_pool vs btintel_pcie_free() does not look that really 
obvious.


There is also another issue in the remove function. We call free_irq() 
on irq allocated with devm_request_threaded_irq().

I'll try to see if more managed resources usage and/or some 
devm_add_action_or_reset() could help.

CJ

>>          /* reset device before exit */
>>          btintel_pcie_reset_bt(data);
>>
>> --
>> 2.45.1
>>
> 
> 

