Return-Path: <cyrus@holtmann.org>
Date: Fri, 03 Jul 2009 11:14:07 +0200
Message-Id: <1398826966@web.de>
MIME-Version: 1.0
From: bt module <btmodule@web.de>
To: debian-user@lists.debian.org, linux-bluetooth@vger.kernel.org
Cc: debian-devel@lists.debian.org, debian-kernel@lists.debian.org,
	debian-kernel-maint@lists.debian.org
Subject: connection problem between BlueZ and BT module via UART port.
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!
I am currently working on Debian with the latest version of kernel 2.6 of linux. I have bought a bluetooth module of the CSR company ( BTM-330, running with the BC4_roam type microprocessor) I have tried to link it with öy computer via the HCI protocol already existing on the one hand on Linux ( thanks to the installation of the blueZ package) and on the other hand also there on my BT module. However when I try to connect it with the hciattach commad on the UART type port (ttyS0) I get the following message:"Initialization timed out".
Here is the tye of commad I have entered: hciattach /dev/ttyS0/csr 

Regarding the BT card, we can observe that the message is indeed received by the card because the light gets ON, but on the whole the connection between blueZ and te BTmodule is not realized. Then when I enter the hciconfig commad to see if the öodule has been detecte on the PORT, there is indeed nothing displayed. I have made internet searches on my own and from what I have read, it seems that it is due to the fact that the hciattach command needs to define the BT card at a baud rate of 230400 whereas on linus 2.6 ther is a "bug" that doesn't allow the UART to be programed at baud rates higher than 115200.

So I would like to hve your point of view on this justification of the non detection of the bt module. Has anyone an idea of the localisation of the problem, and who eventually knows how to correct it?

Thanks!
________________________________________________________________
Neu: WEB.DE Doppel-FLAT mit Internet-Flatrate + Telefon-Flatrate
für nur 19,99 Euro/mtl.!* http://produkte.web.de/go/02/

