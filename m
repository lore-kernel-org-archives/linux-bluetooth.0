Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: Julien Campana <juliencampana@yahoo.fr>,
   BlueZ-devel List <bluez-devel@lists.sourceforge.net>,
   ed.kay@appliancestudio.com, JavaBluetooth@Chris-Lorenz.com
Subject: Re: [Bluez-devel] Announce : BlueZ-based implemantation of JSR82
References: <1085393268.892.40.camel@fischer>
In-Reply-To: <1085393268.892.40.camel@fischer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200405241255.21584.mtortonesi@ing.unife.it>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 24 May 2004 12:55:21 +0200

On Monday 24 May 2004 12:07, Julien Campana wrote:
> Hi,
>
> We have developped a JSR-82 implementation for Linux, which is based on
> BlueZ and which is compatible with most USB-Dongle's.
>
> We've used parts of JavaBluetooth.org's works and parts of JBluez's
> stuff.
> The native C-Code of the project is entirely based on the BlueZ project
> and I would like to thanks Marcel Holtmann for his answers to my
> questions, which were all helpfull.
>
> We've decided to make the Linux version OpenSource.
>
> The JSR-82 specification is not yet fully implemented but the major part
> of the work (let say 95%) is done.
>
> The package can be downloaded at the following address:
> http://www.avetana-gmbh.de/avetana-gmbh/jsr82.xml
>
> The web site is in german but will be soon translated in english.
>
> JSR-82 is a Sun Microsystems specification for easily developping
> bluetooth based application in Java.
> Good tutorials can be found on the Java developper Center web site as
> well as on manay other web sites.
> For more information about JSR-82, please consult the site:
> http://www.jcp.org/en/jsr/detail?id=82

hi julien and all,

i am working on a similar project (also derived from javabluetooth), a jsr82 
implementation based on bluez that supports also SCO and ASB logical 
transports:

http://lia.deis.unibo.it/Research/ubiQoS/audioStreaming/

perhaps we could cooperate somehow?

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
