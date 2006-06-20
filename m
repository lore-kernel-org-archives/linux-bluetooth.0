Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <003c01c6943d$9932ff90$7f0cc70a@dlh.st.com>
References: <003c01c6943d$9932ff90$7f0cc70a@dlh.st.com>
Date: Tue, 20 Jun 2006 10:02:42 +0200
Message-Id: <1150790562.18381.8.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] dbus-glib problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Sumeet,

> I think the problem is with the kernel version. I am using 2.4 while the
> package bluez-utils-3.1 seems to work with 2.6. Is this true?
> 
> If yes.. then is there any way I can make bluez latest package work with
> Linux kernelversion 2.4.

no. The kernel version has nothing to do with it. This is a wrong
pkg-config file from your D-Bus package.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
