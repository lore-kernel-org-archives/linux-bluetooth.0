Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH net-next 1/2] 6lowpan: introduce new net/6lowpan directory
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140711113507.GA24370@omega>
Date: Fri, 11 Jul 2014 14:33:03 +0200
Cc: Network Development <netdev@vger.kernel.org>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org
Message-Id: <E54EDE3F-99A2-49C0-842B-D15E8B7826D2@holtmann.org>
References: <1405067059-18782-1-git-send-email-alex.aring@gmail.com> <1405067059-18782-2-git-send-email-alex.aring@gmail.com> <8A1EF84C-3EDC-4540-B8F4-1FCBF4BF8D93@holtmann.org> <20140711113507.GA24370@omega>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

>>> index cbbbe6d..7ed1970 100644
>>> --- a/net/Makefile
>>> +++ b/net/Makefile
>>> @@ -57,7 +57,8 @@ obj-$(CONFIG_CAIF)		+= caif/
>>> ifneq ($(CONFIG_DCB),)
>>> obj-y				+= dcb/
>>> endif
>>> -obj-y				+= ieee802154/
>>> +obj-$(CONFIG_6LOWPAN)		+= 6lowpan/
>>> +obj-$(CONFIG_IEEE802154)	+= ieee802154/
>>> obj-$(CONFIG_MAC802154)		+= mac802154/
>>> 
>>> ifeq ($(CONFIG_NET),y)
>>> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
>>> index 06ec144..a54777d 100644
>>> --- a/net/bluetooth/Kconfig
>>> +++ b/net/bluetooth/Kconfig
>>> @@ -6,7 +6,6 @@ menuconfig BT
>>> 	tristate "Bluetooth subsystem support"
>>> 	depends on NET && !S390
>>> 	depends on RFKILL || !RFKILL
>>> -	select 6LOWPAN_IPHC if BT_6LOWPAN
>>> 	select CRC16
>>> 	select CRYPTO
>>> 	select CRYPTO_BLKCIPHER
>>> @@ -42,7 +41,7 @@ menuconfig BT
>>> 
>>> config BT_6LOWPAN
>>> 	bool "Bluetooth 6LoWPAN support"
>>> -	depends on BT && IPV6
>>> +	depends on BT && 6LOWPAN
>>> 	help
>>> 	  IPv6 compression over Bluetooth.
>> 
>> this will conflict with our changes in wireless-next tree. We converted out 6LoWPAN support into a separate module.
>> 
> 
> oops, sorry I didn't check on this. I simple based it on net-next,
> because the patch series adds a new branch.
> 
> 
> 
> btw. we need to talk about who branch will commit changes to iphc code
> to avoid conflicts.

a few years back we decided to merge bluetooth-next via John's wireless-next tree so that any interaction with 802.11 and Bluetooth can be sorted out in John's tree. We are now also merging NFC into the wireless-next tree.

So it might be a good idea to include the 6LoWPAN parts into the wireless-next tree as well. If there are conflicts with 802.15.4, maybe that should also go through his trees.

If you want I can also take the net/6lowpan stuff through bluetooth-next tree.

Regards

Marcel

