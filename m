Return-Path: <cyrus@holtmann.org>
From: "Cufi, Carles" <carles.cufi@nordicsemi.no>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 31 Aug 2011 15:12:06 +0200
Subject: RE: [PATCH BlueZ 01/12] Add messages to the mgmt interface to
 handle SMP key storage
Message-ID: <5B4B9A479BF6994B88EA975675EC5B790582745433@MES1OS2SXC003.mes1.tconet.net>
References: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
 <1313799128-8842-2-git-send-email-vinicius.gomes@openbossa.org>
 <20110831080706.GA5861@dell.ger.corp.intel.com>
In-Reply-To: <20110831080706.GA5861@dell.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Isn't the PIN Length completely irrelevant here since the "Passkey
> Entry" pairing method of SSP always requires a 6-digit passkey?

If OOB keys are supported using the same API, then those are 16-byte long. For passkey, then length is fixed to 6 as you mention.


