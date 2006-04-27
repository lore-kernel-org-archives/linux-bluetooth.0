Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5256d0b0604270813o74e136faqe83b46dfa6a13fd7@mail.gmail.com>
From: "Peter Robinson" <pbrobinson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth-alsa reorg
In-Reply-To: <4450DDF8.7070304@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4450DDF8.7070304@xmission.com>
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
Date: Thu, 27 Apr 2006 16:13:46 +0100

On 4/27/06, Brad Midgley <bmidgley@xmission.com> wrote:
> Guys
>
> FYI, I am going to move stuff around in the bluetooth-alsa project. I'll
> have two cvs modules:
>
> btsco: btsco daemon, alsa sco & a2dp plugins, kernel module
> wavez: a2play, a2recv, gst sco & a2dp plugins, avrcp, scoot
>
> (I'm writing scoot for gumstix to play sco audio through pcm)
>
> The new module will be easier to embed and won't have any alsa-lib
> entanglements. gstreamer plugins will be optionaly built like alsa
> plugins are now. The libsbc stuff will finally be taken out and we'll
> depend on the external project.
>
> bluetooth-alsa is not the best name any more considering half this stuff
> does not use alsa. sigh.

Excellent! How hard would it be to rename the project to something
like bluetooth-audio or maybe just merge it with the bluez site?

Peter


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
