Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Cross Compile Blues ....
In-Reply-To: <1101929937.15615.30.camel@pegasus>
Message-ID: <Pine.LNX.4.33.0412021701500.6295-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 2 Dec 2004 17:11:00 +0100 (CET)


Hi Marcel,

thank you. This helped to build the libraries correctly. Library build now
looks like this (if anybody runs into the same problem):

# configure and make bluez libs
pushd bluez/bluez-libs-2.11
./configure --host=$TARGET --build=i686-pc-linux-gnu \
            --with-kernel=$LINUX_DIR \
            --libdir=/lib --includedir=$XPREFIX/include
make
make install DESTDIR=$XPREFIX
popd

However, it fails with utils. But this isn't much of a problem, for
now I can live with the hack below....

When I don't use prefix with utils I get some real strange problem with
the include pathes. Looks like the native include pathes are used ?!?

# configure and make bluez utils
pushd bluez/bluez-utils-2.11
./configure --prefix=$XPREFIX --host=$TARGET --build=i686-pc-linux-gnu \
            --with-kernel=$LINUX_DIR \
            --libdir=$XPREFIX/lib --includedir=$XPREFIX/include
#            --sysconfdir=/etc
#            --without-glib
# can't figure out how to get this right .......... so...
echo "#undef CONFIGDIR" >> config.h
echo "#define CONFIGDIR \"/etc/bluetooth\"" >> config.h
make
make install
popd

Thanks again and Ciao,

Peter

On Wed, 1 Dec 2004, Marcel Holtmann wrote:

> Hi Peter,
>
> > I'm trying to cross compile bluez-libs / utils (Vers. 2.11). Actually, I
> > can compile fine, but I've the following problems:
> >
> > a) when I compile the libraries I'm unable to find a configure which
> > allows me to have the libraries installed on the the build system but with
> > a load path of the target system (/usr/lib). Here is the configure I use
> >
> > ./configure --prefix=$XPREFIX --host=$TARGET --build=i686-pc-linux-gnu \
> >             --with-kernel=$LINUX_DIR \
> >             --libdir=$XPREFIX/lib --includedir=$XPREFIX/include
> >
> > where XPREFIX is the path to the target root file system on my build
> > system, TARGET is arm-linux  LINUX_DIR is the path to the linux sources
> > for the target system. What I need is some configuration which installs
> > the library files in $XPREFIX/lib and builds the libraries for RUN PATH
> > /lib. Does anybody know how t get this working ????
>
> use the normal prefix and install them with DESTDIR.
>
> > b) the same problem occurs with the CONFIGDIR define in config.h.
> > It is always set to $XPREFIX/etc/bluetooth
> > instead of just /etc/bluetooth
>
> As long as you don't override it with --sysconfdir.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
