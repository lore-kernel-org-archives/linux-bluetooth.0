Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btsco
From: Dave Henriksen <dhenriksen@optibrand.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1107209370.8848.4.camel@pegasus>
References: <1107212460.6703.9.camel@linux.site>
	 <1107209370.8848.4.camel@pegasus>
Content-Type: text/plain
Message-Id: <1107214572.4223.1.camel@linux.site>
Mime-Version: 1.0
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
Date: Mon, 31 Jan 2005 15:36:12 -0800

Marcel,

Thanks, I think that I have everything that I need now.   I just can't
get past the following error:

./bootstrap
aclocal: configure.in: 21: macro `AM_PATH_ALSA' not found in library

Any idea what this may be ?

Thanks,

Dave

On Mon, 2005-01-31 at 23:09 +0100, Marcel Holtmann wrote:
> Hi Dave,
> 
> > I am attempting to build btsco.   I apologize if this is a dumb
> > question, but where in the heck can I download the libao-dev and
> > libbluetooth-dev packages ?   The only ones I have found are ".deb"
> > packages for Debian.  I am running under SUSE9.2
> 
> you only have to install them. They are named a little bit different.
> The development part for the Bluetooth library is already included in
> the bluez-libs package and for the AO library you need libao-devel.
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
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
-- 
Dave Henriksen <dhenriksen@optibrand.com>



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
