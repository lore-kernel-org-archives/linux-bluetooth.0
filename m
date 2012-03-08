Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Mar 2012 17:53:32 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] attrib: Fix memory leak on watcher exit
Message-ID: <20120308235332.GA19895@x220.amr.corp.intel.com>
References: <1331236916-27596-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331236916-27596-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Mar 08, 2012, Anderson Lizardo wrote:
> The "destroy" callback of g_dbus_add_disconnect_watch() is actually
> never called, therefore the watcher data should be freed on
> watcher_exit().

Wouldn't it make more sense to fix GDBus so that the destroy callback
*is* called than to work around it like this?

Johan
