Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] GBlueZConf Prototype
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602060950y29834100ge178776b1dbdf665@mail.gmail.com>
References: <e1effdeb0602060950y29834100ge178776b1dbdf665@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1139365565.31545.16.camel@localhost>
Mime-Version: 1.0
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
Date: Wed, 08 Feb 2006 03:26:05 +0100

Hi Claudio,

> Here is a new GBlueZConf version.
> http://www.cin.ufpe.br/~ckt/gbluezconf/gbluezconf-00.08.tar.gz

some comments from me after playing with it a little bit.

The integration of the notifications is really great. The insert and
removal bubbles for an adapter are cool. However I prefer not to show
the the path. We should choose the address or name. Maybe we need to
cache some of these information for the removal event. I also think that
the timeout for disappearing is quite long.

For the PIN code input we might wanna open the PIN input dialog anyway
if someone hits the bubble. Adding a reject option to the bubble might
also be a good idea. It should however not disappear until the user
clicked it or the authentication timed out. Please also display the name
and not the address if available.

The icon stays the same even when we run an inquiry or when a connection
is established. Is this a missing feature or a bug?

Is it possible to integrate the applet to appear in the "Add to panel"
dialog.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
