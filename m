Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <478d26d00512170311g3a4ac3c2g@mail.gmail.com>
From: Toni Fiz <toni.fiz@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Pair problems with nokia 6230
In-Reply-To: <1134462549.10555.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_18559_4348310.1134817918804"
References: <478d26d00512101355g1bca6ab6g@mail.gmail.com>
	 <1134462549.10555.54.camel@localhost.localdomain>
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
Date: Sat, 17 Dec 2005 12:11:58 +0100

------=_Part_18559_4348310.1134817918804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This seems to work

Here it is the solution (tranlated from spanish)


   - Create a text file with the PIN code in */etc/bluetooth/pin*
   - Create the file /usr/local/bin/bluez-localpin with the content below


 #!/bin/sh
echo "PIN":$(cat /etc/bluetooth/pin)


   - Modify */*etc/bluetooth/hcid.conf in order to set this options

options {

        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /usr/local/bin/bluez-localpin; #este no es el que
trae por defecto, ver arriba
}
device {
        name "%h-%d";
        class 0x3e0100;
        iscan enable; pscan enable;
        lm accept;
        lp rswitch,hold,sniff,park;


   - Restart daemon

# /etc/init.d/bluez-utils restart

------=_Part_18559_4348310.1134817918804
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This seems to work<br>
<br>
Here it is the solution (tranlated from spanish)<br>
<br>
<ul>
  <li><span style=3D"font-family: arial,sans-serif;">Create a text file wit=
h the PIN code in </span><b style=3D"font-family: arial,sans-serif;">/etc/b=
luetooth/pin</b></li>
  <li><span style=3D"font-family: arial,sans-serif;">Create the file /usr/l=
ocal/bin/bluez-localpin with the content below</span></li>
</ul>
<br style=3D"font-family: arial,sans-serif;">
<div style=3D"margin-left: 40px; font-family: arial,sans-serif;">
<pre>#!/bin/sh<br>echo &quot;PIN&quot;:$(cat /etc/bluetooth/pin)</pre>
</div>
<ul>
  <li>Modify <b>/</b>etc/bluetooth/hcid.conf in order to set this options</=
li>
</ul>
<div style=3D"margin-left: 40px;">options {<br>
</div>
<pre style=3D"font-family: arial,sans-serif; margin-left: 40px;">        au=
toinit yes;<br>        security auto;<br>        pairing multi;<br>        =
pin_helper /usr/local/bin/bluez-localpin; #este no es el que trae por defec=
to, ver arriba
<br>}<br>device {<br>        name &quot;%h-%d&quot;;<br>        class 0x3e0=
100;<br>        iscan enable; pscan enable;<br>        lm accept;<br>      =
  lp rswitch,hold,sniff,park;<br></pre>

<ul>
  <li>
    <h4 style=3D"font-family: arial,sans-serif; font-weight: normal;">Resta=
rt daemon</h4>
  </li>
</ul>
<h4 style=3D"font-family: arial,sans-serif; font-weight: normal; margin-lef=
t: 40px;"># /etc/init.d/bluez-utils restart<br>
</h4>

<br>


------=_Part_18559_4348310.1134817918804--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
