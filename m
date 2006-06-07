Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <F23ABFFDB8261D40A6F6D30EA014882501CE8E24@VS6.EXCHPROD.USA.NET>
References: <F23ABFFDB8261D40A6F6D30EA014882501CE8E24@VS6.EXCHPROD.USA.NET>
Date: Wed, 07 Jun 2006 09:13:29 +0200
Message-Id: <1149664409.22472.1.camel@localhost>
Mime-Version: 1.0
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

Hi Robert,

> In poking around in \bluez-utils-2.21\rfcomm\main.c, I noticed in
> several functions (including print_dev_list) there seems to be a malloc
> statement but no corresponding free.  Is this the recommended way to
> handle the rfcomm_dev_list_req structures?

this seems to be a bug, but I would prefer you actually check the latest
version from CVS instead of an old package and be more specific of the
cases you are talking about. Otherwise we can fix them.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
