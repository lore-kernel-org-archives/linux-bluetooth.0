Return-Path: <cyrus@holtmann.org>
Message-ID: <281756.37525.qm@web94901.mail.in2.yahoo.com>
Date: Tue, 13 Jul 2010 06:14:30 -0700 (PDT)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: Re: ipc-sock/l2cap sock/g_io_fd
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20100713125751.GA13089@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

=0A--- On Tue, 13/7/10, Johan Hedberg <johan.hedberg@gmail.com> wrote:=0A=
=0A> From: Johan Hedberg <johan.hedberg@gmail.com>=0A> Subject: Re: ipc-soc=
k/l2cap sock/g_io_fd=0A> To: "Pavan Savoy" <pavan_savoy@yahoo.co.in>=0A> Cc=
: linux-bluetooth@vger.kernel.org, "Marcel Holtmann" <marcel@holtmann.org>=
=0A> Date: Tuesday, 13 July, 2010, 6:27 PM=0A> Hi Pavan,=0A> =0A> On Tue, J=
ul 13, 2010, Pavan Savoy wrote:=0A> > Marcel,=0A> =0A> I don't know why you=
 expect specifically Marcel to have=0A> some clue about=0A> the audio stuff=
. He hasn't been much involved with the=0A> development of it=0A> so I don'=
t excpect you to get a reply from him ;)=0A=0AIsn't Marcel =3D GOD for blue=
tooth on linux ?=0AAlthough I did put it to the list.=0A=0A> > I am sort of=
 lost among the various sockets that are=0A> in the=0A> > bluez/audio, and =
trying to get a clear picture on what=0A> is what.=0A> > =0A> > find attach=
ed the short image on my understanding of=0A> the audio=0A> > structure (cu=
rrently used by apps which use liba2dp=0A> and not the pcm=0A> > plugins..-=
 namely android..)=0A> > =0A> > Is my understanding=A0 correct ?=0A> > What=
 does the various sockets represent, as in=0A> stream.fd, server.fd -=0A> >=
 and the fd extracted from the session_io.=0A> > =0A> > I sort of need to k=
now which is which, as in which is=0A> communication=0A> > over local IPC B=
T_IPC_SOCKET_NAME, which actually=0A> corresponds to the=0A> > l2cap connec=
tion which is established in sink.c ?=0A> > =0A> > How does it get into the=
 sesssion->io ? Please help=0A> me understand=0A> > these various sock fd's=
.=0A> =0A> So I'd say there are three key sockets with A2DP. You've=0A> got=
 the=0A> signalling channel for A2DP (I think that's what you mean=0A> when=
 you say=0A> session->io). That socket stays always inside=0A> bluetoothd. =
Then there's a=0A> local unix socket which is used to communicate with an=
=0A> external audio=0A> process (alsa, gstreamer, pulseaudio, whatever). I =
suspect=0A> that'd match=0A> the server.fd which you mentioned. Then, for e=
very A2DP=0A> media transport=0A> channel we transfer the socket over to th=
e external audio=0A> process which=0A> then takes care of writing (and read=
ing in the case of SCO)=0A> of it.=0A> That's what stream.fd is referring t=
o.=0A=0AVery nice to know, thanks a lot.=0A=0A> With BlueZ 5.0 we're gonna =
scrap the unix socket completely=0A> since D-Bus=0A> nowdays has support fo=
r file descriptor transfer from one=0A> process to=0A> another. There's alr=
eady a prototype patch for it but it=0A> hasn't been=0A> merged upstream ye=
t. Hopefully getting rid of the extra=0A> homebrewed IPC=0A> should help si=
mplify the picture a little bit.=0A=0AYes, So as I understand, the func "bt=
_audio_service_get_data_fd" helps us pass around the stream fd to another p=
rocess, which can use it for writing, the CMSG thingy ??=0A=0AWhere exactly=
 is it filled up to do a recvmsg ? As in somewhere I should have found a me=
mcpy(CMSG_DATA, &stream.fd, sizeof(int)) ?=0A=0AGreat, fd passing around ov=
er D-Bus, This info, solves my other problem too :) Will look it up ..=0A=
=0A> Johan=0A> =0A=0A
