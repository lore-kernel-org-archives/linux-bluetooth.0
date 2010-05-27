Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH 1/1] Bluetooth: Synchronize SCO/eSCO connection
 requests to ACL state
From: Marcel Holtmann <marcel@holtmann.org>
To: "Perelet, Oleg" <operelet@quicinc.com>
Cc: Ron Shaffer <rshaffer@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <BCDE476F204B134B8B235FB275BC3AD805E55D3D3D@NALASEXMB01.na.qualcomm.com>
References: <4BFAEB65.2060503@codeaurora.org>
	 <1274864356.27220.155.camel@localhost.localdomain>
	 <4BFD307B.6060805@codeaurora.org>
	 <1274887917.27220.166.camel@localhost.localdomain>
	 ,<4BFD98F0.5090203@codeaurora.org>
	 <BCDE476F204B134B8B235FB275BC3AD805E55D3D3D@NALASEXMB01.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 27 May 2010 12:34:29 +0200
Message-ID: <1274956469.4706.2.camel@aeonflux.t-mobile.de>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oleg,

> Marcel, Here's some prehistory of this patch. 1st Nick did:
> 
> http://android.git.kernel.org/?p=kernel/common.git;a=commitdiff;h=201ac2f225a31dffcb05f1db4d609c467c9c694c
> 
> which unsniffs connection before doing SCO, otherwise establishing SCO took few seconds on some headsets. Then this patch broke whole bunch of headsets that expected SCO only after unsiff is Acked - that what Ron did.
> 
> I had email conversation with Nick about that. IMHO this logic belongs to user land, but because of GPL/Apache conflict libbluetooth can not be lifted in to Android Java/JNI - that's why initial change went to kernel. 
> 
> If you guys can have some clever way of doing it in bluetoothd - nice. Otherwise this gargantuan kernel patch does fix the problem

I am fine with doing this inside the kernel. It makes perfect sense, but
it needs to be aligned a little bit with the overall way on how we
handle connection setup.

My main question was if it a retry because of failure or if we
preemptively wait until we are in active mode. And that got answered
since the headsets will lock up if we even try.

Regards

Marcel


