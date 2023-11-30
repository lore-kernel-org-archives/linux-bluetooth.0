Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CBE194
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 05:48:18 -0800 (PST)
Received: from [141.14.220.40] (g40.guest.molgen.mpg.de [141.14.220.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0E41C61E5FE03
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 14:48:15 +0100 (CET)
Message-ID: <352db44d-7ed9-48ee-8f44-1fcd0e75768c@molgen.mpg.de>
Date: Thu, 30 Nov 2023 14:48:14 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: BLUFFS: Bluetooth Forward and Future Secrecy Attacks and Defenses
 (CVE-2023-24023)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux Bluetooth folks,


Probably you are already aware of BLUFFS [1], published on November 
27th, 2023.


Kind regards,

Paul


[1]: https://francozappa.github.io/post/2023/bluffs-ccs23/
