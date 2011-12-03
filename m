Return-Path: <cyrus@holtmann.org>
Message-ID: <4EDA85AA.3060400@gmail.com>
Date: Sun, 04 Dec 2011 01:55:14 +0530
From: Syam Sidhardhan <syamsidhardh@gmail.com>
MIME-Version: 1.0
To: Syam Sidhardhan <s.syam@samsung.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Fix dbus reply memory leak
References: <1322144076-1913-1-git-send-email-s.syam@samsung.com> <20111202111510.GA15891@x220.ger.corp.intel.com>
In-Reply-To: <20111202111510.GA15891@x220.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,
On 12/2/2011 4:45 PM, Johan Hedberg wrote:
> Hi Syam,
>
> On Thu, Nov 24, 2011, Syam Sidhardhan wrote:
>    
>> ---
>>   audio/telephony-maemo5.c |    8 ++++----
>>   cups/main.c              |   30 +++++++++++++++++++++++++-----
>>   test/agent.c             |    2 ++
>>   test/mpris-player.c      |    6 +++++-
>>   4 files changed, 36 insertions(+), 10 deletions(-)
>>      
> Your commit message uses the word leak in singular form but there are
> multiple fixes in this patch, i.e. the commit message is misleading. In
> this case I'd split the patch into four separate ones:
>
> telephony-maemo5: Fix D-Bus reply memory leaks
> cups: Fix D-Bus reply memory leaks
> agent: Fix D-Bus reply memory leaks
> mpris-player: Fix D-Bus reply memory leaks
>
> Johan
>    

Yes, you are correct. You can split it into multiple patches.
Thanks in advance.

Syam
