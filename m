Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] cross compiling bluez-utils
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <847649876@web.de>
References: <847649876@web.de>
Content-Type: text/plain
Message-Id: <1107521335.6921.15.camel@pegasus>
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
Date: Fri, 04 Feb 2005 13:48:55 +0100

Hi Martin,

> > > does it make sense to change the line "sysconfdir='${prefix}/etc'" into "sysconfdir='${exec_prefix}/etc'" in the configure file? I found that useful while compiling the utils for an ARM platform. The /etc will be generated in the right place then.
> > 
> > explain what the differences are. However the acinclude.m4 is a little
> > bit more complex and there are other corner cases.
> 
> just curious - I have no real idea what I am doing... If I compile it the way it is the /etc/bluetooth/ files will be generated in the cross compiler folders. It looks a little lost there. If I change that to the exec_prefix area, it will be directly put into my ramdisk where the /sbin files and all the rest go.

I don't have your setup, so you must be a little bit more specific and
talk in absolute folders of the local system.

However you can always use --sysconfdir to overwrite the defaults.

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
