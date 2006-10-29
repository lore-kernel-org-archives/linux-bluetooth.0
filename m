Return-Path: <naranjo.manuel@gmail.com>
Message-ID: <360bc8300610291431qaba68ebh1cf71b861120e205@mail.gmail.com>
Date: Sun, 29 Oct 2006 19:31:07 -0300
From: "Naranjo Manuel Francisco" <naranjo.manuel@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Changes to BlueZ has brooken an App
Cc: marcel@holtmann.org
In-Reply-To: <1162152884.4720.7.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_90851_24024102.1162161067210"
References: <4540B313.1000302@gmail.com> <1162152884.4720.7.camel@localhost>
List-ID: <bluez-users.lists.sourceforge.net>

------=_Part_90851_24024102.1162161067210
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

Thanks a lot. Any idea what was it used for? So I can try to remove it.

Regards,

Manuel



Hi Manuel,
>
> the sdp_cstate_t was made public by accident and should have never been
> used by any application. It is a fully internal state. So the AvetantaBT
> implementation needs to be fixed.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Naranjo, Manuel Francisco
naranjo.manuel@gmail.com

------=_Part_90851_24024102.1162161067210
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br><br>Thanks a lot. Any idea what was it used for? So I can try to remove it.<br><br>Regards,<br><br>Manuel<br><br><br><div><span class="gmail_quote"><br></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Manuel,<br><br>the sdp_cstate_t was made public by accident and should have never been<br>used by any application. It is a fully internal state. So the AvetantaBT<br>implementation needs to be fixed.<br><br>Regards<br>
<br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br><br clear="all"><br>-- <br>Naranjo, Manuel Francisco<br><a href="mailto:naranjo.manuel@gmail.com">naranjo.manuel@gmail.com</a>

------=_Part_90851_24024102.1162161067210--
