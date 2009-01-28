Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluez-utils 3.36 hcid crashes if wrong script files in
 network.conf
From: Marcel Holtmann <marcel@holtmann.org>
To: ranaldo@unina.it
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090123154854.4tvftpuo004w8g8s@webmail.unina.it>
References: <20090123154854.4tvftpuo004w8g8s@webmail.unina.it>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 06:51:04 +0100
Message-Id: <1233121864.18259.14.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I'm sorry if this is not the right place to post this as the wiki and  
> sourceforge project seems to be outdated.
> 
> On gentoo box a default network.conf file is installed from the  
> sources in /etc/bluetooth.
> The file itself has no problem but having avahi-autoipd as script,  
> while in other distributions this is unset, evidences a problem in the  
> function bnep_exec in network/common.c
> If the script does not exists or bnep_exec fails for other reasons,  
> hcid crashes for a very trivial mistake in the log error call.
> 
> Here a simple patch to fix this issue:
> 
> --- network/common.c    2009-01-23 15:52:12.000000000 +0100
> +++ network/common.c    2009-01-23 15:45:47.000000000 +0100
> @@ -235,7 +235,7 @@
> 
>          if (!g_spawn_async(NULL, (char **) argv, NULL, flags,  
> bnep_setup, NULL,
>                                  &pid, NULL)) {
> -               error("Unable to execute %s %s", *argv[0], *argv[1]);
> +               error("Unable to execute %s %s", argv[0], argv[1]);
>                  return -EINVAL;
>          }
> 
> I know that 3.36 should be the last in the 3.* series, however as  
> there are a lot of distros using it, and as the same problem could  
> affect 4.* series too i preferred to report this upstream.
> 
> The last thing, again about network.conf shipped file, the line:
> #Disable=Connection,Server
> should be
> #Disable=Connection;Server
> as who ignores the syntax of the conf file may not guess to use the  
> ";" instead of "," .

most of that code should be gone in 4.x and we are not using it anymore.
However instead of fixing the config file, we would have to fix the code
to accept , as a separator.

Regards

Marcel


