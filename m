Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth MIME types and URIs
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05070813041c5a19a0@mail.gmail.com>
References: <1120747365.18553.15.camel@pegasus>
	 <200507071900.33313.bluez-devel@schaettgen.de>
	 <1120759981.18553.52.camel@pegasus>
	 <200507080315.50686.bluez-devel@schaettgen.de>
	 <1120804711.18553.100.camel@pegasus>
	 <e1effdeb05070805454b8960b6@mail.gmail.com>
	 <1120834052.18553.123.camel@pegasus>
	 <e1effdeb050708092343073205@mail.gmail.com>
	 <1120849847.7444.5.camel@notepaq>
	 <e1effdeb05070813041c5a19a0@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1120853507.7444.11.camel@notepaq>
Mime-Version: 1.0
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
Date: Fri, 08 Jul 2005 22:11:46 +0200

Hi Claudio,

> Which D-Bus services will be provided by bluetoothd? 
> Please fix me if it is wrong or add more details to clarify 
> my clouds.
> - periodic inquiry?
> - service discovery? Currenlty, All daemons(dund, pand, hidd ) 
>  have search option. In my opinion a parametrized search
>  should be provided only by bluetoothd
> - signal lost notifications?
> - link configuration?
> - adapter status: enable/disable authentication, encryption, pscan, iscan ?

actually my idea is to do everthing inside bluetoothd and then send
signals via D-Bus and provides methods for settings etc.

> Are there plans to implement D-Bus services for 
> the others bluez-utils daemons?

If this works out, then I like to integrate HID, PAN and CIP into it and
provide methods for it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
