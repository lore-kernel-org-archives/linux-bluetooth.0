Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Till Harbaum <harbaum@beecon.de>
To: <bluez-devel@lists.sourceforge.net>
References: <50BF37ECE4954A4BA18C08D0C2CF88CB2364EC@exmail1.se.axis.com>
In-Reply-To: <50BF37ECE4954A4BA18C08D0C2CF88CB2364EC@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408261844.20194.harbaum@beecon.de>
Subject: [Bluez-devel] Little Hexdump-Patch for hcidump
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
Date: Thu, 26 Aug 2004 18:44:20 +0200

Hi all,

in every new release of hcidump i have been replacing the built-in 
hexdump routine with my own one (giving the address and ascii as well).

Perhaps you want to use this replacement in hcidump/parser/parser.c

The hex output is very useful for me and e.g. just being able to see ascii 
strings inside rfcomm payload is something i really often need.

Feel free to include it into the public version if you like to ...

Regards,
  Till


void hex_dump(int level, struct frame *frm, int num)
{
	unsigned char *buf = frm->ptr;
	register int i,n,b2c;

	if ((num < 0) || (num > frm->len))
		num = frm->len;

	n = 0;
	while(num>0) {
	    p_indent(level, frm);
	    printf("%04x: ", n);

	    b2c = (num>16)?16:num;

	    for(i=0;i<b2c;i++) printf("%02x ", buf[i]);
	    for(i=0;i<(16-b2c);i++) printf("   ");
	    printf("  ");

	    for(i=0;i<b2c;i++) printf("%c", isprint(buf[i])?buf[i]:'.');
	    printf("\n");

	    buf  += b2c;
	    num  -= b2c;
	    n    += b2c;
	}
}

-- 
Dr.-Ing. Till Harbaum                       Tel.:  +49 721 4998963
BeeCon GmbH                                 Fax:   +49 721 4998962
Haid-und-Neu Strasse 7, 76131 Karlsruhe     Mobil: +49 179 9087904
harbaum@beecon.de                           http://www.beecon.de



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
