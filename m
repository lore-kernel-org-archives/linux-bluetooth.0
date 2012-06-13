Return-Path: <cyrus@holtmann.org>
From: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth LE scan/pair using MGMT_OPS on Ubuntu 12.04 fails.
Date: Wed, 13 Jun 2012 09:18:31 +0000
Message-ID: <F82830D409D80E4881C83250E051B74B4A151824@banasiexm01.ASIA.ROOT.PRI>
References: <F82830D409D80E4881C83250E051B74B4784BC9E@banasiexm01.ASIA.ROOT.PRI>
 <F82830D409D80E4881C83250E051B74B4A040CBD@banasiexm01.ASIA.ROOT.PRI>
In-Reply-To: <F82830D409D80E4881C83250E051B74B4A040CBD@banasiexm01.ASIA.ROOT.PRI>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Ubuntu 12.04 using Management OPS , when I launch the "Bluetooth New Device Setup" wizard, it does not show any device, but on console it will find LE Devices. Works good on Ubuntu 10.04. 

$ hcitool lescan
Scanning ...
        00:12:03:19:xx:yy       Keyboard

mgmt_start_discovery() returns write error "Unknown error 524"

if (write(mgmt_sock, buf, sizeof(buf)) < 0)
		return -errno; 

Thanks,
Vijay


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
