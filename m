Return-Path: <cyrus@holtmann.org>
Subject: RE: Kernel panic when SCO connection
From: Marcel Holtmann <marcel@holtmann.org>
To: SINGH DEVENDRA-DHGW76 <DevSingh@motorola.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <C408AA84F077D5498977E4A236357B2206C1E8FC@ZMY16EXM67.ds.mot.com>
References: <912bb79a1002020858lda468aci6fef3e73fac07bd6@mail.gmail.com>
	 <20100202171612.GA7034@vigoh>
	 <912bb79a1002022051o1faf229en95605084fa0e380b@mail.gmail.com>
	 <C408AA84F077D5498977E4A236357B2206C1E687@ZMY16EXM67.ds.mot.com>
	 <1265292683.31341.153.camel@localhost.localdomain>
	 <C408AA84F077D5498977E4A236357B2206C1E8FC@ZMY16EXM67.ds.mot.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Feb 2010 06:57:43 -0800
Message-ID: <1265381863.31341.231.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dev,

> Thanks for information Marcel. Do you know that 2.6.33-rc6 kernel code
> having any change regarding points I encountered on older release? 

as I said. We replaced the hci_usb driver with btusb. It is a full
re-write from scratch and should not have any issues.

Regards

Marcel


