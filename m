Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SuSE 9.1 Pro and Epox Barton wireless desktop
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulrich Wisser <u.wisser@publisher.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1091737844.4179.46.camel@dorette.Entenhausen>
References: <1091568946.3759.18.camel@dorette.Entenhausen>
	 <1091569567.16182.36.camel@pegasus>
	 <1091648489.4237.2.camel@dorette.Entenhausen>
	 <1091661690.16182.74.camel@pegasus>
	 <1091737844.4179.46.camel@dorette.Entenhausen>
Content-Type: text/plain
Message-Id: <1091739998.20839.56.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 05 Aug 2004 23:06:38 +0200

Hi Ulrich,

> > It should be possible to compile only hid2hci. Download bluez-utils-2.9
> > and run configure. Make sure that the USB library is installed. Then
> > change to the tools directory and type "make hid2hci". Then you should
> > get the hid2hci binary that you can copy everywhere you like.
> 
> compiling did  work perfectly. Only when I tried to use the hid2hci the
> problems started:
> 
> Switching device 0a12:1000 to HCI mode failed. (Invalid or incomplete
> multibyte or wide character)

sometimes it works even if it reports an error. Check with hciconfig if
you see a Bluetooth device now.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
