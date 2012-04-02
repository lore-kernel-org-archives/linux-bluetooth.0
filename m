Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Apr 2012 17:55:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v7 2/6] proximity: reporter: save global D-Bus connection
Message-ID: <20120402145518.GC31518@x220.P-661HNU-F1>
References: <1333365444-9029-1-git-send-email-arik@wizery.com>
 <1333365444-9029-2-git-send-email-arik@wizery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333365444-9029-2-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arik,

On Mon, Apr 02, 2012, Arik Nemtsov wrote:
> --- a/proximity/reporter.c
> +++ b/proximity/reporter.c
> @@ -40,6 +40,7 @@
>  #include "attrib-server.h"
>  #include "reporter.h"
>  
> +static DBusConnection *connection;
>  #define IMMEDIATE_ALERT_SVC_UUID	0x1802
>  #define LINK_LOSS_SVC_UUID		0x1803
>  #define TX_POWER_SVC_UUID		0x1804

Please move the new static variable after the defines and the enum.
Thats's usually where we place them (right before the actual functions
start).

Johan
