Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0509221213392b9976@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] D-Bus patching session opened
In-Reply-To: <1127399305.5344.36.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9573_33340830.1127416413337"
References: <1127399305.5344.36.camel@blade>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 22 Sep 2005 16:13:33 -0300

------=_Part_9573_33340830.1127416413337
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

I have some comments and questions:

1. Multiple bluetooth adapters
This is an old discussion but we didn't written it in a stone.
Do you plan support address multiple local adapter or not?
If yes, we have to plan how define the object path. My suggestion
is insert the device id in the path(org/bluez/dev_id/hci,
org/bluez/dev_id/pan, ...).

2. Non D-Bus systems
You wrote in an old email: "bluetoothd should combine hcid and sdpd".
I didn't understand the scope of this assertion. IMHO in the future
for D-Bus enable systems bluetoothd should provide hcid, sdpd and
profiles services(D-Bus).
hcid features include control initialize/register) adapters and
provide D-Bus services for get adapter infos and basic task like
inquiry, scan, remote name, ..
sdpd services include register/unregister local services, control
incomming connections and D-Bus services for search services.
Regarding sdp services, is it necessary provide a D-Bus service for
register/unregister services or we have to use sdp_connect +
sdp_device_record_register?

As long as I could understand, bluetoothd will not be only a
D-Bus service provider, but it must support NON D-Bus clients too.
Is that correct?

3. API version
We have to think how keep the backward compatibility among
the future BlueZ D-Bus services versions. I my opinion we have three
options:
- create a initialization service for bluetoothd where we
can check the version.
- insert an extra arguments in each method call(request)
- define different interface name based on the API version

4. Introspect
It's becomming common implement a Introspectable interface that
make possible get a xml string describing the provided services.
It can be a good feature support it.



Regards,
Claudio

On 9/22/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi,
>
> after I dropped the D-Bus 0.23 API support it is now time to really play
> with the integration of D-Bus support into hcid and other daemons. This
> is the first step into creating a full D-Bus aware bluetoothd in the
> future.
>
> I like to see some more D-Bus enhancements now and Claudio already
> started and he's working hard in explaining his work and making me
> happy. So please help him and review his code and send small patches to
> make the D-Bus experience better. I think about making the D-Bus a core
> dependency of bluez-utils. Does anybody have any arguments against it?
>
> Next thing that I like to see are some Python applications that are
> using GTK+ and D-Bus for a graphical interface to BlueZ. For that I
> think about creating a bluez-python package. Therefor we need people who
> are writing the code and other people who are creating some nice fancy
> icons and graphics for it. First thing should be a D-Bus aware PIN
> helper written completely in Python.
>
> There exists a job/task for everyone :)
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
> own Sony(tm)PSP. Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_9573_33340830.1127416413337
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
I have some comments and questions:<br>
&nbsp;<br>
1. Multiple bluetooth adapters<br>
This is an old discussion but we didn't written it in a stone.<br>
Do you plan support address multiple local adapter or not?<br>
If yes, we have to plan how define the object path. My suggestion<br>
is insert the device id in the path(org/bluez/dev_id/hci, <br>
org/bluez/dev_id/pan, ...).<br>
<br>
2. Non D-Bus systems<br>
You wrote in an old email: &quot;bluetoothd should combine hcid and sdpd&qu=
ot;.<br>
I didn't understand the scope of this assertion. IMHO in the future <br>
for D-Bus enable systems bluetoothd should provide hcid, sdpd and <br>
profiles services(D-Bus). <br>
hcid features include control initialize/register) adapters and <br>
provide D-Bus services for get adapter infos and basic task like <br>
inquiry, scan, remote name, ..<br>
sdpd services include register/unregister local services, control<br>
incomming connections and D-Bus services for search services.<br>
Regarding sdp services, is it necessary provide a D-Bus service for<br>
register/unregister services or we have to use sdp_connect + <br>
sdp_device_record_register?<br>
<br>
As long as I could understand, bluetoothd will not be only a <br>
D-Bus service provider, but it must support NON D-Bus clients too.<br>
Is that correct?<br>
<br>
3. API version<br>
We have to think how keep the backward compatibility among<br>
the future BlueZ D-Bus services versions. I my opinion we have three<br>
options:<br>
&nbsp;- create a initialization service for bluetoothd where we <br>
&nbsp;&nbsp; can check the version.<br>
&nbsp;- insert an extra arguments in each method call(request)<br>
&nbsp;- define different interface name based on the API version<br>
<br>
4. Introspect<br>
It's becomming common implement a Introspectable interface that<br>
make possible get a xml string describing the provided services. <br>
It can be a good feature support it.<br>
<br>
<br>
<br>
Regards,<br>
Claudio<br><br><div><span class=3D"gmail_quote">On 9/22/05, <b class=3D"gma=
il_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.or=
g">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
Hi,<br><br>after I dropped the D-Bus 0.23 API support it is now time to rea=
lly play<br>with the integration of D-Bus support into hcid and other daemo=
ns. This<br>is the first step into creating a full D-Bus aware bluetoothd i=
n the
<br>future.<br><br>I like to see some more D-Bus enhancements now and Claud=
io already<br>started and he's working hard in explaining his work and maki=
ng me<br>happy. So please help him and review his code and send small patch=
es to
<br>make the D-Bus experience better. I think about making the D-Bus a core=
<br>dependency of bluez-utils. Does anybody have any arguments against it?<=
br><br>Next thing that I like to see are some Python applications that are
<br>using GTK+ and D-Bus for a graphical interface to BlueZ. For that I<br>=
think about creating a bluez-python package. Therefor we need people who<br=
>are writing the code and other people who are creating some nice fancy
<br>icons and graphics for it. First thing should be a D-Bus aware PIN<br>h=
elper written completely in Python.<br><br>There exists a job/task for ever=
yone :)<br><br>Regards<br><br>Marcel<br><br><br><br><br>-------------------=
------------------------------------
<br>SF.Net email is sponsored by:<br>Tame your development challenges with =
Apache's Geronimo App Server.<br>Download it for free - -and be entered to =
win a 42&quot; plasma tv or your very<br>own Sony(tm)PSP.&nbsp;&nbsp;Click =
here to play:=20
<a href=3D"http://sourceforge.net/geronimo.php">http://sourceforge.net/gero=
nimo.php</a><br>_______________________________________________<br>Bluez-de=
vel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bl=
uez-devel@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel=
">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockqu=
ote></div><br>

------=_Part_9573_33340830.1127416413337--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
