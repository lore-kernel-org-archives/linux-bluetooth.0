Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Add support for command line arguments on hid2hci
 tool
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4A0DC533.8080900@dell.com>
References: <4A0DC533.8080900@dell.com>
Content-Type: text/plain
Date: Fri, 15 May 2009 13:11:18 -0700
Message-Id: <1242418278.3446.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> This means that hid2hci won't have to run
>  on every bootup for every machine with bluetooth installed.  It instead
> gets ran on demand if a
>  product that is called out from the dbus rules file contains the
> correct attributes and/or VID/PID.
> 
>  It also makes it easier for users to manually test new VID/PID
> combinations that may or may not
>  be yet supported by bluez.
> ---
>  scripts/Makefile.am       |   12 ++-
>  scripts/bluetooth.default |    3 -
>  scripts/bluetooth.init    |    7 --
>  scripts/hid2hci.rules     |   38 ++++++++++
>  tools/hid2hci.c           |  179
> +++++++++++++++++++-------------------------
>  5 files changed, 124 insertions(+), 115 deletions(-)
>  create mode 100644 scripts/hid2hci.rules
> 
> Attaching patch as Exchange would mangle otherwise.

please restrict the commit message to 70-72 chars per line.

And please do the following changes:

s/radiomode/mode/ since it is not about the radio part here.

s/hidproxy/csr/ if you wanna expose this then call it what it is.

And go over the coding style once more since there are some cases where
it breaks.

Also please split Makefile/rules changes from the actual code changes. I
want two patches here. One that fixes the code and another one that
takes care of the udev integration.

Other than that, looks pretty good.

Regards

Marcel


