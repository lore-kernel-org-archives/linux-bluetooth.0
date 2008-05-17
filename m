Return-Path: <cyrus@holtmann.org>
Message-Id: <56A45346-8EDB-4B30-85DE-3D371C0EC702@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <094BCE01AFBE9646AF220B0B3F367AAB03106546@pdsmsx413.ccr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Sat, 17 May 2008 09:16:14 +0200
References: <200805162025.43120.baisheng.wang.cn@gmail.com>
	<094BCE01AFBE9646AF220B0B3F367AAB03106546@pdsmsx413.ccr.corp.intel.com>
Cc: "Holtmann, Marcel" <marcel.holtmann@intel.com>
Subject: Re: [Bluez-devel] sound quality is very slow when using helix
	player.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0115084358=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0115084358==
Content-Type: text/plain; charset=GB2312; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable

Hi Halley,

>
> =A1=A1=A1=A1I have tried several versions of bluez-utils.
> =A1=A1=A1=A11. 3.19, which is included in =20
> Ubuntu 7.10 (Gutsy), it has good audio quality.
> =A1=A1=A1=A12. 3.26, which is included in =20
> Ubuntu Hardy distribution, audio quality has degraded a lot.
> =A1=A1=A1=A13. 3.31, also bad audio quality.

we do dynamic re-configuration of the A2DP link based on the quality =20
aspect given from the player. This means you can switch on the fly =20
between MP3 and SBC and even between mono and stereo etc. I think you =20=

get the idea. However this is complex stuff and there might be a bug. =20=

Especially since nobody I know used Helix so far. As mentioned before =20=

in a private email, provide us with as much details and debug =20
information and then we debug this one.

Regards

Marcel



--===============0115084358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0115084358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0115084358==--
