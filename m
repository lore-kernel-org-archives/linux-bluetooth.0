Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, kernel-janitors@lists.osdl.org,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Max Krasnyansky <maxk@qualcomm.com>
In-Reply-To: <29495f1d050206141977a6b4fa@mail.gmail.com>
References: <20050202225855.GY2546@us.ibm.com>
	 <1107386189.11944.21.camel@pegasus> <20050203002502.GB2546@us.ibm.com>
	 <1107562301.6921.115.camel@pegasus>
	 <29495f1d050206141977a6b4fa@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1107729539.7327.26.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [KJ] Re: [PATCH 19/20] bluetooth/bluecard_cs: remove
 interruptible_sleep_on_timeout() usage
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 06 Feb 2005 23:38:59 +0100

Hi Nish,

> > I gave your patch a shot and the oops below happens on a 2.6.11-rc3
> > after plugging in the card. Without the patch it is working.
> 
> Sorry for the long delay without a response!
> 
> That looks like I may have missed some wake-up related issues. I'll
> check on it and get back to you soon.

take your time, because my 2.6.11 queue is closed. All of your other
changes are merged back mainline.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
