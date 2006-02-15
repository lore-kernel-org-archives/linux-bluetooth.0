Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] scan mode timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602150918y7b8ce5a8xe0cad1c72aa53a5e@mail.gmail.com>
References: <e1effdeb0602150611s60763bb4u6362fd401cafd4ba@mail.gmail.com>
	 <1140013222.26072.80.camel@localhost>
	 <e1effdeb0602150831j55ae6d68p856bbc3761ecab00@mail.gmail.com>
	 <e1effdeb0602150918y7b8ce5a8xe0cad1c72aa53a5e@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1140025571.26072.94.camel@localhost>
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
Date: Wed, 15 Feb 2006 18:46:11 +0100

Hi Claudio,

> Here is patch to get/set the discoverable timeout.

the patch is applied to the CVS, but you should watch out for compiler
warnings. They help you to find some bugs ;)

dbus.c: In function =E2=80=98register_dbus_path=E2=80=99:
dbus.c:227: warning: assignment makes integer from pointer without a cast

> Currently, there isn't verification for a valid value range. Do you
> think that it is required?
> Should we define a minimum and a maximum value?

I don't know. We will see.

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
