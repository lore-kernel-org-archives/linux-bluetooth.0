Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <f97b2b971002042041icdafbfaq4382eb631d5c34bf@mail.gmail.com>
References: <912bb79a1002020858lda468aci6fef3e73fac07bd6@mail.gmail.com>
	 <20100202171612.GA7034@vigoh>
	 <912bb79a1002022051o1faf229en95605084fa0e380b@mail.gmail.com>
	 <C408AA84F077D5498977E4A236357B2206C1E687@ZMY16EXM67.ds.mot.com>
	 <f97b2b971002042037j5397ef4j7ceb0521ef12e082@mail.gmail.com>
	 <f97b2b971002042041icdafbfaq4382eb631d5c34bf@mail.gmail.com>
Date: Mon, 8 Feb 2010 22:53:09 +0530
Message-ID: <912bb79a1002080923j78131355v7d9c3559837906b4@mail.gmail.com>
Subject: Re: Kernel panic when SCO connection
From: nirav rabara <niravrabara@gmail.com>
To: Ahmed Ragab <elmasri.ahmed@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ahmed,

Have you tried with SINGH DEVENDRA-DHGW76 suggestion?
I have tried for linux kernel 2.6.22, but the result is same . Also I
think I am having problem with Tx instead of Rx because error show
__tx_submit:hci0 tx submit failed urb c0552c14 type 3 err -19.

I have change the HCI_MAX_ISOC_RX and HCI_MAX_ISOC_TX size to 6  ,
#define TRANSFER_BUF_SIZE 1536 also tested by varying this values but
not successful,

It would be great if you share your experience.

-- 
With Regards,
Nirav Rabara
