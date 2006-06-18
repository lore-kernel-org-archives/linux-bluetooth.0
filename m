Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 18 Jun 2006 15:02:48 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150540265.17539.26.camel@aeonflux.holtmann.net>
Message-ID: <Pine.LNX.4.63.0606181455350.8278@redbean.intranet.gw-instruments.de>
References: <Pine.LNX.4.63.0606131103210.23334@redbean.intranet.gw-instruments.de>
	<1150197013.2534.23.camel@aeonflux.holtmann.net>
	<Pine.LNX.4.63.0606131329100.23668@redbean.intranet.gw-instruments.de>
	<1150540265.17539.26.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] bluez-utils-3.0 cross compile broken
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hi Marcel,

> > What a pain ...... I'll stay with the older version for now ...... 
> > When I got some spare time I'll try to figure out how to use this stuff 
> > when doing cross builds. 
> 
> sorry for that, but pkg-config should actually make it easier in the
> end. And a new major version is allowed to break stuff :)

It seems to be easier then expected. Just installing pkg-config, adding 
PKG_CONFIG_PATH to the build environment for bluez utils and rebuilding 
everything seems to do the job. The build now complains about the missing  
d-bus libraries, but this is a different story..... 

Wouldn't be that bad if somebody can update the package dependencies in 
the Readme (I know, nobody gots enough free time doing such non productive 
work ;-). 

Ciao, 

Peter

|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
