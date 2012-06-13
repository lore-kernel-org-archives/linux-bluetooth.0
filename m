Return-Path: <cyrus@holtmann.org>
From: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
To: "'Johan Hedberg'" <johan.hedberg@gmail.com>
CC: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: RE: Bluetooth LE scan/pair using MGMT_OPS on Ubuntu 12.04 fails.
Date: Wed, 13 Jun 2012 09:51:35 +0000
Message-ID: <F82830D409D80E4881C83250E051B74B4A151884@banasiexm01.ASIA.ROOT.PRI>
References: <F82830D409D80E4881C83250E051B74B4784BC9E@banasiexm01.ASIA.ROOT.PRI>
 <F82830D409D80E4881C83250E051B74B4A040CBD@banasiexm01.ASIA.ROOT.PRI>
 <F82830D409D80E4881C83250E051B74B4A151824@banasiexm01.ASIA.ROOT.PRI>
 <20120613093544.GA3842@x220.ger.corp.intel.com>
In-Reply-To: <20120613093544.GA3842@x220.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Jun 13, 2012, Vijaykumar Dadmode wrote:
> Hi,
> 
> On Ubuntu 12.04 using Management OPS , when I launch the "Bluetooth New Device Setup" wizard, it does not show any device, but on console it will find LE Devices. Works good on Ubuntu 10.04. 
> 
> $ hcitool lescan
> Scanning ...
>         00:12:03:19:xx:yy       Keyboard
> 
> mgmt_start_discovery() returns write error "Unknown error 524"
> 
> if (write(mgmt_sock, buf, sizeof(buf)) < 0)
> 		return -errno; 

>> You'd need to be more specific of exactly what kernel version and what
>> user space version of BlueZ you have. The management interface is only
>> expected to work properly with latest user space bluez.git and kernel
>> version 3.4 or later. And for LE you'll want to use the latest
>> bluetooth.git or bluetooth-next.git or wait until the 3.5 kernel gets
>> released.

Sorry about that. Yes I am using latest from bluez.git and kernel from bluetooth-next.

BlueZ userspace version: latest clone from "git://git.kernel.org/pub/scm/bluetooth/bluez.git".
Kernel version: 3.4.0-rc5

Thanks,
Vijay


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
