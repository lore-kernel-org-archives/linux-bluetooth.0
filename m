Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="KK0SUSi1";
	dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="292S7UbI"
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329AEDA;
	Sun,  3 Dec 2023 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=70zUFPke+a19wKXS4my6rjAuXUg8y4bgDDqcvhJdy1w=; t=1701629196; x=1704221196; 
	b=KK0SUSi1yUNnLKYbNOMc9tSJk0ga0LOSL1KenY+2DT9DrzfIU93Gx+lyv/UMH32cDH/ywaopk//
	IulSqRnmLQH7l4Kvoyb/YVEkAWTXqdjh14mxTTK0wMYZV5Surr0HnxfWOArtBdk8QdX8EokEAQL01
	G4OHMb3zNe94xt2uEgktVKbIj/DPnki5b/Av/AUsrzYF6x+tZhY79WMmWlLDmlQVS8kowf8xx33JI
	SnZpINifYp82hmO0h+l8wc8jmTFyO4QKGAkqYQ6EqYW7nzvR3tXCeY3s/7KnRH5UQlKpnQjNQMD8R
	JXPf0A+ahexl7zIGBjGF+Lo9yVfywpaL1u7w==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=70zUFPke+a19wKXS4my6rjAuXUg8y4bgDDqcvhJdy1w=; t=1701629196; x=1704221196; 
	b=292S7UbIiK8DsG7o4rFr8uYpS0HOuwP6XGuE+e+mU2r1oJvLFBWawurIwo4O73rum/1lX3ytw3R
	/QgvEr9AIBg==;
Message-ID: <808556e5-46b9-41fe-9aeb-2c4782fd5a66@moonlit-rail.com>
Date: Sun, 3 Dec 2023 13:46:36 -0500
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline kernel
 6.6.2+
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Zach
 <zacheryvig@outlook.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <ZWl82n695TIC7nUO@archie.me>
 <115e819b-0271-403c-b034-ef3aebbb85cd@moonlit-rail.com>
 <2709774.mvXUDI8C0e@natalenko.name>
Content-Language: en-US, en-GB
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
In-Reply-To: <2709774.mvXUDI8C0e@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[ Replying to both Oleksandr and Basavaraj ]

Oleksandr Natalenko wrote:
> Does passing `btusb.enable_autosuspend=N` via a kernel cmdline help? [1]

Yes, this works around the problem.  Should be a good short-term 
solution for those folks who need to wait for distro kernels to catch 
up.  Thanks.

Basavaraj Natikar wrote:
>> Can we enable RPM on specific controllers for AMD xHC 1.1
>> instead to cover all AMD xHC 1.1? 
>>
>> Please find below the proposed changes and let me know if it is OK?
> 
> sorry its 
> pdev->device == 0x43f7

Thanks, Basavaraj!  Yes, this fixes the problem on my hardware (by 
making application of PM more selective).  Running successfully at the 
moment using your (pdev->device amended) patch.

Kris
