Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: mats.andersson@blue2net.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1188486698.4817.60.camel@Blue2net-mats.bellman.mea>
References: <1188486698.4817.60.camel@Blue2net-mats.bellman.mea>
Date: Thu, 30 Aug 2007 17:17:35 +0200
Message-Id: <1188487055.13373.31.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Byte order for baddr-to-string
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

Hi Mats,

> I observe that the bluez-libs functions 
> 
>   int ba2str(const bdaddr_t *, char *);
> 
>   char * batostr(const bdaddr_t *);
> 
> deliver strings with different byte order. Is it just
> me making a slip of mind regarding netorder or endianness,
> or is there a deeper reason that I fail to comprehend?
> I observe the same thing on i386 architecture as well
> as on cris architecture.

it is part of the specification. The user visible presentation is
different from the wire one.

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
