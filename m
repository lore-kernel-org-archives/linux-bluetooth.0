Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Nitin Mahajan <nitinm76@yahoo.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <722489.76935.qm@web50107.mail.re2.yahoo.com>
References: <722489.76935.qm@web50107.mail.re2.yahoo.com>
Date: Wed, 29 Aug 2007 11:48:19 +0200
Message-Id: <1188380899.6109.35.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] BlueZ APIs
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

Hi Nitin,

> I am new to Bluetooth programming. I have read some documentation at BlueZ website and the WiKi regarding bluetooth programming. 
> What I understood is that the latest BlueZ stack has it's interface as the BlueZ D-BUS API, through which one can avail bluetooth services.
>  
> What I wanted to understand that Is there a way I can avail these services without using D-BUS/ D-BUS API and by directly accessing some BlueZ API. One way I know is Bluetooth socket programming, but cannot cover each and every bluetooth functionality. What are the additional set of APIs to access bluetooth services. Is there a place where these BlueZ APIS(other than BlueZ socket and D-BUS API) are documented?

use the L2CAP and RFCOMM sockets and the D-Bus API for BlueZ. Everything
else it not worth using.

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
