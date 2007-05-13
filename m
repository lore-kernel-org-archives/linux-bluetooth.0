Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Sun, 13 May 2007 18:44:41 +0200
Message-ID: <CE5216C10C83944D9FD37B65CD33F3970CF4D8@mplex01.mpl.access-company.com>
References: <432beae0705121846x7b181d3fm180205dfa783e975@mail.gmail.com><432beae0705121900q237f835ahf6d2ac63c619415@mail.gmail.com>
	<CE5216C10C83944D9FD37B65CD33F3970CF4D7@mplex01.mpl.access-company.com>
From: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE : RE : Problems connecting to a bluetooth headset
	faoMarcel
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1414712499=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1414712499==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7957E.007FD921"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7957E.007FD921
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


>> A2DPD[18:44:14.790]: a2dp_make_listen_socket: (errno=3D13:Permission
>> denied)Cannot bind socket 6 for psm 25

> I'm wondering what causes this, the bind call is failing with =
errno=3DEPERM.
> Do you know of something in bluez config or something security related =
that could prevent binding if not root?

I should have RTFM=20
http://people.csail.mit.edu/albert/bluez-intro/x145.html#port-numbers
Thanks,
Frederic





------_=_NextPart_001_01C7957E.007FD921
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE : [Bluez-devel] RE : Problems connecting to a bluetooth =
headset faoMarcel</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>&gt;&gt; A2DPD[18:44:14.790]: a2dp_make_listen_socket: =
(errno=3D13:Permission<BR>
&gt;&gt; denied)Cannot bind socket 6 for psm 25<BR>
<BR>
&gt; I'm wondering what causes this, the bind call is failing with =
errno=3DEPERM.<BR>
&gt; Do you know of something in bluez config or something security =
related that could prevent binding if not root?<BR>
<BR>
I should have RTFM<BR>
<A =
HREF=3D"http://people.csail.mit.edu/albert/bluez-intro/x145.html#port-num=
bers">http://people.csail.mit.edu/albert/bluez-intro/x145.html#port-numbe=
rs</A><BR>
Thanks,<BR>
Frederic<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7957E.007FD921--


--===============1414712499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1414712499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1414712499==--
