Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44F9ABCF.1020706@xmission.com>
Date: Sat, 02 Sep 2006 10:05:35 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44EC8877.8050200@palmsource.com> <44F5A472.30003@xmission.com>
	<44F7088F.6090606@palmsource.com>
In-Reply-To: <44F7088F.6090606@palmsource.com>
Subject: Re: [Bluez-devel] Big patch to a2dpd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fr=E9d=E9ric

thanks for the continued work.

> This one is more than bigger!
> Reindent,
> Alsa output redirection,
> New on-the-fly in-play switch from bt to alsa and reverse
> Changing bdaddr in play too.
> More options described in sample.a2dprc

a few problems:

It only works if the bdaddr is specified in .asoundrc (the old way) as
well as in .a2dprc. Specifying it on the a2dpd command line does not
seem to help.

Audio only came out the left speaker using my itech r35 black set. (My
other sets are up at work)

How do you switch on the fly to wired audio?

> Wrote a doc : http://fdalleau.free.fr/a2dp_doc.pdf ideas welcome!

Could we contribute this stuff to a wiki? I actually have the feeling
that no one of us understands the whole picture. I have an account on
the ubuntu wiki but a better one for our purposes would have no
association with a specific distro...

Brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
