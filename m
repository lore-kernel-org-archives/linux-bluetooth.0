Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: "soraberri" <malfonso@able.es>
Message-ID: <cnd36h$dmi$1@sea.gmane.org>
References: <cncjb4$rrr$1@sea.gmane.org> <1100600361.7208.108.camel@pegasus> <cncqln$iuc$1@sea.gmane.org> <1100610864.7235.1.camel@notepaq>
Subject: [Bluez-devel] Re: Re: Bluetooth enabled products codes
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
Date: Tue, 16 Nov 2004 15:30:45 +0100

so, what I didn't understant was that those four hexadecimal numbers in the
table represent the whole feature mask of the specific device. I was looking
to the 1.2 BT specification and new extended (AFH) features make necessary
more bytes to mask the features
Thanks, Marcel.

"Marcel Holtmann" <marcel@holtmann.org> escribió en el mensaje
news:1100610864.7235.1.camel@notepaq...
> Hi,
>
> > I appreciate very much your quick answer.
> > There are a list of feature definitions in the link manager
specification
> > and it is also specified wich bit is notifying the presence of a given
> > feature in terms of the position of this bit relative to the feature
mask.
> > The supported features are also numbered from 0 to 63 i.e. ox0 to ox3F
(
> > though not all numbers defined), but anyway it's hard for me to perceive
> > which is the relationship between these numbers/mask and the hexadecimal
> > codes aforesaid
>
> use the API call lmp_featurestostr() to decode them.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: InterSystems CACHE
> FREE OODBMS DOWNLOAD - A multidimensional database that combines
> robust object and relational technologies, making it a perfect match
> for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8





-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
