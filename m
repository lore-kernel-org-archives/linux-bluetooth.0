Return-Path: <paulo@mail.wollny.com.br>
Date: Mon, 10 May 2004 12:17:28 -0300
Message-Id: <200405101517.i4AFHQK12383@home.iis.com.br>
From: <paulo@mail.wollny.com.br>
To: "=?ISO-8859-1?Q?=4d=61=72=63=65=6c=20=48=6f=6c=74=6d=61=6e=6e?="<marcel@holtmann.org>,
   "=?ISO-8859-1?Q?=20=42=6c=75=65=5a=20=4d=61=69=6c=69=6e=67=20=4c=69=73=74?="<bluez-users@lists.sourceforge.net>
Reply-To: <paulo@mail.wollny.com.br>
Errors-To: <paulo@mail.wollny.com.br>
Subject: Re: [Bluez-users] Problem with Suse 9.0 and BlueZ
Content-Type: text/plain;
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

Where do i find hcidump? I could not find it installed....

Regards,

Paulo Wollny


-- Original Message --
From: Marcel Holtmann <marcel@holtmann.org>
To: paulo@mail.wollny.com.br
Send: 11:58 AM
Subject: Re: [Bluez-users] Problem with Suse 9.0 and BlueZ

Hi Paulo,

> i'm trying to use BlueZ with Suse 9.0 and am finding following
problems:
> 
> 1 - /dev/rfcomm0 could not be found.  I have tryed mknod
/dev/rfcomm0 c 216 0. Is this right?

this is correct, but the SuSE 9.0 should create these device nodes.

> 2 - Starting the daemons, it get the following message on
/var/log/messages
> 
>  May 10 11:35:07 hirscheberg hcid[15820]: HCI daemon ver 2.3
started
> May 10 11:35:07 hirscheberg hcid[15820]: Starting security manager
0
> May 10 11:35:07 hirscheberg sdpd[15825]: SDPd ver 1.2 started
> May 10 11:35:18 hirscheberg hcid[15820]: pin_code_request
(sba=72:8C:01:72:02:00, dba=E2:59:22:E3:01:00)
> May 10 11:35:18 hirscheberg kernel: Warning: null TTY for (d8:00)
in tty_fasync
> May 10 11:37:32 hirscheberg hcid[15820]: pin_code_request
(sba=72:8C:01:72:02:00, dba=E2:59:22:E3:01:00)
> May 10 11:37:32 hirscheberg kernel: Warning: null TTY for (d8:00)
in tty_fasync

I don't know where the "null TTY" came from.

> 3 - When trying to contact the phone (a Siemens S55), after havin
/etc/bluetooth/pin PIN:1234 with echo "ATZ" > /dev/rfcomm0
i can not connect to th phone.

Show us "hcidump -x" as root to see what happens.

Regards

Marcel
