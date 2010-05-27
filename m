Return-Path: <cyrus@holtmann.org>
From: "Perelet, Oleg" <operelet@quicinc.com>
To: Ron Shaffer <rshaffer@codeaurora.org>,
	Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 26 May 2010 20:38:56 -0700
Subject: RE: [PATCH 1/1] Bluetooth: Synchronize SCO/eSCO connection requests
 to ACL state
Message-ID: <BCDE476F204B134B8B235FB275BC3AD805E55D3D3D@NALASEXMB01.na.qualcomm.com>
References: <4BFAEB65.2060503@codeaurora.org>
	 <1274864356.27220.155.camel@localhost.localdomain>
	 <4BFD307B.6060805@codeaurora.org>
 <1274887917.27220.166.camel@localhost.localdomain>,<4BFD98F0.5090203@codeaurora.org>
In-Reply-To: <4BFD98F0.5090203@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel, Here's some prehistory of this patch. 1st Nick did:

http://android.git.kernel.org/?p=kernel/common.git;a=commitdiff;h=201ac2f225a31dffcb05f1db4d609c467c9c694c

which unsniffs connection before doing SCO, otherwise establishing SCO took few seconds on some headsets. Then this patch broke whole bunch of headsets that expected SCO only after unsiff is Acked - that what Ron did.

I had email conversation with Nick about that. IMHO this logic belongs to user land, but because of GPL/Apache conflict libbluetooth can not be lifted in to Android Java/JNI - that's why initial change went to kernel. 

If you guys can have some clever way of doing it in bluetoothd - nice. Otherwise this gargantuan kernel patch does fix the problem
 
Oleg.

PS. Sorry if this email conflicts with top posting rules, that's my email client of this moment. I'll buy you sushi:) 
