Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41957BC1.507@xmission.com>
References: <418DB442.2050801@uen.org> <1099830449.6896.14.camel@pegasus>
	 <418E4E9C.8070100@xmission.com> <1099846462.6896.26.camel@pegasus>
	 <418E6FBF.3090409@xmission.com> <1099863224.6896.57.camel@pegasus>
	 <4191AB4B.8060701@xmission.com> <1100076431.25879.49.camel@pegasus>
	 <41925793.3050404@xmission.com> <1100113055.25879.73.camel@pegasus>
	 <419543B3.8050601@xmission.com> <1100306337.7349.29.camel@pegasus>
	 <41957BC1.507@xmission.com>
Content-Type: text/plain
Message-Id: <1100351199.7349.50.camel@pegasus>
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
Date: Sat, 13 Nov 2004 14:06:38 +0100

Hi Brad,

> >>The accept looks like this byte-for-byte:
> >>
> >>02 -> response accept
> >>02 -> AVDT_GET_CAPABILITIES
> >>01 -> category = media transport
> >>00 -> length of service capabilities = 0
> >>07 -> 7 'elements' follow
> >>06 -> elements[0]
> >>00 ->
> >>00 ->
> >>ff ->
> >>ff ->
> >>02 ->
> >>fa -> elements[6]
> 
> > this should be the codec specific part. Look at A2DP for more details.
> 
> It doesn't totally seem to match up. The last 4 bytes seem to be the 
> capabilities of SBC (p.20 of a2dp)
> 
> ff -> supports all sampling frequencies, channel modes
> ff -> supports all block lengths, subbands, allocation methods
> 02 -> minimum bitpool val
> fa -> max bitpool val
> 
> I can't find where the first 06, 00, 00 fit. Also, does the seid=1 in 
> the avdtp_discover accept correspond to only supporting SBC? I wasn't 
> expecting to know the supported codecs until after the first 
> avdt_get_capabilities.

I looked it up and the GET_CAPABILITIES response you get back contains
two block. The first is the "media transport" with 0 bytes of additional
information and the second is the "media codec" part with 6 bytes of
codec specific information.

	0x01 = media transport
	0x07 = media codec

The first 0x00 represents the "media type" and the second the "media
codec type". And this means "audio" and "SBC". And the rest is SBC
specific as you already recognized.

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
