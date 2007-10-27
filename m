Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1193422039.6117.3.camel@egore912.egore.lan>
References: <20071023130738.308690@gmx.net> <1193352738.6184.297.camel@violet>
	<1193422039.6117.3.camel@egore912.egore.lan>
Date: Sat, 27 Oct 2007 12:31:23 +0200
Message-Id: <1193481083.4416.18.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] randomizer for passkey-agent
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

Hi Christoph,

> the use case is quite simple. Imagin a headless system that is doing
> bonding via a deamon. The idea is to show a random passkey on a display
> and enable the mobile user to authenitcate using this passkey. I know
> that the passkey-agent is more a "proof of concept" version, but if it
> would generate random keys and if there was a dbus interface to the last
> generated key it would be pretty helpful. At least for me :-)

that is the whole idea, why we have the full blown passkey interface.
You can do whatever you want with it. However since that system will
interact with a specific display (which I know nothing about), I don't
even know where to put this agent. It is flexible to cover these use
cases, but they are so specific that this kind of code makes no sense in
the example passkey agent.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
