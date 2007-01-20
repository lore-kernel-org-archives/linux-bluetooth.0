Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C73C6E.7C7FBE7E"
Date: Sat, 20 Jan 2007 09:39:23 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EC3@eumonex01.palmsource.com>
References: <D8CE9CFA707C894180BAC8CDD154F8460AF675C3@msiexch01.marvell.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  Bluez-devel Digest, Vol 9, Issue 77
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C73C6E.7C7FBE7E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Quinton,

Sorry, if it works with a2play it cannot be the hardware and a2dpd =
should support it.

I just remebered one important difference between a2play and a2dpd is =
the mtu management.

Run a2play look for the line :  Connected [imtu %d, omtu %d, flush_to =
%d]\n". Note the omtu value.

Then in plugz/alsa-plugins/a2dpd/a2dpd_protocol.h, Look for the line
#define A2DPMAXIMUMTRANSFERUNITSIZE 610
Replace 610 with the value you get from a2play which should be smaller =
than 545.

Hope that works.
Fr=E9d=E9ric




-------- Message d'origine--------
De: bluez-devel-bounces@lists.sourceforge.net de la part de Quinton Yuan
Date: ven. 19/01/2007 20:37
=C0: bluez-devel@lists.sourceforge.net
Objet : Re: [Bluez-devel] Bluez-devel Digest, Vol 9, Issue 77
=20
Thanks, Brad, Frederic

1. I am using Music Angel from Windigo, former company I worked, and
it's based on CSR BC03MM, quite standard stereo headset, with same
setup, a2play works very well though=20

2. I always login as root, and .a2dprc under home directory is the right
one I edit as it contains my right BD address,and debug flag work well.
My guess is timing control in new plugz causes this. I have played with
sbcbitpool value from 32 to 8, sample rate to 32, doesn't help, my UART
work at 2Mbps.

Regards/Quinton

-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of
bluez-devel-request@lists.sourceforge.net
Sent: Friday, January 19, 2007 11:24 AM
To: bluez-devel@lists.sourceforge.net
Subject: Bluez-devel Digest, Vol 9, Issue 77

Send Bluez-devel mailing list submissions to
	bluez-devel@lists.sourceforge.net

To subscribe or unsubscribe via the World Wide Web, visit
	https://lists.sourceforge.net/lists/listinfo/bluez-devel
or, via email, send a message with subject or body 'help' to
	bluez-devel-request@lists.sourceforge.net

You can reach the person managing the list at
	bluez-devel-owner@lists.sourceforge.net

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Bluez-devel digest..."


Today's Topics:

   1. {subj190107} (Jessie Crawford)
   2. Re: Plugz issue (Brad Midgley)
   3. Re: Plugz issue (Fr?d?ric DALLEAU)
   4. {subj190107} (Lupe Mcguire)
   5. loading of hci_uart.ko (Choi Sonim)
   6. collarbone tubby (Montagu)


----------------------------------------------------------------------

Message: 1
Date: Fri, 19 Jan 2007 15:11:25 -0180
From: "Jessie Crawford" <unfaithfullysliver's@access2access.com>
Subject: [Bluez-devel] {subj190107}
To: <bluez-devel@lists.sf.net>
Message-ID: <01c73bdc$165f0b80$6c822ecf@unfaithfullysliver's>
Content-Type: text/plain;	charset=3D"windows-1250"

No more scam or bullshit companies.
Look at charts and ask your broker about:

Ventana Medical Systems

Ventana Receives FDA Approval on Pathway

Thursday January 18, 10:08 am ET
Ventana Medical Systems Receives FDA Approval for Breast Cancer
Detection Test

TUCSON, Ariz. (AP) -- Ventana Medical Systems Inc., a maker of tissue
and slide preparation systems used in drug development, said Wednesday
it received Food and Drug Administration approval on a new antibody.
The company received the approval for its Pathway Her-2/neu (4B5) Rabbit
Monoclonal Antibody as an aid in assessing breast cancer patients being
considered for treatment with Herceptin. It is also approved for use on
the Ventana Image Analysis System.
Herceptin is a cancer treatment made by Genentech Inc. It targets HER-2,
which causes breast cancer cells to grow more rapidly. The approved
Pathway antibody is intended to detect the presence of the HER-2
antigen.

Get in before most investors hear about this awesome news!  VMSI has
just made an announcement which, once the investment community hears
about it, is going to send the issue rise!  Read on to find why we are
so excited!





------------------------------

Message: 2
Date: Fri, 19 Jan 2007 08:26:28 -0700
From: Brad Midgley <bmidgley@xmission.com>
Subject: Re: [Bluez-devel] Plugz issue
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <45B0E324.20506@xmission.com>
Content-Type: text/plain; charset=3DUTF-8

Quinton

>    4. XMMS playback speed issue seems tied to MMAP mode enabled,
disable
>       this mode will get the right playback speed, however, audio
still
>       break  every 2 or 3 seconds, any cue for this ?

which headset is this?

brad



------------------------------

Message: 3
Date: Fri, 19 Jan 2007 17:32:09 +0100
From: Fr?d?ric DALLEAU <frederic.dalleau@palmsource.com>
Subject: Re: [Bluez-devel] Plugz issue
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <45B0F289.9030601@palmsource.com>
Content-Type: text/plain; charset=3DUTF-8; format=3Dflowed

Quinton,
>
> Thanks,
>
>    1. This flag still doesn?t work on my system,
>
I just tried a2dpd from plugz latest cvs and made sure the flags=3D1 is=20
working.
Based on that, my guess is that you modified the wrong file. Are we ok=20
that the file is located at  $HOME/.a2dprc
If you are using the daemon under another user than your desktop user=20
for example (say root), the rc file would be in the home directory of=20
that user) or you could use the -f option. The daemon don't need root=20
privileges.
>
>    4. XMMS playback speed issue seems tied to MMAP mode enabled,
>       disable this mode will get the right playback speed, however,
>       audio still break  every 2 or 3 seconds, any cue for this ?
>
Audio breaks are mostly hardware related : I had different causes :
- Insufficient bandwith (for exemple, serial adapters set at 115k, or=20
sbcbitpool too big)
- Headset don't like the sbcbitpool we provide.
- Bad adapter (I have one that does this with a bdaddr iof
11:11:11:11...)

So as Brad asked : what headset do you use?

BR, Fr?d?ric




------------------------------

Message: 4
Date: Fri, 19 Jan 2007 17:57:26 -0060
From: "Lupe Mcguire" <Epicurusranch@acarrow.com>
Subject: [Bluez-devel] {subj190107}
To: <bluez-devel@lists.sf.net>
Message-ID: <01c73bf3$47832fe0$6c822ecf@Epicurusranch>
Content-Type: text/plain;	charset=3D"iso-8859-2"

No more bankrupts or shit companies.
Look at charts and ask your adviser about:

Ventana Medical Systems

Ventana Receives FDA Approval on Pathway

Thursday January 18, 10:08 am ET
Ventana Medical Systems Receives FDA Approval for Breast Cancer
Detection Test

TUCSON, Ariz. (AP) -- Ventana Medical Systems Inc., a maker of tissue
and slide preparation systems used in drug development, said Wednesday
it received Food and Drug Administration approval on a new antibody.
The company received the approval for its Pathway Her-2/neu (4B5) Rabbit
Monoclonal Antibody as an aid in assessing breast cancer patients being
considered for treatment with Herceptin. It is also approved for use on
the Ventana Image Analysis System.
Herceptin is a cancer treatment made by Genentech Inc. It targets HER-2,
which causes breast cancer cells to grow more rapidly. The approved
Pathway antibody is intended to detect the presence of the HER-2
antigen.

Get in before most investors hear about this awesome news!  VMSI has
just made an announcement which, once the investment community hears
about it, is going to send the issue rise!  Read on to find why we are
so excited!





------------------------------

Message: 5
Date: Fri, 19 Jan 2007 21:04:48 +0200
From: "Choi Sonim" <choisonim@gmail.com>
Subject: [Bluez-devel] loading of hci_uart.ko
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Message-ID:
	<4f436aae0701191104h376e9e89mca6769544b257e29@mail.gmail.com>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

hi all,

I want to ask.
when I do "hciattach /dev/ttyS0 any", somehow the needed module
hci_uart.ko is loaded.
I looked in hciattach.c but I do not see how is it done.
can u please help me here ?

thank you very much all
choi.



------------------------------

Message: 6
Date: Fri, 19 Jan 2007 14:21:14 +0000
From: "Montagu" <zde@uniparinc.com>
Subject: [Bluez-devel] collarbone tubby
To: <bluez-devel@lists.sf.net>
Message-ID: <000d01c73bd5$64c8e9f0$6ec755d4@tky>
Content-Type: text/plain; charset=3D"windows-1250"


Boiler Project Superintendents needed for OEM in Central Florida.
Required skills: Weapon guidance algorithms and guidance and control.
Describe your professional experience with software processes and
methodologies.
Do you have experience in the combustion industry? Experience in toll
plaza design a plus. Experience with MATLAB simulation is beneficial.
Candidate must be proficient in AutoCAD and 3D experience is a plus.
Additional exp and expertise should include piping design modifications,
exp working with equipment OEMs of heat transfer equipment with regards
to equipment replacement projects,. Please detail your overall roadway
- transportation engineering experience in the  private, commercial, and
public sectors.
What are your salary requirements for this position?
Experience with MATLAB simulation is beneficial. Required skills:
guidance and controls, navigation. Will be responsible for full profit
and loss of project, vendor and subcontractor management.
The Customer Service Representative position is a good entry-level
position for potential advancement to management. Candidate must be a
REGISTERED ARCHITECT.
Describe your automation, flow control, level measurement experience as
it relates to manufacturing environment. Do you have 5 years experience
in a manufacturing procurement environment?
Our client is looking for candidates that are local to the Daytona Beach
area or are willing to relocate on their own.
Candidate must have exp in field engineering support of heat transfer
equipment replacements at power plants.
Every client is important to our success and it is essential that our
clients experience a level of service that is superior to our
competition.
A basic understanding of missiles and projectiles is required.
After a sweeping election victory in December, Chavez began his third
term in office last week.
Explain your proficiency. Requires a BSME and 5 years of related
engineering experience in thermal fluids heat transfer. Our client will
provide references if needed.
A certificate in DoD Program Management or Systems Planning, Research,
and Development Engineering or equivalent is desired. What other design
software do you have a proficiency with?
Please describe in detail your experience with field measurements, area
surveys, and aerial maps.
Detail your relevant experience. Describe your experience designing
Process and Instrumentation diagrams. In order to be considered for this
position, the candidate MUST have a BS in Chemical or Mechanical or
Agricultural or Food Engineering.
Rate your skills with GIS, adlCPR, and list other computer programs you
are proficient with.
-------------- next part --------------
An HTML attachment was scrubbed...
URL:
http://sourceforge.net/mailarchive/forum.php?forum=3Dbluez-devel/attachme=
n
ts/20070119/1e0d3070/attachment.html=20
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: image/gif
Size: 31347 bytes
Desc: not available
Url :
http://sourceforge.net/mailarchive/forum.php?forum=3Dbluez-devel/attachme=
n
ts/20070119/1e0d3070/attachment.gif=20

------------------------------

------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDE
V

------------------------------

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


End of Bluez-devel Digest, Vol 9, Issue 77
******************************************

-------------------------------------------------------------------------=

Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


------_=_NextPart_001_01C73C6E.7C7FBE7E
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IhgIAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEANwAAAFJFIDogW0JsdWV6LWRldmVs
XSBCbHVlei1kZXZlbCBEaWdlc3QsIFZvbCA5LCBJc3N1ZSA3NwCgEQEFgAMADgAAANcHAQAUAAkA
JwAXAAYAQAEBIIADAA4AAADXBwEAFAAJACcAFwAGAEABAQmAAQAhAAAANTZDODZCOEE5QzY1ODY0
RDk3NjYzMzVEOUQ4MzVFNDUAKgcBA5AGAJghAAA5AAAAAwAmAAAAAAADADYAAAAAAEAAOQB+vn98
bjzHAR4APQABAAAAAQAAAAAAAAACAUcAAQAAADYAAABjPXVzO2E9IDtwPVBhbG1Tb3VyY2U7bD1F
VU1PTkVYMDEtMDcwMTIwMDgzOTIzWi0xMTQ2OAAAAB4ASQABAAAANgAAAFJlOiBbQmx1ZXotZGV2
ZWxdIEJsdWV6LWRldmVsIERpZ2VzdCwgVm9sIDksIElzc3VlIDc3AAAAQABOAIBG5zIBPMcBHgBa
AAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAACAVsA
AQAAAHEAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldABTTVRQAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9y
Z2UubmV0AAAAAAIBXAABAAAALwAAAFNNVFA6QkxVRVotREVWRUwtQk9VTkNFU0BMSVNUUy5TT1VS
Q0VGT1JHRS5ORVQAAB4AXQABAAAADQAAAFF1aW50b24gWXVhbgAAAAACAV4AAQAAADwAAAAAAAAA
gSsfpL6jEBmdbgDdAQ9UAgAAAABRdWludG9uIFl1YW4AU01UUABxeXVhbkBtYXJ2ZWxsLmNvbQAC
AV8AAQAAABcAAABTTVRQOlFZVUFOQE1BUlZFTEwuQ09NAAAeAGYAAQAAAAUAAABTTVRQAAAAAB4A
ZwABAAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAHgBo
AAEAAAAFAAAAU01UUAAAAAAeAGkAAQAAABIAAABxeXVhbkBtYXJ2ZWxsLmNvbQAAAB4AcAABAAAA
NwAAAFJFIDogW0JsdWV6LWRldmVsXSBCbHVlei1kZXZlbCBEaWdlc3QsIFZvbCA5LCBJc3N1ZSA3
NwAAAgFxAAEAAAAgAAAAAcc7/3d5qFV6jHRiTomm7WvD7nRtyQAAGhWAABtvKoweAHQAAQAAACIA
AABibHVlei1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeABoMAQAAABEAAABGcmVkZXJp
YyBEYWxsZWF1AAAAAB4AHQ4BAAAANwAAAFJFIDogW0JsdWV6LWRldmVsXSBCbHVlei1kZXZlbCBE
aWdlc3QsIFZvbCA5LCBJc3N1ZSA3NwAAAgEJEAEAAACGGQAAghkAAJE4AABMWkZ13ZXoBQMACgBy
Y3BnMTI14jIDQ3RleAVBAQMB908KgAKkA+MCAGNoCsBz8GV0MCAHEwKAD/MAUH8EVghVB7IRxQ5R
AwEQxzL3BgAGwxHFMwRGEMkS2xHT2wjvCfc7GL8OMDURwgxgzmMAUAsJAWQzNhFQC6aoIFF1C4B0
AiAsCqILCoQKgFMFsHJ5LCDXBpAfMAVAdwWwawQgA/CgdGggYTILUXkfYhJjAHBubwVAYmUg5yAg
IXAQ8WR3CsAhcABwkmQgQWRwIoBzaAhgYmwi4XVwcBhhH2EuwR4aSSBqdXMFQBjA9weAIWAYwSAC
ICFwB3AjoisAcAVAZAaQZiWhbmPzIXAhYHR3CeEgRiJoBACbIYMOoHUpcABwYWclYTMCMCQbUnUn
5xhQb2tuIAIQBcAhkmwLgCFwOr4gEsEhEAWQDrAigFsHcLkpkSVkHyAOkS4UZgpADSMAXx3QLiFd
XFxuvCIuB7AhMCF0LnN2B0C7ClAkG1QhoAOgC4AgC1AQdWd6LwdAc2EtOzKiC4BzMvAisjPEX3Cn
A2Ad0BgxLmgfIEwr/g0eFCMBASzCQTJEUABNQVhJTVVNVABSQU5TRkVSVQBOSVRTSVpFIOw2MQFA
KuRlC1EnUTkBpx/0IZIxAyB5CGAgKgDnBUADUiBGd2gN4CAwIwXlIWFzAMBsbBMhICADkYg1NDUk
G0hvcCFyBmEfhSQVRnJcJ2V+OQswQOEFEADgHilB/wp+LUN1BdAHkDMgKgAmwCc1BbBpM4FlQ3Ye
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
qcE2xWmD12A7cS8lezBmYCVpelqhMzH8MzRckGLQv2G5yDP/JcP+cnfAJj8nTyhfKW8qfyuP/yyd
NgEtxS3fQs9ZbEL/Rc/PRt9H71lIWXVUYU4AbfH/CAOBwWIwcAHqUE7wDxHxwfuigxPiRodQxTHS
Irlgl/R2SlXwgUBTOsMY0Ds1J/158FQWsVpw1qBfcG8AtRH7rSF2wSeXUTtAtdET8lQR/91CEWCL
sMuxl/R2wpf0+/DPBBCOEs2iuWAgJqRggaBv79Grsa3wjMBjyQL0gHX6Z4+wYngh3NEH9C+wisSv
SwLJ0IuwOet3WEAuW2D7TzNf0i/hAMAQGCE8w19wGTtAPWpNsTzCJnA9CTq5JkNmED1ERVZ7XACX
9FZED13PQ4+YIV//YC9hP2IKbLU9iLYRbTCM0vscsmMfQByyiWA6vTnocmB/OpBmHztjaENoMwQQ
b3Avvz15X2qhxa0hkMFjekSoMEvtQKxxVnWgIDkTwEmj2aA9kCA3N5f0Km9v/3B/cPVcz3MPdB91
L3Y/Sb//Ss9L30zvTf9PD1AfUS3rs/9Sv1PPVN9V71b/WA9ZH1ov/1s/XBBfz4q/i89i/2QPZR+/
aF9nP5APaV9qb1+XfZYAAAAeADUQAQAAAEIAAAA8N0E2REE1NDVEN0ZEQ0M0QjkzREI2NTFGREJD
MUVEREU0RTZFQzNAZXVtb25leDAxLnBhbG1zb3VyY2UuY29tPgAAAB4AORABAAAAQQAAADxEOENF
OUNGQTcwN0M4OTQxODBCQUM4Q0REMTU0Rjg0NjBBRjY3NUMzQG1zaWV4Y2gwMS5tYXJ2ZWxsLmNv
bT4AAAAAHgBHEAEAAAAPAAAAbWVzc2FnZS9yZmM4MjIAAAsA8hABAAAAHwDzEAEAAAB6AAAAUgBF
ACAAJQAzAEEAIABbAEIAbAB1AGUAegAtAGQAZQB2AGUAbABdACAAQgBsAHUAZQB6AC0AZABlAHYA
ZQBsACAARABpAGcAZQBzAHQALAAgAFYAbwBsACAAOQAsACAASQBzAHMAdQBlACAANwA3AC4ARQBN
AEwAAAAAAAsA9hAAAAAAQAAHMEYjdpxtPMcBQAAIMO1ukHxuPMcBAwDeP69vAAADAPE/DAQAAB4A
+D8BAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAAgH5PwEAAABbAAAAAAAAANynQMjAQhAatLkI
ACsv4YIBAAAAAAAAAC9PPVBBTE1TT1VSQ0UvT1U9TU9OVFBFTExJRVIvQ049UkVDSVBJRU5UUy9D
Tj1GUkVERVJJQy5EQUxMRUFVAAAeAPo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAAC
Afs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T/kBAAAAwAZQAAA
AAADABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBAAQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAA
AB4AMUABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgAyQAEAAAAqAAAAYmx1ZXotZGV2ZWwt
Ym91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeADNAAQAAABIAAABxeXVhbkBtYXJ2ZWxs
LmNvbQAAAB4AOEABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgA5QAEAAAACAAAALgAAAAMA
dkD/////CwApAAAAAAALACMAAAAAAAMABhBqhwlPAwAHECAoAAADABAQAAAAAAMAERAAAAAAHgAI
EAEAAABlAAAAUVVJTlRPTixTT1JSWSxJRklUV09SS1NXSVRIQTJQTEFZSVRDQU5OT1RCRVRIRUhB
UkRXQVJFQU5EQTJEUERTSE9VTERTVVBQT1JUSVRJSlVTVFJFTUVCRVJFRE9ORUlNUE9SVAAAAAAC
AX8AAQAAAEIAAAA8N0E2REE1NDVEN0ZEQ0M0QjkzREI2NTFGREJDMUVEREU0RTZFQzNAZXVtb25l
eDAxLnBhbG1zb3VyY2UuY29tPgAAAFgI

------_=_NextPart_001_01C73C6E.7C7FBE7E
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C73C6E.7C7FBE7E
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C73C6E.7C7FBE7E--
