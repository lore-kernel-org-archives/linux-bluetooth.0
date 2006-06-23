Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <85cea3460606221840r7b051cc6r94898225e6b88f8e@mail.gmail.com>
Date: Thu, 22 Jun 2006 21:40:57 -0400
From: "Sweta Vasudevan" <sweta.vasudevan@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4491C2FF.3010604@xmission.com>
MIME-Version: 1.0
References: <85cea3460606111303r218e088ek21d50709fce3c6df@mail.gmail.com>
	<448C81FC.50509@xmission.com>
	<85cea3460606142049y81d6573q476aa9e599e4372d@mail.gmail.com>
	<4491C2FF.3010604@xmission.com>
Subject: Re: [Bluez-devel] btsco and connection problems
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1933279355=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1933279355==
Content-Type: multipart/alternative;
	boundary="----=_Part_20299_24101912.1151026857269"

------=_Part_20299_24101912.1151026857269
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Brad

>
> the config all looks good.
>
> it's frustrating when even the basic stuff won't go. you could try
> another headset or try removing an old pairing if present (see
> bluetooth-alsa.sf.net). i switch dongles as one thing to test when
> having this kind of trouble...
>
> brad
>
>
> I had already tried this with 2 other dongles(different vendors,
compatible with linux). The d-link dongle - jabra headset combination seems
to have been successful for bluetooth-audio programming, which is why I'm
hoping to get this working. Did you mean trying it with another dongle of
the same model as this one?

I tried to remove the pairing, but there is no link_key entry in
/etc/bluetooth and no bluetooth folder /var/lib; also, the pin file in
/etc/bluetooth was blank. Does this mean that the headset has not been
paired? I've tried re-pairing it by following the instructions in the jabra
manual, but wasn't asked for the passkey again.

I had also tried configuring the security settings like Marcel Holtmann had
suggested to someone else on the mailing-list, but that didn't help
either...

Thanks,
Sweta.

------=_Part_20299_24101912.1151026857269
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hello Brad<br><div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>the config all looks good.<br><br>


it's frustrating when even the basic stuff won't go. you could try<br>another headset or try removing an old pairing if present (see<br><a href="http://bluetooth-alsa.sf.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

bluetooth-alsa.sf.net</a>). i switch dongles as one thing to test when
<br>having this kind of trouble...<br><br>brad<br><br><br></blockquote></div>I had already tried this with 2 other dongles(different vendors, compatible with linux). The d-link dongle - jabra headset combination seems to have been successful for bluetooth-audio programming, which is why I'm hoping to get this working. Did you mean trying it with another dongle of the same model as this one?
<br><br>I tried to remove the pairing, but there is no link_key entry in /etc/bluetooth and no bluetooth folder /var/lib; also, the pin file in /etc/bluetooth was blank. Does this mean that the headset has not been paired? I've tried re-pairing it by following the instructions in the jabra manual, but wasn't asked for the passkey again.&nbsp; 
<br><br>I had also tried configuring the security settings like Marcel Holtmann had suggested to someone else on the mailing-list, but that didn't help either...<br><br>Thanks,<br>Sweta.<br>



------=_Part_20299_24101912.1151026857269--


--===============1933279355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1933279355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1933279355==--
