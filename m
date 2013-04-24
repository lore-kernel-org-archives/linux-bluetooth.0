Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v3 7/8] core: Expose the last bonding attempt timeout on retry
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130424113718.GD15231@x220.ger.corp.intel.com>
Date: Wed, 24 Apr 2013 07:03:19 -0700
Cc: Alex Deymo <deymo@chromium.org>, linux-bluetooth@vger.kernel.org,
	keybuk@chromium.org
Message-Id: <FF9BC48A-F53C-41F6-87B9-56139DA21FB4@holtmann.org>
References: <1366740247-368-1-git-send-email-deymo@chromium.org> <1366740247-368-8-git-send-email-deymo@chromium.org> <20130424113718.GD15231@x220.ger.corp.intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> +	gint64 attempt_start_time_us;
>> +	gint64 last_attempt_duration_us;
>> };
>> 
>> typedef enum {
>> @@ -1420,12 +1422,52 @@ static struct bonding_req *bonding_request_new(DBusMessage *msg,
>> 
>> 	bonding->capability = io_cap;
>> 
>> +	/* Marks the bonding start time for the first attempt on request
>> +	 * construction. The following attempts will be updated on
>> +	 * device_bonding_retry. */
>> +	bonding->attempt_start_time_us = g_get_monotonic_time();
> 
> Since we're in the long run aiming to remove the GLib dependency, I'm
> not so sure it's the best idea to add yet another dependency to a GLib
> feature. Would it be that much more complicated to just use libc
> directly for this? OTOH, if Marcel doesn't mind this new GLib API
> dependency I'm not gonna object to this patch.

or just use clock_gettime which should be the same anyway. We do rely on a recent kernel and glibc anyway.

Regards

Marcel

