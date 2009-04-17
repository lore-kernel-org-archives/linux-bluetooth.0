Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: "connman@moblin.org" <connman@moblin.org>
Date: Fri, 17 Apr 2009 08:43:46 +0800
Message-ID: <9F0C1DB20AFA954FA1DA05309350433D5B2E7F5F@pdsmsx503.ccr.corp.intel.com>
References: <49D1FE96.1090200@binarywings.net>
	<2d5a2c100903310644od9cbf69ma2c28c83b7e51@mail.gmail.com>
	<49D30FD8.9020506@binarywings.net> <49D45501.8030606@binarywings.net>
	<2d5a2c100904021028g78376debke885916eba13cf93@mail.gmail.com>
	<49E5F2BE.1040808@binarywings.net>
	<9F0C1DB20AFA954FA1DA05309350433D5B2E7CEF@pdsmsx503.ccr.corp.intel.com>
	<2d5a2c100904160631o30384806td1b5750669466fce@mail.gmail.com>
In-Reply-To: <2d5a2c100904160631o30384806td1b5750669466fce@mail.gmail.com>
MIME-Version: 1.0
Cc: "Yin, Kangkai" <kangkai.yin@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Liu, Bing Wei" <bing.wei.liu@intel.com>, "Gao, Bin" <bin.gao@intel.com>
Subject: Re: [connman] CreatDevice signal should be emitted at
	function	create_stored_device_from_profiles() in src/adapter.c
Reply-To: connman@moblin.org
List-Unsubscribe: <https://lists.moblin.org/mailman/options/connman>,
	<mailto:connman-request@moblin.org?subject=unsubscribe>
List-Archive: <http://lists.moblin.org/pipermail/connman>
List-Post: <mailto:connman@moblin.org>
List-Help: <mailto:connman-request@moblin.org?subject=help>
List-Subscribe: <https://lists.moblin.org/mailman/listinfo/connman>,
	<mailto:connman-request@moblin.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: connman-bounces@moblin.org
Errors-To: connman-bounces@moblin.org
List-ID: <linux-bluetooth.vger.kernel.org>

>IMO the correct way of doing it is to via AdapterAdded signal and then
>GetProperties, which in most cases is what you really should do to
>discover all devices. If you make stored devices to emit signals you
>will probably just slow down the boot.
I know the way you mentioned, but this way has some issue. You know there is a time interval between AdapterAdded and DeviceCreated. So on ConnMann when I get AdapterAdded signal and try to use GetProperties to get the device, I found that the Device Array is empty, because at that time the Device has not been created. So no further DeviceCreated signle, ConnMan can not handle the DeviceCreated event any more.
I do not think that send a signal will effect the boot time greatly.
_______________________________________________
connman mailing list
connman@moblin.org
https://lists.moblin.org/mailman/listinfo/connman
