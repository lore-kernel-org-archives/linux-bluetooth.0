Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jun 2012 12:35:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
Cc: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth LE scan/pair using MGMT_OPS on Ubuntu 12.04 fails.
Message-ID: <20120613093544.GA3842@x220.ger.corp.intel.com>
References: <F82830D409D80E4881C83250E051B74B4784BC9E@banasiexm01.ASIA.ROOT.PRI>
 <F82830D409D80E4881C83250E051B74B4A040CBD@banasiexm01.ASIA.ROOT.PRI>
 <F82830D409D80E4881C83250E051B74B4A151824@banasiexm01.ASIA.ROOT.PRI>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F82830D409D80E4881C83250E051B74B4A151824@banasiexm01.ASIA.ROOT.PRI>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vijay,

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

You'd need to be more specific of exactly what kernel version and what
user space version of BlueZ you have. The management interface is only
expected to work properly with latest user space bluez.git and kernel
version 3.4 or later. And for LE you'll want to use the latest
bluetooth.git or bluetooth-next.git or wait until the 3.5 kernel gets
released.

Johan
