Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 6 Jun 2006 18:35:19 -0600
Message-ID: <F23ABFFDB8261D40A6F6D30EA014882501CE8E24@VS6.EXCHPROD.USA.NET>
From: "Robert Wlaschin" <robertw@healthhero.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm (utils)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

In poking around in \bluez-utils-2.21\rfcomm\main.c, I noticed in
several functions (including print_dev_list) there seems to be a malloc
statement but no corresponding free.  Is this the recommended way to
handle the rfcomm_dev_list_req structures?

Thanks,
~Robert




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
