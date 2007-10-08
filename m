Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3fb4ac6c0710080418j3868f85k63e4b3d3671ae244@mail.gmail.com>
References: <3fb4ac6c0710080418j3868f85k63e4b3d3671ae244@mail.gmail.com>
Date: Mon, 08 Oct 2007 18:53:10 +0200
Message-Id: <1191862390.12212.8.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] DBUS Bluez Api : send and recieve functionality
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

Hi,

> I tried programming a small server which will take                 
> the text input and show it on the screen.It was a simple 
> client server implementation over bluetooth using
> rfcomm.Basic implementation being adding ,advertising 
> a service and then on getting connected by client sending
> the key inputs to the user screen.
> 
> I am now trying to do the same using dbus api in bluez.
> 
> Have gone through the documentation and found
> some api for adding a service record and for
> starting a service. But i could'nt find any info
> on how the sending and receiving part of the data
> is to be done .

sending of data should still be done through the socket interfaces.

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
