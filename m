Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6532134AC;
	Wed, 21 Aug 2024 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224072; cv=none; b=OCsZng11jm7Sy/VRINw9LYUANwg4JsMRn1WLGQajkJv+bq6Vv2yW6T3LnY2QxcVINpNLWLm9vxGFy7uhl+Z06YALnwCG6e/gFOqMfuvnVLGU0iodQoohjyY8OudBOhdMn1+DdWKZdFkIcuMD/7NymBzEUff2CQ4huf6kro1K7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224072; c=relaxed/simple;
	bh=fd6unP1QhS4+ucE1qQebvB100H88E5pJUIgjbGoO8Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApDNwZ6w3uV3cpZ2qD2W0hJ7Nu/RC+FOKjEi4vVWv6Gc9qFm1xn1BhPPr7w0aPmkETKgIwf6cXhfQ9cgxvfHMhwNiZZ7kU0/5YlbCAigOrnwKAs0UCZCXAn41i/XyHGGGF6qE2n5rrAYgYi5kRaPfeRzPr5VqI1n6y64xkzKYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af269.dynamic.kabel-deutschland.de [95.90.242.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CAE8D61E5FE05;
	Wed, 21 Aug 2024 09:07:37 +0200 (CEST)
Message-ID: <2041f798-a44c-4f38-98ad-025fa1186972@molgen.mpg.de>
Date: Wed, 21 Aug 2024 09:07:37 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Drop unused event during BT on
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240726095828.2707111-1-quic_chejiang@quicinc.com>
 <15472cea-904c-4d79-9195-3063ce7f1e2e@quicinc.com>
 <2be3922d-8899-4e58-aa23-57a0b5cfc111@molgen.mpg.de>
 <c3ed299e-709e-4fae-9ef6-c5ad2f6a1c55@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <c3ed299e-709e-4fae-9ef6-c5ad2f6a1c55@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Cheng,


Thank you for the detailed response and explanation. It’d be great if 
you integrated some of the answers into the commit message and resent. 
Thank you again.


Kind regards,

Paul
