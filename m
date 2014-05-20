Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 May 2014 19:24:19 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vikrampal <vikram.pal@samsung.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, p.sinha@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
Subject: Re: ATT/GATT parsing to hcidump
Message-ID: <20140520162419.GA24078@t440s.P-661HNU-F1>
References: <001601cf7436$ad7c6360$08752a20$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001601cf7436$ad7c6360$08752a20$@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Tue, May 20, 2014, Vikrampal wrote:
> Being new to BlueZ community, I went through BlueZ's TODO items.
> To get started, I've selected the below TODO item as my maiden contribution.
> 
> - ATT/GATT parsing to hcidump. Partially implemented, missing to fix
> multiple advertises in the same event and RSSI
> 
> Please provide me your valuable suggestion for the same. Thanks!

Please don't look at old versions of the TODO. This item was removed
last when when I did some basic cleanup there. Now days btmon is the
preferred replacement for hcidump and it should already have full
ATT/GATT decoding support.

Sorry about the general bad shape of the TODO content. I'm hereby
calling on anyone with time to do further cleanups on this file,
especially the maintainers.

I don't unfortunately have any good first task suggestion for you,
except that you might want to also think of what features you feel are
missing from the perspective of the needs of your company or
organization.

Johan


