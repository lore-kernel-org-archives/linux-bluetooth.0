Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HIDP backport for 2.4
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Frey <mfrey@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <DB622085-ED54-11D8-ABB4-00039390D626@pepper.com>
References: <1090054739.4558.2.camel@pegasus>
	 <1090759952.4791.91.camel@pegasus>
	 <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com>
	 <1090864026.29589.1.camel@pegasus>
	 <5F07F140-DF2E-11D8-B83A-00039390D626@pepper.com>
	 <1090865790.29589.5.camel@pegasus>
	 <76F28965-DF34-11D8-B83A-00039390D626@pepper.com>
	 <1090875679.10807.1.camel@pegasus>
	 <4B8C0D08-DF64-11D8-95A4-003065B218E0@pepper.com>
	 <1090916301.4650.9.camel@pegasus>
	 <ABD9E52C-DFDC-11D8-BE76-00039390D626@pepper.com>
	 <1090940516.4845.19.camel@pegasus>
	 <A9BDE398-DFDF-11D8-BE76-00039390D626@pepper.com>
	 <1090941847.4845.29.camel@pegasus>
	 <86089F56-DFE5-11D8-BE76-00039390D626@pepper.com>
	 <1091375871.27018.18.camel@pegasus>
	 <225072EC-EBDC-11D8-B1A2-00039390D626@pepper.com>
	 <1092262282.4564.256.camel@pegasus>
	 <0F5DF2CE-ED4E-11D8-ABB4-00039390D626@pepper.com>
	 <1092419605.4501.1.camel@pegasus>
	 <DB622085-ED54-11D8-ABB4-00039390D626@pepper.com>
Content-Type: text/plain
Message-Id: <1092421264.4501.7.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 13 Aug 2004 20:21:04 +0200

Hi Michael,

> Can you explain to me the difference between CSR mode and bcsp?  I have 
> a CSR bluetooth module but have never been able to run in CSR mode.  
> What could be the reason for this?

the CSR chips can work in H4 or BCSP mode over UART depending on the
settings of some specific PS keys. Both are host transport protocols for
the HCI layer. Check the CSR documention from your vendor or the mailing
list archive for more information.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
