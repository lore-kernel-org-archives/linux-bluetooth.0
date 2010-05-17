Return-Path: <cyrus@holtmann.org>
From: "Zhang, Zhenhua" <zhenhua.zhang@intel.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 17 May 2010 10:20:16 +0800
Subject: RE: [PATCH] Dial-up Networking profile API
Message-ID: <33AB447FBD802F4E932063B962385B351E817236@shsmsx501.ccr.corp.intel.com>
References: <1273371107-31813-1-git-send-email-gustavo@padovan.org>
 <33AB447FBD802F4E932063B962385B351E79EBA6@shsmsx501.ccr.corp.intel.com>
 <20100517021829.GG23754@vigoh>
In-Reply-To: <20100517021829.GG23754@vigoh>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Padovan,

Gustavo F. Padovan wrote:
> Hi Zhenhua,
> 
> * Zhang, Zhenhua <zhenhua.zhang@intel.com> [2010-05-10 08:41:59
> +0800]: 
> 
> ...
> 
>>> +DUNAgent hierarchy
>>> +===============
>>> +
>>> +Service         unique name
>>> +Interface       org.bluez.DUNAgent
>>> +Object path     freely definable
>>> +
>>> +Methods		void NewConnection(filedescriptor fd)
>>> +
>>> +			This method gets called whenever a new DUN
>>> +			connection has been established.  The objectpath
>>> +			contains the object path of the remote
>>> device.  This
>>> +			method assumes that DBus daemon with
>>> file descriptor
>>> +			passing capability is being used.
>>> +
>>> +			The agent should only return
>>> successfully once the
>>> +			establishment of the data call has been fineshed
>> 
>> A typo 'fineshed' should be 'finished'.
> 
> Thanks. ;)
> 
>> 
>>> +			without problems.
>>> +
>>> +			Possible Errors:
>>> org.bluez.Error.InvalidArguments
>>> +					 org.bluez.Error.Failed
>>> +
>>> +		void Release()
>>> +
>>> +			This method gets called whenever the service daemon
>>> +			unregisters the agent.
>> 
>> Compared with hfp-api.txt, I think we should also add the
> sentence like "or whenever the Adapter where the DUNAgent
> registers itself is removed".
> 
> Or we can remove that sentence from hfp-api, since when a
> adapter is removed bluetoothd relaese all agents on that adapter.
> 

Well. It's all upon on you. I am fine. :-)

> Regards,
> 
> --
> Gustavo F. Padovan
> http://padovan.org

Regards,
Zhenhua

