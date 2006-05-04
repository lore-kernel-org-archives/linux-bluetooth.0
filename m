Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C075@eumonex01.palmsource.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] A2DP and Alsa Plugin
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
Date: Thu, 4 May 2006 15:30:38 +0200

Hi all,

I recently started to work with bluetooth-alsa (0.41) and a bluetake =
iPhono BT420 headset.
I made it work using a2play, but not using alsa-plugins. I also tried =
the latest cvs without success.

At first, I had the following message :=20
"Requested Capabilities for SEID =3D 1
Didn't receive SBC codec parameters (first) for SEID =3D 1"
As it worked with a2play, I went into the source code, and it appeared =
that pcm_a2dp.c uses O_NONBLOCK socket option. Removing the option =
allowed me to go further.

After that, I saw "DEBUG:a2dp_transfer" traces : but the write() call =
was failing with error=3DIncorrect parameter. I believe this has =
something to do with mtu because after reducing the transmitted size, =
the calls were succeeding, and the iphono started to make noise, but it =
really was not what I expected. I'm right saying there is no a2dp =
encapsulation for sbc blocks  within the plugin?=20

Has anyone made the plugin work? Also, as I will have time to work with =
bt-alsa, I would be pleased to help. What must/can be done? What area =
can I investigate in order to have a2dp working with alsa?

I'm really new to bt, any help will be welcome, thank you,

Regards,

Fr=E9d=E9ric Dalleau


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
