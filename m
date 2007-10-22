Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000b01c81484$989af5b0$0200a8c0@jester>
References: <6656b6540710182155m29cd7441l6dcb9a7d722d5417@mail.gmail.com>
	<47189691.2000504@cilnu.com>
	<6656b6540710210008v5cc459dv6692a5e8ff888187@mail.gmail.com>
	<471B5E66.1030601@cilnu.com>  <000b01c81484$989af5b0$0200a8c0@jester>
Date: Mon, 22 Oct 2007 11:22:26 +0200
Message-Id: <1193044946.6184.157.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Blocking connect(AF_BLUETOOTH, SOCK_STREAM,
	BTPROTO_RFCOMM) => EINPROGRESS
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Oli,

> I am trying to perform RFCOMM connection to a mobile phone thanks to a 
> blocking "connect(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)" (Blocking is 
> the only way for me to get a "Connection Refused" return status !), and if 
> the phone is still asking for the authorization when the connect times out, 
> the connect and leaves with a EINPROGRESS status.

I have no idea what you are trying to achieve here. Anyway, the RFCOMM
socket behaves like every other TCP socket. So in the non-blocking case
apply the same stuff you use when programming TCP.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
