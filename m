Return-Path: <cyrus@holtmann.org>
Message-ID: <52498C8C.4070200@linux.intel.com>
Date: Mon, 30 Sep 2013 16:37:00 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/3] android: Android version of log.c
References: <1380024798-32017-1-git-send-email-frederic.danis@linux.intel.com> <1380024798-32017-3-git-send-email-frederic.danis@linux.intel.com> <7A4917A5-AD76-48AD-8C04-11707D64CE37@holtmann.org>
In-Reply-To: <7A4917A5-AD76-48AD-8C04-11707D64CE37@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 27/09/2013 04:01, Marcel Holtmann wrote:
>> Add logging system to BlueZ Android daemon.
>> >Android build will use android/log.c file while autotools build will use
>> >src/log.c instead.
> lets just use stdout for now. Changing this later is pretty trivial and introducing large build alternates is a bit too complicated at this point.

I do not understand how writing code to log to stdout can be more simple 
than building and linking existing code.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation
