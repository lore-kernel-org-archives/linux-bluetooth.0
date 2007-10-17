Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d5d240eb0710170654j2a3e14b4g9213136cac25628@mail.gmail.com>
References: <d5d240eb0710170654j2a3e14b4g9213136cac25628@mail.gmail.com>
Date: Wed, 17 Oct 2007 16:19:10 +0200
Message-Id: <1192630750.6184.15.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Error in using DBus API'S
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

Hi Rohit,

> I want to accomplish the following task.
> 1 To find sdp records of the discovered devices using the dbus APIs
> Here I am able to find out the near by bluetooth devices using the
> Dbus APIs and storing there addresses in an array.Now I want to
> extract  the  SDP records of the discovered devices.
> 
> when I pass this array to function  
> /*function to retreive the SDP records*/
> 
> get_remote_service_channel(object,arr,uuid);
> 
> the code compiles ,find near by bluetooth devices but cannot retrive
> the sdp records and the code crashesand shows the following
> messages.Even I Have hardcoded address in
> get_remote_service_channel.Still receving
> the warnings

you might wanna better show us that code. Otherwise we can't tell you
anything.

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
