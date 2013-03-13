Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v3 2/5] Bluetooth: Add option for SCO socket mode
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+QXtDtu-fCY9JXueApOEzfyB8NZF87Xbnh5T_RYBPrNSNRavw@mail.gmail.com>
Date: Wed, 13 Mar 2013 09:26:36 -0700
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>, linux-bluetooth@vger.kernel.org
Message-Id: <FA4A6ABA-3968-4787-8572-EEBAA64F2F0B@holtmann.org>
References: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com> <1359986188-24432-2-git-send-email-frederic.dalleau@linux.intel.com> <1361229298.1583.48.camel@aeonflux> <CA+QXtDtu-fCY9JXueApOEzfyB8NZF87Xbnh5T_RYBPrNSNRavw@mail.gmail.com>
To: "Dalleau, Frederic" <frederic.dalleau@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>> So I would actually propose to add a voice settings uint16 value as SCO
>> socket field. Using the full voice settings make sense since then we can
>> also retrieve the fact if we are doing 8-bit or 16-bit PCM. One detail
>> we kinda ignored since we always defaulted to 16-bit, but would be worth
>> while fixing while at it.
> 
> I'm unconvinced about this. This mean the application wil be able to mess into
> what voice settings will be supported. And if csa2 has to be supported
> in the future,
> a new socket option will be required.
> Is 8-bit sco support really worth it ?

maybe it is not worth supporting 8-bit SCO, but it is a feature that we should not ignore. And in case you want to do multiple SCO connections (some people want to actually), one way of getting less bandwidth usage is to switch to 8-bit PCM. So my current thinking is that we should support it.

Right now I am for working in the context of what we actually have. The CSA2 is not deployed at this moment and it is rather complex. So my thinking is to do voice setting right now and sort out CSA2 at some point later. Unless someone can come up with a good way of integrating CSA2 right now and allow a smooth backward compatibility to non CSA2 devices.

That all said, we can always have a socket option later on that enables CSA2 features.

Regards

Marcel

