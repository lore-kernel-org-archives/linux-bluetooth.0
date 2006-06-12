Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6db221bd0606110314w11c2ea96qab02c13dc87963f9@mail.gmail.com>
References: <6db221bd0606110314w11c2ea96qab02c13dc87963f9@mail.gmail.com>
Date: Mon, 12 Jun 2006 08:14:36 +0200
Message-Id: <1150092876.2589.2.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] configure bluetooth device in parked or hold mode
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

Hi Jose,

> I need to configure parked or hold mode in a bluetooth device. Does
> anyone knows how to do it?

the support for park state and hold mode is activated by default if the
local adapter supports it. BlueZ at the moment never enforces park state
or hold mode. Both power mode are not really useful. If you wanna save
power you should use sniff mode. The latest -mh patch contains support
for the automatic sniff mode feature.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
