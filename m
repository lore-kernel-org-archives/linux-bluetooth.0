Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] New keytab storage
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075541234.14644.149.camel@akka.yeti.nocrew.org>
References: <1075506991.14644.114.camel@akka.yeti.nocrew.org>
	 <1075509170.3594.36.camel@pegasus>
	 <1075510549.14644.135.camel@akka.yeti.nocrew.org>
	 <1075511922.3594.49.camel@pegasus>
	 <1075541234.14644.149.camel@akka.yeti.nocrew.org>
Content-Type: text/plain
Message-Id: <1075562590.2720.13.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 31 Jan 2004 16:23:10 +0100

Hi Fredrik,

> I haven't looked closely at libs2 but the hcid parts in utils2 appears
> to be a copy of the original utils, except the files are renamed and put
> in a "compat" directory with lots of other utilities. Why is that?
> 
> A "hcid" directory (as in the old "libs") would be better I think.

the compat directories contains the old code until all parts are
replaced. This is why it is called compat. Don't focus on it.

> Maybe this a FAQ but I only get this:
> 
>    $ cvs -d:pserver:anonymous@cvs.bluez.org:/cvsroot/bluez login
>    Logging in to :pserver:anonymous@cvs.bluez.org:2401/cvsroot/bluez
>    CVS password:
>    cvs [login aborted]: end of file from server (consult above messages if any)
>    $
> 
> Any hints, please?

We ran into a SF problem, again. Even my latest update failed and now
the developer access is also blocked. We have to wait until they solved
it.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
