Return-Path: <SRS0+a3816589f1f72d698319+262+infradead.org+dwmw2@pentafluge-185632.srs.infradead.org>
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Nicholas A. Preyss" <nalp@gmx.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084383929.25099.94.camel@pegasus>
References: <20040511192919.GB28581@gmx.net>
	 <1084368229.25099.26.camel@pegasus>
	 <1084371486.4426.156.camel@hades.cambridge.redhat.com>
	 <1084382445.25099.77.camel@pegasus>
	 <1084382743.4426.351.camel@hades.cambridge.redhat.com>
	 <1084382951.25099.89.camel@pegasus>
	 <1084383201.4426.374.camel@hades.cambridge.redhat.com>
	 <1084383929.25099.94.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084384590.4426.428.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 12 May 2004 18:56:31 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-05-12 at 19:45 +0200, Marcel Holtmann wrote:
> I am thinking of a dynamic and generic config interface to every daemon,
> but this is far from any real code at the moment. So feel free to do
> what you think is the best for Fedora. But if you change too much, then
> keep an eye on the BlueZ mailing lists for Fedora specific questions
> that I can't and actually that I won't answer.

It's basically only the init scripts in which my packages differ now, I
believe. Just about everything else I had in patches is now in CVS --
most of it a long time ago; I don't know why the swave array overflow
slipped through the cracks. 

/me checks... oh, you probably want this one too...

--- bluez-utils-2.7/pcmcia/bluetooth.orig	2004-05-11 22:58:08.557536120 +0100
+++ bluez-utils-2.7/pcmcia/bluetooth	2004-05-11 22:57:03.442435120 +0100
@@ -25,7 +25,7 @@
     IRQ=`setserial /dev/$DEVICE | sed -e 's/.*IRQ: //'`
     setserial /dev/$DEVICE irq 0 ; setserial /dev/$DEVICE irq $IRQ
  
-    /sbin/hciattach $DEVICE $MANFID > /tmp/pcmcia
+    /sbin/hciattach $DEVICE $MANFID
 }
 stop_serial() {
     do_fuser -k -HUP /dev/$DEVICE > /dev/null


-- 
dwmw2
