Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] adding a sdp service with a 128bit uuid
From: Taneli =?ISO-8859-1?Q?V=E4h=E4kangas?= <taneli.vahakangas@netsonic.fi>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1110029911.8168.5.camel@pegasus>
References: <42291076.5040109@gmx.ch> <1110021688.8058.108.camel@pegasus>
	 <4229B30E.8080803@gmx.ch>  <1110029911.8168.5.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-sh7Jltiuqace2zUt0M9r"
Message-Id: <1110096690.11503.2.camel@newer.loc>
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
Date: Sun, 06 Mar 2005 10:11:30 +0200


--=-sh7Jltiuqace2zUt0M9r
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-03-05 at 14:38 +0100, Marcel Holtmann wrote:
> Hi Marco,
> 
> > >>how to browse the local sdp services?
> > >>[sdptool browse dev] seems to be only for remote devices. I now always did 
> > >>it from another device to see the local seervices. how to [sdptool browse 
> > >>localhost]?
> > > 
> > > 
> > > sdptool browse local
> > 
> > nice :-)
> > maybe something that should/could be mentioned in the manpage or in --help
> 
> feel free to send in a patch.

What do you think about this? It adds the "sdptool browse local" to the
examples.

	Taneli


--=-sh7Jltiuqace2zUt0M9r
Content-Disposition: attachment; filename=sdptool.1-patch
Content-Type: text/x-patch; name=sdptool.1-patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Nabpur bluez-utils-2.15/tools/sdptool.1 bluez-utils-2.15b/tools/sdptool.1
--- bluez-utils-2.15/tools/sdptool.1	2004-03-31 23:14:52.000000000 +0300
+++ bluez-utils-2.15b/tools/sdptool.1	2005-03-06 10:04:44.000000000 +0200
@@ -99,6 +99,8 @@ Displays help on using sdptool. 
 .PP 
 sdptool browse 00:80:98:24:15:6D 
 .PP 
+sdptool browse local 
+.PP 
 sdptool add DUN 
 .PP 
 sdptool del LAN 

--=-sh7Jltiuqace2zUt0M9r--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
