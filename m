Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42040323.20103@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: cross-compilation howto  (was "Re: [Bluez-users] Trying to	compile
 for axis but Bluetooth library not found")
References: <41FE85A0.2040709@ieee.org>	 <1107204712.15769.70.camel@justakiss>  <41FF54DA.40801@ul.ie>	 <1107254209.9652.0.camel@pegasus>  <41FF8FE0.8010204@gmx.ch>	 <1107268938.9652.34.camel@pegasus> <41FF9C42.1090604@gmx.ch>	 <41FF9EA2.8090605@gmx.ch> <1107273565.8819.38.camel@justakiss>	 <4203B1BB.1070006@gmx.ch> <1107538710.6921.58.camel@pegasus>
In-Reply-To: <1107538710.6921.58.camel@pegasus>
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
Date: Sat, 05 Feb 2005 00:20:03 +0100

 > please start writing a small howto about
 > compiling/cross-compiling the BlueZ

suggestion: set up a wiki (or something similar to it)
then i'll invest a couple of hours to fill in my knowledge.

then you can add/change things and other people can as well...

regards
Marco


Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>I learned a lot of configure and make flags I didn't knew before.
>>So, that's the state:
>>
>>For crosscompiling, it's enought to:
>>./configure --build=[buildArchitecture] --host=[targetArchitecture]
>>
>>The cross-compiler has to be in path.
>>That's it. Everything else is like usual compiling.
>>
>>I don't think this is worth a howto, do you?
>>Actually a bluetooth compilation howto with a little crosscompiling 
>>subsection that hints to the --build and --host switches should be more 
>>than enough.
> 
> 
> please start writing a small howto about compiling/cross-compiling the
> BlueZ. I really want something like that on the webpage. This would help
> people to get a start into it.
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
