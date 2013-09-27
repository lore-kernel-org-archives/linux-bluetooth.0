Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 2/2] android: Android version of log.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <524155D9.4050807@linux.intel.com>
Date: Fri, 27 Sep 2013 03:58:11 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B0FC00FC-EEA4-435D-89D4-3AC95759DA03@holtmann.org>
References: <1379679871-29623-1-git-send-email-frederic.danis@linux.intel.com> <1379679871-29623-2-git-send-email-frederic.danis@linux.intel.com> <708DB870-5A40-4056-86C8-79092784757C@holtmann.org> <524155D9.4050807@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> <snip>
>>> @@ -110,10 +137,22 @@ int main(int argc, char *argv[])
>>> 	sa.sa_handler = signal_handler;
>>> 	sigaction(SIGINT, &sa, NULL);
>>> 	sigaction(SIGTERM, &sa, NULL);
>>> +	sigaction(SIGUSR2, &sa, NULL);
>>> +
>>> +	__btd_log_init(option_debug, option_detach);
>>> +
>>> +	/* no need to keep parsed option in memory */
>>> +	free_options();
>>> +
>>> +	DBG("Entering main loop");
>> 
>> Don't do this debug. It is not helpful. The main() is so short, no point in logging that.
> 
> I need at least one DBG call to be able to build, otherwise I got "undefined reference to `__start___debug'" error messages.
> So, this one seems ok to me.

fair enough for the beginning. Just remove it once you have more than one DBG in the source code and this is no longer needed.

Regards

Marcel

