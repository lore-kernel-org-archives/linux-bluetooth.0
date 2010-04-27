Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Apr 2010 12:42:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Zhu Yanhai <yanhai.zhu@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Liu, Bing Wei" <bing.wei.liu@intel.com>,
	Martin Xu <martin.xu@intel.com>,
	"Zhu, Peter J" <peter.j.zhu@intel.com>,
	"Zhang, Vivian" <vivian.zhang@intel.com>
Subject: Re: Any plan to make telephony backend changeable in runtime?
Message-ID: <20100427094230.GA6555@jh-x301>
References: <4BD68A18.8040608@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BD68A18.8040608@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 27, 2010, Zhu Yanhai wrote:
> For the moment the telephony driver of BlueZ is chose by the
> configure script (--with-telephony=xxx) and fixed after build. Is
> there any plan to make it configurable during runtime?

Actually the idea has been to remove the AT parsing (and therefore also
the telephony driver) completely from the BlueZ side and instead just
export the RFCOMM socket to an external telephony component. In most
cases this would be ofono (it even has basic AT parsing support already)
but e.g. android would benefit from this too since they could start
using the device framework within bluetoothd and its D-Bus interface for
HFP (right now they've got a completely separate thing for it).

Johan
