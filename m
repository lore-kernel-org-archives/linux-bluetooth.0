Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120308235332.GA19895@x220.amr.corp.intel.com>
References: <1331236916-27596-1-git-send-email-anderson.lizardo@openbossa.org>
	<20120308235332.GA19895@x220.amr.corp.intel.com>
Date: Thu, 8 Mar 2012 22:32:07 -0400
Message-ID: <CAJdJm_MCdLnnmK1y7HrGSfWn2fUwxnMsovtrkCKYnsv-3nmnAw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] attrib: Fix memory leak on watcher exit
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Mar 8, 2012 at 7:53 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Thu, Mar 08, 2012, Anderson Lizardo wrote:
>> The "destroy" callback of g_dbus_add_disconnect_watch() is actually
>> never called, therefore the watcher data should be freed on
>> watcher_exit().
>
> Wouldn't it make more sense to fix GDBus so that the destroy callback
> *is* called than to work around it like this?

No other g_dbus_add_disconnect_watch() callers (besides this and LE
thermometer code which is also leaking and for which I have a patch as
well) use destroy callback. To me it seemed it was a known fact that
this parameter is not implemented in gdbus code, so that's why I went
this route.

If you prefer that I implement this destroy functionality, when do you
think it should be called? Only when the watch is removed?

Personally, I think it is better to simply remove this argument from
g_dbus_add_disconnect_watch(), if that is allowed. The caller usually
knows better when to "destroy" its own allocated resources (which may
explain why most users did not try to use this parameter?). What do
you think?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
