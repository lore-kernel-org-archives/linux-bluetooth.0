Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <419543B3.8050601@xmission.com>
References: <418DB442.2050801@uen.org> <1099830449.6896.14.camel@pegasus>
	 <418E4E9C.8070100@xmission.com> <1099846462.6896.26.camel@pegasus>
	 <418E6FBF.3090409@xmission.com> <1099863224.6896.57.camel@pegasus>
	 <4191AB4B.8060701@xmission.com> <1100076431.25879.49.camel@pegasus>
	 <41925793.3050404@xmission.com> <1100113055.25879.73.camel@pegasus>
	 <419543B3.8050601@xmission.com>
Content-Type: text/plain
Message-Id: <1100306337.7349.29.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 13 Nov 2004 01:38:57 +0100

Hi Brad,

> My a2play.c (committed to cvs btw) opens the l2cap socket and exchanges 
> a couple of messages with the bt420n before I have reached something I 
> don't know how to interpret:
> 
> send avdtp_discover
> receive avdtp_discover accept, seid=1
> send avdt_get_capabilities for seid=1
> receive avdt_get_capabilities accept
> 
> The accept looks like this byte-for-byte:
> 
> 02 -> response accept
> 02 -> AVDT_GET_CAPABILITIES
> 01 -> category = media transport
> 00 -> length of service capabilities = 0
> 07 -> 7 'elements' follow
> 06 -> elements[0]
> 00 ->
> 00 ->
> ff ->
> ff ->
> 02 ->
> fa -> elements[6]
> 
> The avdt spec drops off sharply around page 86 when talking about what 
> comes after the service capabilities length. Any ideas of what to make 
> of the elements?

this should be the codec specific part. Look at A2DP for more details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
