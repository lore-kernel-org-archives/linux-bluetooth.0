Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9307f5f20601171158ke41d974l29149adc20d8cd6c@mail.gmail.com>
From: "P. Durante" <shackan@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] D-Bus tasks planning
Cc: Claudio Takahasi <cktakahasi@gmail.com>
In-Reply-To: <1137505788.28239.18.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0601170535yadd5f6fy93c3a5ea64a8499f@mail.gmail.com>
	 <1137505788.28239.18.camel@localhost>
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
Date: Tue, 17 Jan 2006 20:58:36 +0100

Hi there,
I'm happy to see the DBus issue again on the list.
Even if I've already been told you don't like c++, I've got some code
which does exactly what you're looking for so maybe it may be of some
use, unfortunately I'm a student and
this leaves me with little for fun activities (like coding) so the
code hasn't been touched for a while(=3Dmonths), I've started a complete
rewrite but I don't know how long this is going to take, in the
meantime I hope the old version will be useful, at least to grab some
ideas

>
> The problem with the current SDP API is that it is blocking and at some
> places really horrible. We need an event driven API and if we don't
> wanna use threads, we have to rewrite it.
>
sdp api:
http://svn.berlios.de/viewcvs/bluetool/trunk/lib/bluetool/include/bluetool/=
sdpclient.h?view=3Dmarkup
http://svn.berlios.de/viewcvs/bluetool/trunk/lib/bluetool/src/linux/sdpclie=
nt.cpp?view=3Dmarkup

http://svn.berlios.de/viewcvs/bluetool/trunk/lib/bluetool/include/bluetool/=
sdprecord.h?view=3Dmarkup
http://svn.berlios.de/viewcvs/bluetool/trunk/lib/bluetool/src/linux/sdpreco=
rd.cpp?view=3Dmarkup
http://svn.berlios.de/viewcvs/bluetool/trunk/lib/bluetool/src/linux/sdpreco=
rd_p.h?view=3Dmarkup

http://svn.berlios.de/viewcvs/bluetool/trunk/lib/bluetool/include/bluetool/=
sdperror.h?view=3Dmarkup
http://svn.berlios.de/viewcvs/bluetool/trunk/lib/bluetool/src/linux/sdperro=
r.cpp?view=3Dmarkup

glue between the sdp api and dbus:
http://svn.berlios.de/viewcvs/bluetool/trunk/bin/daemon/src/sdp/sdp_browser=
.h?view=3Dmarkup
http://svn.berlios.de/viewcvs/bluetool/trunk/bin/daemon/src/sdp/sdp_browser=
.cpp?view=3Dmarkup

http://svn.berlios.de/viewcvs/bluetool/trunk/bin/daemon/src/sdp/sdp_record.=
h?view=3Dmarkup
http://svn.berlios.de/viewcvs/bluetool/trunk/bin/daemon/src/sdp/sdp_record.=
cpp?view=3Dmarkup

>
> since I don't wanna use threads, we need a good and safe event loop
> implementation that integrates nicely with D-Bus. The one from Glib is
> no option.
>
I've got an alternative which does not depend on glib (in the same
repository) but it's not very clean and safe so I'll spare you the
horror :-)

regards,
Paul


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
