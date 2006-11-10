Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Hilzinger <mhilzinger@linuxnewmedia.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 10 Nov 2006 15:01:28 +0100
References: <4550B23D.8090706@palmsource.com>
	<200611101434.15802.mhilzinger@linuxnewmedia.de>
	<45548385.9010102@palmsource.com>
In-Reply-To: <45548385.9010102@palmsource.com>
MIME-Version: 1.0
Message-Id: <200611101501.28261.mhilzinger@linuxnewmedia.de>
Subject: Re: [Bluez-devel] [patch]
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Am Freitag, 10. November 2006 14:49 schrieb Fr=E9d=E9ric DALLEAU:
> Marcel Hilzinger a =E9crit :
> > Am Freitag, 10. November 2006 14:18 schrieb Marcel Hilzinger:
> >> Am Mittwoch, 8. November 2006 11:05 schrieb Fr=E9d=E9ric DALLEAU:
> >>> Sorry Brad,
> >>> This is far more useful than whitespaces :D
> >>> Fred
> >>
> >> Hi Fr=E9d=E9ric,
> >>
> >> I applied your patch on the cvs-code from today and now I get these
> >> errors randomly:
> >>
> >> Nov 10 14:15:55 kim kernel: l2cap_recv_acldata: Unexpected continuation
> >> frame (len 0)
> >> Nov 10 14:15:55 kim kernel: l2cap_recv_acldata: Unexpected continuation
> >> frame (len 0)
> >> Nov 10 14:15:55 kim kernel: l2cap_recv_acldata: Unexpected continuation
> >> frame (len 0)
> >> Nov 10 14:15:56 kim kernel: l2cap_recv_acldata: Unexpected continuation
> >> frame (len 0)
> >>
> >> the error means, that for 1-2 seconds there is no sound.
> >>
> >>
> >> Any idea, if it's due to the patch or just "par hazard"?
> >
> > OK. It was me: I removed sbcbitpool=3D64 from .a2dpdrc.
> >
> > Now I put it back and the underruns are gone.
>
> This line is commented in the default file so it should not be the case.
> Does it work with 32.
With 32 i have some underruns, but not much. With 64 I have almost no =

problems. If I comment the option out, then they appear quite often.

> Can you send me the faulty .a2dprc?

#####################################
[a2dpd]
#
# Rate
# use 32000 if your headset seems to not support 44100 (HP works well at =

44100, Sonorix at 32000)
# Alsa output may not work depending on your graphics card
# Very few players supports it (xmms does, but not amarok/gxine engine)
#
rate=3D44100
#rate=3D32000
enablereversestereo=3D1

#
# AVRCP Commands to run
#
cmdplay=3Dxmms --play
cmdpause=3Dxmms --pause
cmdprev=3Dxmms --rew
cmdnext=3Dxmms --fwd
#cmdprev=3Damarok --previous
#cmdnext=3Damarok --next
cmdnew=3Dxmms --play
# Put to 0 to ignore AVRCP (if your computer freezes when commands are =

received)
enableavrcp=3D1

#
# Audio routing
#
# If set to 1 (at a2dp startup only) a2dp will reread configuration file
#=A0for audio routing changes each second
enablerereadconfig=3D1

# 0 =3D> Bluetooth A2DP Sink
# 1 =3D> Alsa
enableredirectalsa=3D0

# Hint from Fr=E9d=E9ric
#sbcbitpool=3D32

# Your bluetooth headset address
address=3D00:13:17:70:44:5A # Jabra
#address=3D00:0D:44:58:11:CA # Logitech

# Address of your alsa output (default : plughw:0,0) you have to know what =
to =

do
alsaoutput=3D

#########################
Linebreaks done by my mail client...

-- =

Mit freundlichen Gr=FC=DFen,
Marcel Hilzinger

Linux New Media AG
S=FCskindstr. 4
D-81929 M=FCnchen
Tel: +49 (89) 99 34 11 0
Fax: +49 (89) 99 34 11 99

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
