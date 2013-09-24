Return-Path: <cyrus@holtmann.org>
Message-ID: <524155D9.4050807@linux.intel.com>
Date: Tue, 24 Sep 2013 11:05:29 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] android: Android version of log.c
References: <1379679871-29623-1-git-send-email-frederic.danis@linux.intel.com> <1379679871-29623-2-git-send-email-frederic.danis@linux.intel.com> <708DB870-5A40-4056-86C8-79092784757C@holtmann.org>
In-Reply-To: <708DB870-5A40-4056-86C8-79092784757C@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 21/09/2013 19:20, Marcel Holtmann wrote:
<snip>
>> @@ -110,10 +137,22 @@ int main(int argc, char *argv[])
>> 	sa.sa_handler = signal_handler;
>> 	sigaction(SIGINT, &sa, NULL);
>> 	sigaction(SIGTERM, &sa, NULL);
>> +	sigaction(SIGUSR2, &sa, NULL);
>> +
>> +	__btd_log_init(option_debug, option_detach);
>> +
>> +	/* no need to keep parsed option in memory */
>> +	free_options();
>> +
>> +	DBG("Entering main loop");
>
> Don't do this debug. It is not helpful. The main() is so short, no point in logging that.

I need at least one DBG call to be able to build, otherwise I got 
"undefined reference to `__start___debug'" error messages.
So, this one seems ok to me.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation
