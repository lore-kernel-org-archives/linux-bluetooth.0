Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: meshctl fails on rpi 3
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZL5Q-szxged20DgzBnvJnf6AhVkCaQJEM3Ztg4Z1fPy1g@mail.gmail.com>
Date: Mon, 18 Sep 2017 10:38:50 +0200
Cc: Brian Gix <brian.gix@intel.com>, Laczen JMS <laczenjms@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <EF2EC730-AB08-460A-8545-653982057FBC@holtmann.org>
References: <CAFxSrVsZcJxkgAFL8yoSK9buoSzFJryNT18mGSRUUq17VPdOEg@mail.gmail.com>
 <7560B49A-22C4-4A62-AE3F-B1AFA4712B30@intel.com>
 <CABBYNZL5Q-szxged20DgzBnvJnf6AhVkCaQJEM3Ztg4Z1fPy1g@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> Meshctl' crypto does depend on a lot of Kernel based crypto... pretty much everything except for the AES-CCM.
> 
> We might want to update
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/test-runner.txt
> if that is not covering the mesh crypto.

I would also prefer that we start using AES-CCM from the kernel. Someone should take up that task and also use src/shared/crypto.c for it. We should ensure that we use a single place for all the crypto helpers.

Regards

Marcel

