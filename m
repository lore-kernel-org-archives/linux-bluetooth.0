Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH BlueZ] monitor: Fix EIR Data Type / AD Type assigned numbers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380668677-5259-1-git-send-email-jprvita@gmail.com>
Date: Sat, 5 Oct 2013 15:10:52 +0200
Cc: linux-bluetooth@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Message-Id: <D3B50E9E-B9F6-4333-A634-70A5C7DF8CE5@holtmann.org>
References: <1380668677-5259-1-git-send-email-jprvita@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao Paulo,

> From: João Paulo Rechi Vita <jprvita@openbossa.org>
> 
> The values for Public Target Address and Random Target Address were
> swapped. This information can be verified in the Bluetooth SIG Assigned
> numbers webpage:
> 
> https://www.bluetooth.org/en-us/specification/assigned-numbers/generic-access-profile
> ---
> monitor/packet.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied.

Regards

Marcel

