Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Nov 2012 17:16:49 +0200
From: Johan Hedberg <johan.hedberg@intel.com>
To: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth:master 60/61] net/bluetooth/hci_core.c:683:19:
 sparse: incorrect type in assignment (different base types)
Message-ID: <20121109151649.GA27541@x220.P-661HNU-F1>
References: <509ce8e0.fhFHxG5k0tIvGjwr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <509ce8e0.fhFHxG5k0tIvGjwr%fengguang.wu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Nov 09, 2012, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
> head:   108777e09bbe7874dc5224173a1e3f3ee4ac6471
> commit: c82263e2cfbf6d5c030d0e424ecc91402910e46e [60/61] Bluetooth: Add support for setting LE advertising data
> 
> 
> sparse warnings:
> 
> + net/bluetooth/hci_core.c:683:19: sparse: incorrect type in assignment (different base types)
> net/bluetooth/hci_core.c:683:19:    expected unsigned char [unsigned] [addressable] [usertype] length
> net/bluetooth/hci_core.c:683:19:    got restricted __le16 [usertype] <noident>
> 
> vim +683 net/bluetooth/hci_core.c
> 
> c82263e2 Johan Hedberg 2012-11-08  667  		goto unlock;
> c82263e2 Johan Hedberg 2012-11-08  668  	}
> c82263e2 Johan Hedberg 2012-11-08  669  
> c82263e2 Johan Hedberg 2012-11-08  670  	memset(&cp, 0, sizeof(cp));
> c82263e2 Johan Hedberg 2012-11-08  671  
> c82263e2 Johan Hedberg 2012-11-08  672  	len = create_ad(hdev, cp.data);
> c82263e2 Johan Hedberg 2012-11-08  673  
> c82263e2 Johan Hedberg 2012-11-08  674  	if (hdev->adv_data_len == len &&
> c82263e2 Johan Hedberg 2012-11-08  675  	    memcmp(cp.data, hdev->adv_data, len) == 0) {
> c82263e2 Johan Hedberg 2012-11-08  676  		err = 0;
> c82263e2 Johan Hedberg 2012-11-08  677  		goto unlock;
> c82263e2 Johan Hedberg 2012-11-08  678  	}
> c82263e2 Johan Hedberg 2012-11-08  679  
> c82263e2 Johan Hedberg 2012-11-08  680  	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
> c82263e2 Johan Hedberg 2012-11-08  681  	hdev->adv_data_len = len;
> c82263e2 Johan Hedberg 2012-11-08  682  
> c82263e2 Johan Hedberg 2012-11-08 @683  	cp.length = cpu_to_le16(len);

This is actually a real bug which would show up at least on big endian
systems: cp.length is just one byte so no byte order conversion should
be attempted. Gustavo, do you want me to send a patch to fix it or will
you remove this patch from the current tree and let me send a revised
version?

Johan
