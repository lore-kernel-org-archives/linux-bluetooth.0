Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: cross-compilation howto  (was "Re: [Bluez-users] Trying to
	compile for axis but Bluetooth library not found")
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1107542281.22569.42.camel@justakiss>
References: <41FE85A0.2040709@ieee.org>
	 <1107204712.15769.70.camel@justakiss>  <41FF54DA.40801@ul.ie>
	 <1107254209.9652.0.camel@pegasus>  <41FF8FE0.8010204@gmx.ch>
	 <1107268938.9652.34.camel@pegasus> <41FF9C42.1090604@gmx.ch>
	 <41FF9EA2.8090605@gmx.ch> <1107273565.8819.38.camel@justakiss>
	 <4203B1BB.1070006@gmx.ch>  <1107541143.22567.29.camel@justakiss>
	 <1107541330.6921.81.camel@pegasus>  <1107542281.22569.42.camel@justakiss>
Content-Type: text/plain
Message-Id: <1107542589.6921.84.camel@pegasus>
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
Date: Fri, 04 Feb 2005 19:43:09 +0100

Hi Erwin,

> finding a quick workaround usually consumes much less time than fixing
> the configure scripts. Once it's working, most times I'm not in the mood
> to look how the autoconf stuff can be fixed. The bluez configure scripts
> are quite nice compared to other packages, but there are still some
> small problems where I didn't find a nice solution. For example, is it
> possible to specify only a subset of the applications to be installed
> for the target system, by specifying that in enviroment variables?

what do you wanna select or better de-select. Lets discuss this what is
needed by default and what not and we can add such an option very easy.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
