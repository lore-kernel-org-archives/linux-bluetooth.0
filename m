Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: cross-compilation howto  (was "Re: [Bluez-users] Trying to
	compile for axis but Bluetooth library not found")
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <4203B1BB.1070006@gmx.ch>
References: <41FE85A0.2040709@ieee.org>
	 <1107204712.15769.70.camel@justakiss>  <41FF54DA.40801@ul.ie>
	 <1107254209.9652.0.camel@pegasus>  <41FF8FE0.8010204@gmx.ch>
	 <1107268938.9652.34.camel@pegasus> <41FF9C42.1090604@gmx.ch>
	 <41FF9EA2.8090605@gmx.ch> <1107273565.8819.38.camel@justakiss>
	 <4203B1BB.1070006@gmx.ch>
Content-Type: text/plain
Message-Id: <1107541143.22567.29.camel@justakiss>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 04 Feb 2005 19:19:03 +0100

Am Fre, den 04.02.2005 schrieb Marco Trudel um 18:32:
> Hello Marcel
> 
> I learned a lot of configure and make flags I didn't knew before.
> So, that's the state:
> 
> For crosscompiling, it's enought to:
> ./configure --build=[buildArchitecture] --host=[targetArchitecture]
> 
> The cross-compiler has to be in path.
> That's it. Everything else is like usual compiling.
> 
Hi,
you are almost right. In practice, almost every configure script has
some problems with cross-compiling. For example, configure scripts that
do runtime tests for the target system will obviously fail. You can work
around that by supplying a hand-crafted config.guess that substitutes
missing values. In other cases, you have to play with configure options
and environment variables.

> I don't think this is worth a howto, do you?
> Actually a bluetooth compilation howto with a little crosscompiling 
> subsection that hints to the --build and --host switches should be more 
> than enough.
It's definitely worth to have a howto, because if you search the web or
mailinglists, there are a lot of misleading or wrong hints regarding
this topic. I don't have time right now to write a howto, but I think
that the recent postings are already some help to get started for
somebody who is in trouble with cross-compiling.

> 
> Erwin: Is only using --host proper?
> It works but I get a warning (I don't like warnings. So I always try to do 
> things right.)
> 
I have cross-compiled a lot of packages, and --host was always
sufficient (I tried to use the possible minimum of options) . The
warning says:

  "WARNING: If you wanted to set the --build type, don't use --host."

that applies to something that you don't want to do anyway in our case.

Regards,
Erwin




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
