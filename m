Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: How to initialise bcm4354A2 with 3.10 kernel?
To: Qingtao Cao <qingtao.cao.au@gmail.com>
References: <CAPcThSGPMaqJ9zr5fPWM38YH+2DE5M7a5oBNM4pUa3g1Xdba1w@mail.gmail.com>
 <575A749A.1090409@intel.com>
 <CAPcThSGtgY=KyAvgtMd2HPTin7uKqNXbTc-4-9ME4ZYGutK1Lg@mail.gmail.com>
Cc: linux-bluetooth@vger.kernel.org
From: lpoulain <loic.poulain@intel.com>
Message-ID: <575FD5FB.4000404@intel.com>
Date: Tue, 14 Jun 2016 12:01:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAPcThSGtgY=KyAvgtMd2HPTin7uKqNXbTc-4-9ME4ZYGutK1Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harry,

> However, I still found logs that an extra 0x00 byte was skipped over
> (by my workaround patch) for some HCI_Event packet (otherwise lots of
> HCI commands would time out because this extra 0x00 byte would fail
> hci_reassembly()) and start discovery also failed by 0x0C error code
> (command disallowed).

You should ask to the vendor about this issue.
Maybe:
- The firmware is buggy or the wrong one.
- This extra byte is a vendor specific one (for low power mgmt, sw flow 
control...)

What is the behavior if you don't download the hcd ? (using the embedded fw)
Just in case, you can also try to reduce the operational baudrate (115200).

Regards,
Loic
