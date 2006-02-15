Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <bd72c4b0602151540g7e85180fw573dbd29062c167f@mail.gmail.com>
From: Gareth Bradley <gareth.bradley.nz@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] SCO syncronization taking down USB dongle
In-Reply-To: <1139992509.26072.16.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11850_16745953.1140046857914"
References: <bd72c4b0602141948w3bacbf30q49f933551f56b40a@mail.gmail.com>
	 <1139992509.26072.16.camel@localhost>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 15 Feb 2006 11:40:57 -1200

------=_Part_11850_16745953.1140046857914
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thank you for your reply Marcel.

the dongle gets disconnected from the USB bus. What kind of dongle is
> this? Maybe you need to get yourself a better one, because a disconnect
> from the USB is nothing we can really work around.


I am unsure of the dongle's actual manufacturer, as it's just a DSE (our
Radio Shack equivilant) rebrand. I have since tried it with a Stollman
dongle, and am able to get the same result (crash).

I am able to get the USB crash with a test program, pasted below. The 'rlen
-=3D 1;' line is added to crash it. I am currently unable to test if this w=
ill
also crash on other platforms, such as on a PC or PDA. Should this be able
to take down the dongle?

The actual project runs with the number of bytes written to the headset
being regulated by the number read from the headset (though the sound is
from an external source, not straight back into the headset, like in the
example). Is this the correct way to regulate SCO data?

        while(1){
            FD_ZERO(&rfds);
            FD_SET(serial_fd, &rfds);
            FD_SET(sd, &rfds);

            timeout.tv_sec =3D 0;
            timeout.tv_usec =3D 10000;

            if((sel =3D select(maxfd + 1, &rfds, NULL, NULL, &timeout)) > 0=
) {
                if(FD_ISSET(serial_fd, &rfds)){
                    memset(soundbuf, 0, sizeof(soundbuf));
                    rlen =3D read(serial_fd, soundbuf, sizeof(soundbuf));
                    if(rlen > 0){
                        wlen =3D write(serial_fd, "\r\nOK\r\n", 4);
                    }
                }

                if (FD_ISSET(sd, &rfds)) {
                    memset(soundbuf, 0, sizeof(soundbuf));
                    rlen =3D read(sd, soundbuf, sizeof(soundbuf));

                    rlen -=3D 1; // This line is able to enduce the crash
                    wlen =3D 0;
                    p =3D soundbuf;
                    while(rlen > sco_mtu){
                        wlen +=3D write(sd, p, sco_mtu);
                        rlen -=3D sco_mtu;
                        p +=3D sco_mtu;
                     }
                wlen +=3D write(sd, p, rlen);

                }
            }
        }

> I notice that flow (and error) control appear on the Todo list, but is
> > there some way to guard against the whole dongle being taken down?
>
> It only protects the host stack and not the dongle. The flow control
> towards the HCI of the dongle is always used.


Thanks again for your input.

gjb.

------=_Part_11850_16745953.1140046857914
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span class=3D"gmail_quote"></span>Thank you for your reply Marcel.<br>
<br>
<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">the dongle g=
ets disconnected from the USB bus. What kind of dongle is<br>this? Maybe yo=
u need to get yourself a better one, because a disconnect
<br>from the USB is nothing we can really work around.</blockquote><div><br=
>
I am unsure of the dongle's actual manufacturer, as it's just a DSE
(our Radio Shack equivilant) rebrand. I have since tried it with a
Stollman dongle, and am able to get the same result (crash).<br>
<br>
I am able to get the USB crash with a test program, pasted below. The
'rlen -=3D 1;' line is added to crash it. I am currently unable to test
if this will also crash on other platforms, such as on a PC or PDA.
Should this be able to take down the dongle?<br>
<br>
The actual project runs with the number of bytes written to the headset
being regulated by the number read from the headset (though the sound
is from an external source, not straight back into the headset, like in
the example). Is this the correct way to regulate SCO data?<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; while(1){<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FD_ZERO(&amp;rfds)=
;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FD_SET(serial_fd, =
&amp;rfds);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; FD_SET(sd, &amp;rf=
ds);<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; timeout.tv_sec =3D=
 0;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; timeout.tv_usec =
=3D 10000;<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if((sel =3D
select(maxfd + 1, &amp;rfds, NULL, NULL, &amp;timeout)) &gt; 0) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 if(FD_ISSET(serial_fd, &amp;rfds)){<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; memset(soundbuf, 0,
sizeof(soundbuf));<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rlen =3D read(serial_fd, soundbuf,
sizeof(soundbuf));<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; if(rlen &gt; 0){<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; wlen =3D
write(serial_fd, &quot;\r\nOK\r\n&quot;, 4);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 }<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 if (FD_ISSET(sd, &amp;rfds)) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; memset(soundbuf, 0,
sizeof(soundbuf));<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rlen =3D read(sd, soundbuf,
sizeof(soundbuf));<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rlen -=3D 1; // This line is able
to enduce the crash<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; wlen =3D 0;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; p =3D soundbuf;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; while(rlen &gt; sco_mtu){<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; wlen +=3D
write(sd, p, sco_mtu);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rlen -=3D
sco_mtu;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; p +=3D sco_mtu;<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 wlen +=3D write(sd, p, rlen);<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 }<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; } <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; I =
notice that flow (and error) control appear on the Todo list, but is<br>&gt=
; there some way to guard against the whole dongle being taken down?
<br><br>It only protects the host stack and not the dongle. The flow contro=
l<br>towards the HCI of the dongle is always used.&nbsp;</blockquote><br></=
div>Thanks again for your input.<br>
<br>
gjb.<br>

------=_Part_11850_16745953.1140046857914--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
