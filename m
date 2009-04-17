Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <9F0C1DB20AFA954FA1DA05309350433D5B2E8031@pdsmsx503.ccr.corp.intel.com>
References: <49D1FE96.1090200@binarywings.net>
	 <2d5a2c100903310644od9cbf69ma2c28c83b7e51@mail.gmail.com>
	 <49D30FD8.9020506@binarywings.net> <49D45501.8030606@binarywings.net>
	 <2d5a2c100904021028g78376debke885916eba13cf93@mail.gmail.com>
	 <49E5F2BE.1040808@binarywings.net>
	 <9F0C1DB20AFA954FA1DA05309350433D5B2E7CEF@pdsmsx503.ccr.corp.intel.com>
	 <2d5a2c100904160631o30384806td1b5750669466fce@mail.gmail.com>
	 <9F0C1DB20AFA954FA1DA05309350433D5B2E7F5F@pdsmsx503.ccr.corp.intel.com>
	 <9F0C1DB20AFA954FA1DA05309350433D5B2E8031@pdsmsx503.ccr.corp.intel.com>
Date: Fri, 17 Apr 2009 09:46:33 -0300
Message-ID: <2d5a2c100904170546l5062da8xb8e17e3ffc55b455@mail.gmail.com>
Subject: Re: [connman] CreatDevice signal should be emitted at function
	create_stored_device_from_profiles() in src/adapter.c
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: connman@moblin.org
Cc: "Yin, Kangkai" <kangkai.yin@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Liu, Bing Wei" <bing.wei.liu@intel.com>,
	"Gao, Bin" <bin.gao@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 16, 2009 at 10:47 PM, Xu, Martin <martin.xu@intel.com> wrote:
>>I know the way you mentioned, but this way has some issue. You know there is >a time interval between AdapterAdded and DeviceCreated.
> I found that the time interval on my machine is about 230 milliseconds. The time is enough to schedule out to other process to handle the AdapterAdded signal.

There is a fix for this race condition already on git, release 4.36
will be shipped with it. AdapterAdded is now emitted when adapter
properties are "ready", the problem was that we need the adapter
address for accessing the storage but that is only available when
receiving DEVUP event but we were actually emitting AdapterAdded
before when handling DEVREG event. The interval you mentioned is
probably the interval between DEVREG and DEVUP, with the fix it
shouldn't happen anymore since AdapterAdded will only be triggered by
the very first DEVUP to that device.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
