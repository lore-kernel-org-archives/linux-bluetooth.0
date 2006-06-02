Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060602115519.GA17462@esaurito.net>
References: <20060602115519.GA17462@esaurito.net>
Date: Fri, 02 Jun 2006 17:09:11 +0200
Message-Id: <1149260951.23555.7.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] [PATCH] rfcomm 'anycommand' bug
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

Hi Filippo,

> as reported in http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=229167 rfcomm
> silently exits (or better, does a print_dev_list()) if an unknown command
> without parameters is passed. attached there is a patch (of the 'works-here'
> type) which should solve the problem.

this patch is totally messed up. Unless someone fixes the coding style,
I am not even looking at it.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
