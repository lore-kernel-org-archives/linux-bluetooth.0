Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Heiko Wundram (Beenic)" <wundram@beenic.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 7 Aug 2007 14:30:28 +0200
References: <mailman.159099.1186455104.21973.bluez-devel@lists.sourceforge.net>
	<46B85566.1000100@ucd.ie>
In-Reply-To: <46B85566.1000100@ucd.ie>
MIME-Version: 1.0
Message-Id: <200708071430.29143.wundram@beenic.net>
Subject: Re: [Bluez-devel] rfcomm connection using multiple dongles
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

Am Dienstag 07 August 2007 13:20:06 schrieb Stephen Keegan:
> while ((r = connect(m_CommHandle, (struct sockaddr *)&raddr,
> sizeof(raddr))) == -1)
>
> I think that I may need to specify which dongle (hc0 or hci1) should be
> used in this command.
>
> If anybody could advise on a solution, I would be very grateful.

bind() the RFCOMM socket to the local BT-address of the dongle you want to use 
before connecting it.

man 2 bind

is your friend.

-- 
Heiko Wundram
Product & Application Development

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
