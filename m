Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <79be12f70708171422h6321e538hd92ea920068ea237@mail.gmail.com>
References: <79be12f70708171418i44648442g45dbff593b84063@mail.gmail.com>
	<79be12f70708171422h6321e538hd92ea920068ea237@mail.gmail.com>
Date: Sat, 18 Aug 2007 14:50:12 +0200
Message-Id: <1187441413.11068.15.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Fwd: hcitool scan problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi John,

> I am having a problem with the hcitool scan command (v3.13) using the
> 2.6.21 kernel, as well as 2.6.23.  Here is my output:
>  
> Scanning ...
>         3A:5E:11:6B:00:00       n/a
>         38:C1:5E:35:3F:D9       n/a
>         C5:2B:F4:F7:3C:6A       n/a
>         3A:75:F9:65:1A:02       n/a.
>         38:C1:60:35:1A:F6       n/a
>  
> All of the addresses are partially junk for some reason - for example
> 38:C1:60:35:1A:F6 should be 00:16:38:C1:60:35, and no name are
> returned.  This seems to effect other tools as well, for example if I
> do try to do a hidd search I can't detect anything even if there are
> discoverable hid devices around - I'm guessing because it doesn't have
> valid addresses.  Previously I had been using the 2.6.10 kernel and
> everything worked fine.

run "hcidump -X -V" and compare the output.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
