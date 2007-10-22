Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY102-W11B9C20DCF53865C058207F09A0@phx.gbl>
References: <BAY102-W11B9C20DCF53865C058207F09A0@phx.gbl>
Date: Mon, 22 Oct 2007 12:42:35 +0200
Message-Id: <1193049756.6184.167.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] DiscoveryStarted / DiscoveryComplete Signal
	Not	Sent
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

Hi Robert,

> I'm using the D-Bus API for an application and have recently started
> playing around with the periodic discovery process, however it seems
> that the DiscoveryStrarted and DiscoveryComplete signals are not sent
> at the beginning and end of each scan 'period'. Is this usual
> behaviour? I notice in the API documentation there are two functions
> for start and end of a period scan, however these don't seem to run at
> the start and end of every period, only the entire scanning process,
> is that correct?

it is designed to be this way. The periodic inquiry is different from
the normal inquiry in its semantics.

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
