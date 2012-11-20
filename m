Return-Path: <cyrus@holtmann.org>
Message-ID: <50AB5DD7.3080108@linux.intel.com>
Date: Tue, 20 Nov 2012 11:39:19 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Reply-To: frederic.dalleau@linux.intel.com
MIME-Version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/2] sco: BT_DEFER_SETUP for SCO sockets
References: <1353342958-25303-1-git-send-email-frederic.dalleau@linux.intel.com> <20121119201958.GA14006@joana>
In-Reply-To: <20121119201958.GA14006@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 11/19/2012 09:19 PM, Gustavo Padovan wrote:
> Hi Frédéric,
>
> * Frédéric Dalleau <frederic.dalleau@linux.intel.com> [2012-11-19 17:35:55 +0100]:
>> Regarding testing, I'm still stuck by a txt timeout issue however, if the
>> delay between accept and recv is set to 0, then the connection is working fine.
>> And I even managed to get the sco connection established correctly once. So I
>> believed this emulator problem.
>
> You are telling me that your patch is not really working, I suggest you call
> this series RFC before you get everything sorted out. The approach in general
> is good, but I'd need confirmation that it works for actual defer delays, 3
> seconds for example, and not 0.

Sorry, I have been a bit premature, but for the reason explained
above I was confident.
So now I'm quite happy to say I successfully tested this series this 
morning, based on bluetooth-next, using delays from 0 to 35 secs several 
times in a row.

Regards,
Frédéric
