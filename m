Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <8de6c3e20708220924g3a8db7a5paa153e99b5d829ea@mail.gmail.com>
References: <8de6c3e20708220924g3a8db7a5paa153e99b5d829ea@mail.gmail.com>
Date: Fri, 24 Aug 2007 14:16:20 +0200
Message-Id: <1187957780.15402.152.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hci_read_remote_name() simultaneously on	multiple
	dongles question
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

Hi Jeffrey,

> I apologize for yet another e-mail about this, but as the last one was
> too wordy I have narrowed down the problem to a much simpler issue.
> 
> As my changes to hci.c didn't do anything towards resolving the name
> mixup, I was wondering how the hci_read_remote_name() ensures that the
> packet that comes in isn't a packet response to another
> hci_read_remote_name() request.  It seems that everytime that I do
> multiple hci_read_remote_name() requests at the same time, that the
> name request replies indiscriminately choose whichever dongle to
> enter, and at the hci.c level, there is no way to verify the btaddr
> that that name request came from, which is rather frustrating.
> 
> As some background for what "fixes" that I tried to do to hci.c were,
> I simply compared the bdaddr const variable with rn.bdaddr near the
> end of hci_read_remote_name_with_clock_offset() to see if it didn't
> match, and to reject it if so and return -1, and to allow the name to
> be copied to the name pointer otherwise.
> 
> If anyone out there has experienced similar problems with multiple
> dongles and hci_read_remote_name(), any help would be appreciated if
> any solutions to this have been found. 

feel free to post a patch, but honestly this is broken for quite some
time now. The kernel and the new D-Bus based API have no problems with
it and that should be the main way to retrieve remote names. So I am not
really keen to fix this since direct HCI access for userspace apps was a
design mistake.

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
