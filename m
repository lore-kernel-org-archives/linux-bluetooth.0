Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <9D57110C-C152-438B-8A0B-59A24FC456D9@holtmann.org>
References: <1402049971-7762-1-git-send-email-kiran.kumar@linaro.org>
	<02B0CA51-A2BB-47D0-B526-229C12C8195C@holtmann.org>
	<CA+RfmHbnd8qSvrnbj0zpn65SHONKG4tj_7L16+e+HOg=NczOtQ@mail.gmail.com>
	<9D57110C-C152-438B-8A0B-59A24FC456D9@holtmann.org>
Date: Fri, 6 Jun 2014 22:46:25 +0530
Message-ID: <CA+RfmHZFOku=rEEyqTMv0s=mVcUPWYWRwg=5RwOaeZEmKf+Tjg@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Do not attempt to send dlci disconnect when in BT_CONFIG.
From: Kiran Raparthy <kiran.kumar@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick Pelly <npelly@google.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Peter Hurley <peter@hurleysoftware.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	"open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>,
	John Stultz <john.stultz@linaro.org>
Content-Type: multipart/alternative; boundary=001a11c14dba7ac53404fb2e05e5
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11c14dba7ac53404fb2e05e5
Content-Type: text/plain; charset=UTF-8

Hi Marcel,
Thanks for the feedback.
I'll try to reproduce on latest build and send the required info.

Regards,
Kiran

On Friday, 6 June 2014, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Kiran,
>
> Below are the traces used by author for submitting patch previously.
>
> [  132.856414] rfcomm:rfcomm_sock_shutdown: sock c5cb3a20, sk c63fca00
> [  132.856933] rfcomm:__rfcomm_sock_close: sk c63fca00 state 5 socket
c5cb3a20
> [  132.857788] rfcomm:__rfcomm_dlc_close: dlc c61ea240 state 7 dlci 38
> err 0 session c63d4ba0
> [  132.858612] rfcomm:rfcomm_send_disc: c63d4ba0 dlci 38
> [  132.859069] rfcomm:rfcomm_send_frame: session c63d4ba0 len 4
> [  132.859893] l2cap:l2cap_sock_sendmsg: sock c5cb38c0, sk c63fc800
> [  132.860351] rfcomm:rfcomm_dlc_set_timer: dlc c61ea240 state 8 timeout
2000
> [ 133.863739] rfcomm:rfcomm_sock_release: sock c5cb3a20, sk c63fca00
> [ 133.864257] rfcomm:rfcomm_sock_shutdown: sock c5cb3a20, sk c63fca00
> [ 133.865081] rfcomm:rfcomm_sock_kill: sk c63fca00 state 5 refcnt 2
> [ 133.865539] rfcomm:rfcomm_sock_destruct: sk c63fca00 dlc c61ea240
>
> they need to be run against a recent bluetooth-next tree. And we also
need HCI traces to show the problem.
> Regards
> Marcel
>

--001a11c14dba7ac53404fb2e05e5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Marcel,<br>Thanks for the feedback.<br>I&#39;ll try to reproduce on late=
st build and send the required info.<br><br>Regards,<br>Kiran<br><br>On Fri=
day, 6 June 2014, Marcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org=
">marcel@holtmann.org</a>&gt; wrote:<br>
&gt; Hi Kiran,<br>&gt;<br>&gt; Below are the traces used by author for subm=
itting patch previously.<br>&gt;<br>&gt; [=C2=A0 132.856414] rfcomm:rfcomm_=
sock_shutdown: sock c5cb3a20, sk c63fca00<br>&gt; [=C2=A0 132.856933] rfcom=
m:__rfcomm_sock_close: sk c63fca00 state 5 socket c5cb3a20<br>
&gt; [=C2=A0 132.857788] rfcomm:__rfcomm_dlc_close: dlc c61ea240 state 7 dl=
ci 38<br>&gt; err 0 session c63d4ba0<br>&gt; [=C2=A0 132.858612] rfcomm:rfc=
omm_send_disc: c63d4ba0 dlci 38<br>&gt; [=C2=A0 132.859069] rfcomm:rfcomm_s=
end_frame: session c63d4ba0 len 4<br>
&gt; [=C2=A0 132.859893] l2cap:l2cap_sock_sendmsg: sock c5cb38c0, sk c63fc8=
00<br>&gt; [=C2=A0 132.860351] rfcomm:rfcomm_dlc_set_timer: dlc c61ea240 st=
ate 8 timeout 2000<br>&gt; [ 133.863739] rfcomm:rfcomm_sock_release: sock c=
5cb3a20, sk c63fca00<br>
&gt; [ 133.864257] rfcomm:rfcomm_sock_shutdown: sock c5cb3a20, sk c63fca00<=
br>&gt; [ 133.865081] rfcomm:rfcomm_sock_kill: sk c63fca00 state 5 refcnt 2=
<br>&gt; [ 133.865539] rfcomm:rfcomm_sock_destruct: sk c63fca00 dlc c61ea24=
0<br>
&gt;<br>&gt; they need to be run against a recent bluetooth-next tree. And =
we also need HCI traces to show the problem.<br>&gt; Regards<br>&gt; Marcel=
<br>&gt;

--001a11c14dba7ac53404fb2e05e5--
