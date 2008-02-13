Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY102-W220E308B67B2F42DCEB5FFF0240@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Wed, 13 Feb 2008 16:25:14 +0000
In-Reply-To: <BAY102-W409DB55A6A242470BDB930F02B0@phx.gbl>
References: <5d5443650802080456p78f33f07s3ec6ac4c4c1e789c@mail.gmail.com>
	<20080208141056.GZ24072@matthew.ath.cx>
	<5d5443650802110839u2f12eb01j603dcc436085c84d@mail.gmail.com>
	<20080211164102.GA8137@berrange.com>
	<BAY102-W409DB55A6A242470BDB930F02B0@phx.gbl>
MIME-Version: 1.0
Subject: [Bluez-devel] Asynchronous SDP With DBUS API
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0754988480=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0754988480==
Content-Type: multipart/alternative;
	boundary="_44a1d6f8-bade-4385-9e1b-b7ad0c5fe3df_"

--_44a1d6f8-bade-4385-9e1b-b7ad0c5fe3df_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello List,
=20
I've been playing around with the DBUS API over the past week or two and no=
tice a large number of the methods implemented are asynchronous and send ba=
ck signals when results from them are returned, however, this doesn't appea=
r to be the case with an SDP enquiry placed through the service which appea=
rs to run synchronously.
=20
What's the reason behind this? are we not able to have it emit a signal suc=
h as 'serviceFound()' or something to that effect? is this down to a limita=
tion of the hardware? the stack? or am I just coding against the API incorr=
ectly?
=20
Has anyone been able to find an Asynchronous implementation for SDP enquiri=
es? even if its some form of threaded work around.
=20
Thanks for any advice you can offer.
=20
Robert
_________________________________________________________________
Free games, great prizes - get gaming at Gamesbox.=20
http://www.searchgamesbox.com=

--_44a1d6f8-bade-4385-9e1b-b7ad0c5fe3df_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>Hello List,<BR>
&nbsp;<BR>
I've been playing around with the DBUS API over the past week or two and no=
tice a large number of the methods implemented are asynchronous and send ba=
ck signals when results from them are returned, however, this doesn't appea=
r to be the case with an SDP enquiry placed through the service which appea=
rs to run synchronously.<BR>
&nbsp;<BR>
What's the reason behind this? are we not able to have it emit a signal suc=
h as 'serviceFound()' or something to that effect? is this down to a limita=
tion of the hardware? the stack? or am I just coding against the API incorr=
ectly?<BR>
&nbsp;<BR>
Has anyone been able to find an Asynchronous implementation for SDP enquiri=
es? even if its some form of threaded work around.<BR>
&nbsp;<BR>
Thanks for any advice you can offer.<BR>
&nbsp;<BR>
Robert<BR><br /><hr />She said what? About who? <a href=3D'http://www.msnse=
archstar.com' target=3D'_new'>Shameful celebrity quotes on Search Star!</a>=
</body>
</html>=

--_44a1d6f8-bade-4385-9e1b-b7ad0c5fe3df_--


--===============0754988480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0754988480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0754988480==--
