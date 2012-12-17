Return-Path: <cyrus@holtmann.org>
Message-ID: <50CF030B.9040004@linux.intel.com>
Date: Mon, 17 Dec 2012 13:33:31 +0200
From: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] gdbus: Fix crash error when calling g_dbus_remove_all_watches
References: <1345802959-11774-1-git-send-email-tomasz.bursztyka@linux.intel.com> <20121128122318.GA30710@x220.ger.corp.intel.com>
In-Reply-To: <20121128122318.GA30710@x220.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Johan,

this bug never hasn't hit anyone since the function 
g_dbus_remove_all_watches() is not used anywhere (but in my project)

I will resend the patch with the backtrace.

Tomasz
> It seems this patch never got applied. Is it so that no-one else has
> seen the issue. Could someone (through basic static analysis) confirm if
> the patch is correct? It'd be nice if we could also have a back trace of
> the crash in the commit message.
>
> Johan
>

