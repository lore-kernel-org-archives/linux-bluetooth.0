Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] doc/advertising-api: Add Discoverable property
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20180522095011.517-1-luiz.dentz@gmail.com>
From: David Llewellyn-Jones <david@flypig.co.uk>
Message-ID: <9313e463-558a-57da-529e-0c463b8fbf24@flypig.co.uk>
Date: Tue, 22 May 2018 11:25:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180522095011.517-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 22/05/18 10:50, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds Discoverable which the application can use in case it want
> to set the General Discoverable flag per instance.
> 
> Note: This would allow for example an application to advertise as
> discoverable even if the adapter is not discoverable which may be
> required by dual-mode as it may not require BR/EDR to be discoverable.

Thanks for these patches Luiz. I'm not sure whether it's useful for me
to comment on them, or whether this is just part of the process of them
winding their way towards a release.

Is there anything helpful I can do with regards these?

David
-- 
Website: http://www.flypig.co.uk
