Received: from server.interlinx.bc.ca (mail.interlinx.bc.ca [69.165.217.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD655E41
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=interlinx.bc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=interlinx.bc.ca
Received: from brian-laptop.interlinx.bc.ca (unknown [IPv6:fd0c:685d:4db3:4ba7:23ab:92fe:41d5:f62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by server.interlinx.bc.ca (Postfix) with ESMTPSA id 91A522F748
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 11:01:56 -0500 (EST)
Message-ID: <cf70cde95a93eb7c9ff87a8c5650f00558c5c213.camel@interlinx.bc.ca>
Subject: Re: chrome passkey communication timing out
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 21 Dec 2023 11:01:56 -0500
In-Reply-To: <CABBYNZJJgYJcswhLcR49H5AE-z7C74HeguwsvHq_BqWr8e3wtw@mail.gmail.com>
References: <6ce4dab33868db0a8c7b93bf58c20aa876d50f21.camel@interlinx.bc.ca>
	 <CABBYNZLbyCkg+heU5gNDooo2w7Uf+P1To0pVnrhS_z7Be3bTYw@mail.gmail.com>
	 <da55cd171a7055f3438447947f36723e9e539547.camel@interlinx.bc.ca>
	 <CABBYNZJJgYJcswhLcR49H5AE-z7C74HeguwsvHq_BqWr8e3wtw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-21 at 10:27 -0500, Luiz Augusto von Dentz wrote:
> Hi Brian,

Hi again Luiz.

> I think it doesn't support LE thus why it can't discover.

Damn.  I was wondering if BLE was the problem.  That means needing to
replace or add dongles to some older machines.  :-(

But this is where it generally sucks.  Trying to figure out which
"brand/model"s of BT adapters out there available to purchase that are
actually supported by Bluez.  Is there any guidance available on how to
successfully do this, other than the trial-and-error of buying and
(hopefully) returning products until one finds one that works?

Cheers,
b.

