Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <9F0C1DB20AFA954FA1DA05309350433D5B2E7CEF@pdsmsx503.ccr.corp.intel.com>
References: <49D1FE96.1090200@binarywings.net>
	 <2d5a2c100903310644od9cbf69ma2c28c83b7e51@mail.gmail.com>
	 <49D30FD8.9020506@binarywings.net> <49D45501.8030606@binarywings.net>
	 <2d5a2c100904021028g78376debke885916eba13cf93@mail.gmail.com>
	 <49E5F2BE.1040808@binarywings.net>
	 <9F0C1DB20AFA954FA1DA05309350433D5B2E7CEF@pdsmsx503.ccr.corp.intel.com>
Date: Thu, 16 Apr 2009 10:31:50 -0300
Message-ID: <2d5a2c100904160631o30384806td1b5750669466fce@mail.gmail.com>
Subject: Re: [connman] CreatDevice signal should be emitted at function
	create_stored_device_from_profiles() in src/adapter.c
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: connman@moblin.org
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Yin, Kangkai" <kangkai.yin@intel.com>,
	"Liu, Bing Wei" <bing.wei.liu@intel.com>,
	"Gao, Bin" <bin.gao@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 16, 2009 at 5:49 AM, Xu, Martin <martin.xu@intel.com> wrote:
> Hi:
> I found that at bluez CreatDevice signal is not emitted at function create_stored_device_from_profile() in src/adapter.c.
> That leads to system can not got the CreatDevice singal when the deivce is created though storage. The usage case is that, when I unplug the bluethooth usb dongle and then plug in again. System can not get the CreatDevice signal. So ConnMan can not handle the CreatDevice signal.

IMO the correct way of doing it is to via AdapterAdded signal and then
GetProperties, which in most cases is what you really should do to
discover all devices. If you make stored devices to emit signals you
will probably just slow down the boot.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
