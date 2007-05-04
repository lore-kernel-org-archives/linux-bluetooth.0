Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <be976db60705031450u6c22eebfj50ffe8d91d8b6f88@mail.gmail.com>
References: <be976db60705031450u6c22eebfj50ffe8d91d8b6f88@mail.gmail.com>
Date: Fri, 04 May 2007 08:29:35 +0200
Message-Id: <1178260175.25425.14.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hciconfig delkey question
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

Hi Mark,

> I am trying to delete a linkkey by way of 'hciconfig delkey <btaddr>'
> where <btaddr> is the bluetooth address linkkey that I want to remove.
> I can see that there is a directory under /var/lib/bluetooth in the
> same name as <btaddr>.   I execute the command and hciconfig returns
> the same lines as if I run it with no argument (returning info about
> my only hci interface, hci0).  And I can still see <btaddr> directory
> under /var/lib/bluetooth. 
> 
> Am I missing something about how this command should behave?  I was
> expecting that after the command, the directory
> under /var/lib/bluetooth/<btaddr> would be removed.

the delkey option deletes a key from the Bluetooth chip and not the host
filesystem. Use the D-Bus API method RemoveBonding() for that.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
