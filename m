Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4203BF92.6050200@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: cross-compilation howto  (was "Re: [Bluez-users] Trying to	compile
 for axis but Bluetooth library not found")
References: <41FE85A0.2040709@ieee.org>	 <1107204712.15769.70.camel@justakiss>  <41FF54DA.40801@ul.ie>	 <1107254209.9652.0.camel@pegasus>  <41FF8FE0.8010204@gmx.ch>	 <1107268938.9652.34.camel@pegasus> <41FF9C42.1090604@gmx.ch>	 <41FF9EA2.8090605@gmx.ch> <1107273565.8819.38.camel@justakiss>	 <4203B1BB.1070006@gmx.ch>  <1107541143.22567.29.camel@justakiss> <1107541330.6921.81.camel@pegasus>
In-Reply-To: <1107541330.6921.81.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 04 Feb 2005 19:31:46 +0100

 > if we have such problems with that, then lets fix them.

do we? I don't think so...
At least I didn't had...
Wow, that was a quick fix :-)


regards
Marco


Marcel Holtmann wrote:
> Hi Erwin,
> 
> 
>>you are almost right. In practice, almost every configure script has
>>some problems with cross-compiling. For example, configure scripts that
>>do runtime tests for the target system will obviously fail. You can work
>>around that by supplying a hand-crafted config.guess that substitutes
>>missing values. In other cases, you have to play with configure options
>>and environment variables.
> 
> 
> if we have such problems with that, then lets fix them.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
