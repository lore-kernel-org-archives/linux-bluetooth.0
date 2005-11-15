Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Rolf S. Dubitzky " <Dubitzky@physi.uni-heidelberg.de>
To: bluez-users@lists.sourceforge.net
References: <200511141452.23951.Dubitzky@physi.uni-heidelberg.de> <200511141705.51539.Dubitzky@physi.uni-heidelberg.de> <200511141913.48954.Dubitzky@physi.uni-heidelberg.de>
In-Reply-To: <200511141913.48954.Dubitzky@physi.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
  boundary="Boundary-00=_DjaeDwIFOYC8gVj"
Message-Id: <200511151022.11133.Dubitzky@physi.uni-heidelberg.de>
Subject: [Bluez-users] Re: hcid crashing on pin_code_request
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
Date: Tue, 15 Nov 2005 10:22:05 +0100

--Boundary-00=_DjaeDwIFOYC8gVj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

I got it to work now.  For completeness:

1)  the bluez packages (see original post) in FedoraC4 are broken.  They 
    don't work and crash in the way I posted.
    => get latest version and compile yourself

2)  the current version of bluez-utils (2.22) doesn't compile propperly on 
    FC4.  The ./configure doesn't find the dbus libraries and just doesn't
    compile with dbus support, but without dbus support bluez is unusable for
    me.   I would concider this to be a bug in bluez, but ymmv.  
    Now without dbus support sdp doesn't work, e.g. sdptool browse just 
    returns

     Failed to connect to SDP server on 00:07:A4:03:97:24: Connection timed 
     out

    So if a tool doesn't work without dbus, I'd highly recommend to make dbus 
    a requirement, not an option.

    The problem with compiling on FC4 is that for some funky reason dbus 
    headers are spread over two directories:
      /usr/include/dbus-1.0/dbus/* (e.g. dbus.h)
    and one other file in
      /usr/lib/dbus-1.0/include/dbus/dbus-arch-deps.h
    So you have to -I _both_ directories to make #include dbus/dbus.h compile.
    

Cheers, Rolf


--Boundary-00=_DjaeDwIFOYC8gVj
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<html><head><meta name="qrichtext" content="1" /></head><body style="font-size:12pt;font-family:Courier">
<p>Hi,</p>
<p></p>
<p>I got it to work now.  For completeness:</p>
<p></p>
<p>1)  the bluez packages (see original post) in FedoraC4 are broken.  They </p>
<p>    don't work and crash in the way I posted.</p>
<p>    =&gt; get latest version and compile yourself</p>
<p></p>
<p>2)  the current version of bluez-utils (2.22) doesn't compile propperly on </p>
<p>    FC4.  The ./configure doesn't find the dbus libraries and just doesn't</p>
<p>    compile with dbus support, but without dbus support bluez is unusable for</p>
<p>    me.   I would concider this to be a bug in bluez, but ymmv.  </p>
<p>    Now without dbus support sdp doesn't work, e.g. sdptool browse just </p>
<p>    returns</p>
<p></p>
<p>     Failed to connect to SDP server on 00:07:A4:03:97:24: Connection timed </p>
<p>     out</p>
<p></p>
<p>    So if a tool doesn't work without dbus, I'd highly recommend to make dbus </p>
<p>    a requirement, not an option.</p>
<p></p>
<p>    The problem with compiling on FC4 is that for some funky reason dbus </p>
<p>    headers are spread over two directories:</p>
<p>      /usr/include/dbus-1.0/dbus/* (e.g. dbus.h)</p>
<p>    and one other file in</p>
<p>      /usr/lib/dbus-1.0/include/dbus/dbus-arch-deps.h</p>
<p>    So you have to -I _both_ directories to make #include dbus/dbus.h compile.</p>
<p>    </p>
<p></p>
<p>Cheers, Rolf</p>
<p></p>
<p></p>
</body></html>
--Boundary-00=_DjaeDwIFOYC8gVj--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
