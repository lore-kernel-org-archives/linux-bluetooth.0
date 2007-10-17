Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <f8e53fb0710170033u2b451d7ft34cad156e0828a49@mail.gmail.com>
References: <f8e53fb0710170033u2b451d7ft34cad156e0828a49@mail.gmail.com>
Date: Wed, 17 Oct 2007 16:20:25 +0200
Message-Id: <1192630825.6184.17.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] concurrent calls to RFCOMM connect()
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

Hi Andrea,

> I'm planning to write an application handling communication with four
> bluetooth devices, each with its own BT address. I was thinking to
> design it with four parallel threads and use rfcomm sockets API.
> 
> The common thread function will start connecting to the appropriate
> remote device by allocating a socket and calling connect(). Do I have
> to consider any particular syncronization issue between the threads?
> Is this approach reasonable or not?
> 
> I found posts in the archives about connect() returning EBUSY. This
> has to be an   error code specific to RFCOMM sockets. When is it
> supposed to be raised? Is it something I have to take into account in
> my scenario?

depending on how which kernel you use, this might work. Older kernel
didn't queue the ACL link requests and so you saw problems.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
