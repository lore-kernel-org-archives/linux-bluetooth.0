Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 1/2] doc: Update RSSI property description.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHZ1yC=3GQJLcuKV4FwRKcHLY2C5xFsQJh1FVpvabBWTpfWsTg@mail.gmail.com>
Date: Wed, 7 May 2014 12:06:00 -0700
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Szymon Janc <szymon.janc@tieto.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Message-Id: <E4F0A858-85C9-4D2C-B716-4C58469A0465@holtmann.org>
References: <1399472233-19056-1-git-send-email-lukasz.rymanowski@tieto.com> <CAHZ1yC=3GQJLcuKV4FwRKcHLY2C5xFsQJh1FVpvabBWTpfWsTg@mail.gmail.com>
To: Scott James Remnant <keybuk@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

>> RSSI property is inquiry RSSI and this should be stated here especially
>> that we plan to add connection RSSI property soon.
> 
> Does connection RSSI really need to be a separate property? Why can't
> the same property be used for both? It's the same device after all.

the problem is that they are different. They get measured differently. One is essentially tight to the Inquiry TX power and the other to the TX power of the connection. Results will be different. This has always been the problem with Bluetooth’s RSSI. Mapping the RSSI you got Extended Inquiry Result to Read RSSI is not possible.

Regards

Marcel

