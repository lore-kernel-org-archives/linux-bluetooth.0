Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327164406.1955.54.camel@aeonflux>
References: <1326975033-2668-1-git-send-email-ulisses@profusion.mobi>
	<1327164406.1955.54.camel@aeonflux>
Date: Sat, 21 Jan 2012 17:35:52 -0200
Message-ID: <CAA37ikayF2R-y9aUkCr7XqX+MmtDgXUfepdsoOe64uYMtc5tug@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Remove usage of __cancel_delayed_work()
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>
Content-Type: multipart/alternative; boundary=e89a8f235581c6741404b70ee72a
List-ID: <linux-bluetooth.vger.kernel.org>

--e89a8f235581c6741404b70ee72a
Content-Type: text/plain; charset=ISO-8859-1

Great. But Johan please wait to apply. I'll send a new one with another
change to prevent a crash.

On Saturday, January 21, 2012, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Ulisses,
>
>> __cancel_delayed_work() is being used in some paths where we cannot
>> sleep waiting for the delayed work to finish. However, that function
>> might return while the timer is running and the work will be queued
>> again. Replace the calls with safer cancel_delayed_work() version
>> which spins until the timer handler finishes in other CPUs and
>> cancels the delayed work.
>>
>> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
>> ---
>>
>> v2 - rebased against newer bluetooth-next
>>
>>  include/net/bluetooth/l2cap.h |    4 ++--
>>  net/bluetooth/l2cap_core.c    |   10 +++++-----
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> looks fine to me.
>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
>
> Regards
>
> Marcel
>
>
>

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

--e89a8f235581c6741404b70ee72a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Great. But Johan please wait to apply. I&#39;ll send a new one with another=
 change to prevent a crash.<br><br>On Saturday, January 21, 2012, Marcel Ho=
ltmann &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtmann.org</a>&g=
t; wrote:<br>
&gt; Hi Ulisses,<br>&gt;<br>&gt;&gt; __cancel_delayed_work() is being used =
in some paths where we cannot<br>&gt;&gt; sleep waiting for the delayed wor=
k to finish. However, that function<br>&gt;&gt; might return while the time=
r is running and the work will be queued<br>
&gt;&gt; again. Replace the calls with safer cancel_delayed_work() version<=
br>&gt;&gt; which spins until the timer handler finishes in other CPUs and<=
br>&gt;&gt; cancels the delayed work.<br>&gt;&gt;<br>&gt;&gt; Signed-off-by=
: Ulisses Furquim &lt;<a href=3D"mailto:ulisses@profusion.mobi">ulisses@pro=
fusion.mobi</a>&gt;<br>
&gt;&gt; ---<br>&gt;&gt;<br>&gt;&gt; v2 - rebased against newer bluetooth-n=
ext<br>&gt;&gt;<br>&gt;&gt; =A0include/net/bluetooth/l2cap.h | =A0 =A04 ++-=
-<br>&gt;&gt; =A0net/bluetooth/l2cap_core.c =A0 =A0| =A0 10 +++++-----<br>&=
gt;&gt; =A02 files changed, 7 insertions(+), 7 deletions(-)<br>
&gt;<br>&gt; looks fine to me.<br>&gt;<br>&gt; Acked-by: Marcel Holtmann &l=
t;<a href=3D"mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;<br>&gt=
;<br>&gt; Regards<br>&gt;<br>&gt; Marcel<br>&gt;<br>&gt;<br>&gt;<br><br>-- =
<br>
Ulisses Furquim<br>ProFUSION embedded systems<br><a href=3D"http://profusio=
n.mobi">http://profusion.mobi</a><br>Mobile: +55 19 9250 0942<br>Skype: uli=
ssesffs<br>

--e89a8f235581c6741404b70ee72a--
