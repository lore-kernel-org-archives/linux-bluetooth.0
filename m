Return-Path: <cyrus@holtmann.org>
From: "Pawlak, KubaX T" <kubax.t.pawlak@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: Clear role switch pending flag
Date: Thu, 6 Nov 2014 09:39:16 +0000
Message-ID: <088CC8BACB3382439E91D9919CE350242234A869@IRSMSX107.ger.corp.intel.com>
References: <1415192160-5975-1-git-send-email-kubax.t.pawlak@intel.com>
 <7CB3B364-424E-4E98-9981-DD216A3BCAE8@holtmann.org>
In-Reply-To: <7CB3B364-424E-4E98-9981-DD216A3BCAE8@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

> please sort these by opcode. I think we at least tried to have them in order of
> opcode.
> 

Actually opcodes sorting in this function looks like this:
0x0401
0x0405
0x0407
0x0411
0x0413
0x0419
0x041b
0x041c
0x0428
0x0803 <-  sniff mode
0x0804  <- exit sniff mode
0x0406 <-disconnect
0x0435
0x0436
0x200d <- LE related
0x0219 

Mine is 0x080b so it goes at the end and the list needs resorting or in the middle after 0x0803 and 0x0804. 

Kuba
Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen, Deutschland
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Christian Lamprechter, Hannes Schwaderer, Douglas Lusk
Registergericht: Muenchen HRB 47456
Ust.-IdNr./VAT Registration No.: DE129385895
Citibank Frankfurt a.M. (BLZ 502 109 00) 600119052

