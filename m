Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 17 Nov 2015 13:56:11 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Chan-yeol Park <chanyeol.park@samsung.com>
cc: linux-bluetooth@vger.kernel.org, kbuild-all@01.org
Subject: Re: [PATCH 1/1] Bluetooth: Wait active mode to establish SCO
 channel
In-Reply-To: <201511172023.wxBCAI7y%fengguang.wu@intel.com>
Message-ID: <alpine.DEB.2.10.1511171355250.2455@hadrien>
References: <201511172023.wxBCAI7y%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It looks probable that braces are missing.

julia

On Tue, 17 Nov 2015, kbuild test robot wrote:

> CC: kbuild-all@01.org
> In-Reply-To: <1447759633-4344-1-git-send-email-chanyeol.park@samsung.com>
> TO: Chan-yeol Park <chanyeol.park@samsung.com>
> CC: linux-bluetooth@vger.kernel.org
> CC:
>
> Hi Seungyoun,
>
> [auto build test WARNING on bluetooth-next/master]
> [also build test WARNING on v4.4-rc1 next-20151117]
>
> url:    https://github.com/0day-ci/linux/commits/Chan-yeol-Park/Bluetooth-Wait-active-mode-to-establish-SCO-channel/20151117-192916
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
> :::::: branch date: 65 minutes ago
> :::::: commit date: 65 minutes ago
>
> >> net/bluetooth/hci_event.c:1843:3-48: code aligned with following code on line 1844
>
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout fa3c6055bf2539f74a364206c18e4bc8fd0b6546
> vim +1843 net/bluetooth/hci_event.c
>
> 04837f64 Marcel Holtmann 2006-07-03  1837
> 04837f64 Marcel Holtmann 2006-07-03  1838  	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
> e73439d8 Marcel Holtmann 2010-07-26  1839  	if (conn) {
> 51a8efd7 Johan Hedberg   2012-01-16  1840  		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags);
> 04837f64 Marcel Holtmann 2006-07-03  1841
> 51a8efd7 Johan Hedberg   2012-01-16  1842  		if (test_and_clear_bit(HCI_CONN_SCO_SETUP_PEND, &conn->flags))
> fa3c6055 Seungyoun Ju    2015-11-17 @1843  			cancel_delayed_work(&conn->sco_conn_timeout);
> e73439d8 Marcel Holtmann 2010-07-26 @1844  			hci_sco_setup(conn, status);
> e73439d8 Marcel Holtmann 2010-07-26  1845  	}
> e73439d8 Marcel Holtmann 2010-07-26  1846
> 04837f64 Marcel Holtmann 2006-07-03  1847  	hci_dev_unlock(hdev);
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
