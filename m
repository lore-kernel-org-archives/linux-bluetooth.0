Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1186444253.10966.14.camel@sky.nicolast.be>
References: <1186444253.10966.14.camel@sky.nicolast.be>
Date: Tue, 07 Aug 2007 09:41:12 +0200
Message-Id: <1186472472.20129.41.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [bluez-gnome] Authorization agent
	address-based	whitelisting
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

Hi Nicolas,

> I'm working on bluetooth mouse handling in the GNOME desktop recently.
> Now I finally got my mouse working (took a while), I could get some
> coding done. As part of this I thought it could be useful to get around
> the passkey agent authorization question for some devices (ie mouses),
> without enabling auto_authorize in the bluetooth-applet configuration.
> 
> Attached you can find a patch to auto-grant authorization request for
> some devices based on their BT address. The addresses are stored in
> gconf as a simple list of strings.
> 
> The preferences editor has not been altered (yet) to manipulate this
> list.

did you ever tried bluez-gnome-0.13. You can know set the "trusted" flag
from preferences window and also during the authorization dialog.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
