Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Hilzinger <mhilzinger@linuxnewmedia.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 10 Nov 2006 15:08:07 +0100
References: <454B3AD7.7080401@gmail.com>
	<d7dffb480611100605k76213ee2sf5da832c3ac31d6b@mail.gmail.com>
In-Reply-To: <d7dffb480611100605k76213ee2sf5da832c3ac31d6b@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200611101508.08084.mhilzinger@linuxnewmedia.de>
Subject: Re: [Bluez-devel] bluetooth-alsa and HAMA BTH-155
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

Am Freitag, 10. November 2006 15:05 schrieb VANatFortuna amarnath:
> hi Christian !
>     I am vey new to BlueZ and even bluetooth. I am trying to configure
> bluetooth headset to 'skype' to make calls. and i downloaded both 'alsa
> project' and 'btsco' and i followed as per the instruction. and even
> bt-utils(3.7).
>
>   But while running
>       #btsco <my headset addr>
>   i am facing the same proble what u faced.
> -------------------
> Error: Failed to connect to SDP server: Permission denied
> Assuming channel 2
>
> Voice setting: 0x0060
> Can't connect RFCOMM channel: Permission denied

Which distro are you using? Some of them do pairing automatically, others n=
ot. =

under edgy e.g you have to install bluez-passkey-gnome



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
