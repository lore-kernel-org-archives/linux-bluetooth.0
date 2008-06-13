Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100806131229l79022c48w65489072f2e6ca36@mail.gmail.com>
Date: Fri, 13 Jun 2008 16:29:47 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <eba8281a0806111502j7caebdeav83e3fc038b0c943f@mail.gmail.com>
MIME-Version: 1.0
References: <eba8281a0806111502j7caebdeav83e3fc038b0c943f@mail.gmail.com>
Subject: Re: [Bluez-devel] Listen a already open socket by the OS
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I supposed you are the OpenMoko student in charge of remote control.
You better join #bluez @ freenode to stay tunned about bluetooth and
BlueZ, now about HID channels, we already are listen them in hcid, so
you don't need to worry if you are running hcid for the server part.
The tricky part is the client side, when the device act as a
mouse/keyboard, Im afraid there is no library to assist you with HID
protocol and I think you cannot connect in such psm without being root
either. If Im correct about those points then I think it is better to
code the missing HID support inside bluez-utils.

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
