Return-Path: <cyrus@holtmann.org>
Message-ID: <50052093.4080009@linux.intel.com>
Date: Tue, 17 Jul 2012 10:21:39 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v12 01/13] audio: Move telephony drivers to D-Bus interface
References: <1342090438-20434-1-git-send-email-frederic.danis@linux.intel.com> <1342090438-20434-2-git-send-email-frederic.danis@linux.intel.com> <20120717080817.GA368@x220>
In-Reply-To: <20120717080817.GA368@x220>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

On 17/07/2012 10:08, Johan Hedberg wrote:
> Hi Frédéric,
>
> On Thu, Jul 12, 2012, Frédéric Danis wrote:
>>   Makefile.am                    |   16 +-
>>   audio/headset.c                |  676 +++-------------------------------------
>>   audio/headset.h                |    3 +
>>   audio/manager.c                |   13 +-
>>   audio/telephony.c              |  595 +++++++++++++++++++++++++++++++++++
>>   audio/telephony.h              |   25 +-
>>   doc/assigned-numbers.txt       |    1 +
>>   doc/audio-api.txt              |   90 ++++++
>>   doc/audio-telephony-design.txt |  106 +++++++
>
> Could you split the doc changes into its own patch? You'll need to fix
> that part anyway due to the addition of doc/supported-features which
> conflicts with your Makefile.am changes.
>
I will do this

Fred


-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation



