Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] fixing hidp keycodes
Message-ID: <20050505203257.GA12178@externe.net>
References: <20050422105609.GA16313@externe.net> <1114168206.32265.62.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1114168206.32265.62.camel@pegasus>
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
Date: Thu, 5 May 2005 16:32:57 -0400

On Friday, 22 April 2005 at 13:10:06 (+0200), Marcel Holtmann wrote:
> > This suggest that my approach should work. I don't understand why it'=
s
> > not working with tab/capslock/esc.
>=20
> To make this working in report mode, you must replace the HID descripto=
r
> or tell hidd to use the boot mode only. Speaking of which, I just saw
> that I never added support for pushing a device into boot mode. However
> the --nosdp option should do the trick.

It doesn't. Here's the table I'm using in
kernel/net/bluetooth/hidp/core.c :

static unsigned char hidp_keycode[256] =3D {
          0,  0,  0,  0, 125, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
         50, 49, 24, 25, 16, 19, 31, 20, 22, 47, 17, 45, 21, 44,  2,  3,
          4,  5,  6,  7,  8,  9, 10, 11, 28, 58, 14,  1, 57, 12, 13, 26,
         27, 43, 43, 39, 40, 41, 51, 52, 53, 15, 59, 60, 61, 62, 63, 64,
          0,  0, 67, 68, 87, 67, 99, 70,119,110,102,104,111,107,109,106,
        105,108,103, 69, 98, 55, 74, 78, 96, 79, 80, 81, 75, 76, 77, 71,
         72, 73, 82, 83, 86,127,116,117,183,184,185,186,187,188,189,190,
        191,192,193,194,134,138,130,132,128,129,131,137,133,135,136,113,
        115,114,  0,  0,  0,121,  0, 89, 93,124, 92, 94, 95,  0,  0,  0,
        122,123, 90, 91, 85,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
          0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
         29, 42, 56, 30, 97, 54,100,126,164,166,165,163,161,115,114,113,
        150,158,159,128,136,177,178,176,142,152,173,140
};

As you can see, 30/125 1/15/58 have been swapped, and 65/66 have been rem=
oved. (that's necessary).

Yet it doesn't work. I still even get 65 and 66. I'm using bluez 2.16 (ex=
cept sdptool - cf other message) with
the kernel patch. The kernel is on
http://externe.net/zaurus/kernel/sources/linux-2.4.18-rmk7-pxa3-20050501.=
tar.gz

I first though my ifdef were at fault. I removed everything- I only have =
this hidp_keycode now. Still doesn't work anyway.

Would you have a patch for hidd or a suggestion?

--=20
Bien =E0 vous - Best regards,
Guylhem P. Aznar

--=20
*@externe.net                                            http://externe.n=
et
P=E9rim=E9/Deprecated:    @oeil.qc.ca, @metalab.unc.edu, @ibiblio.org, @7=
un.org
GPG: 92EB37C1 DD11C9C9 20519D01 E8FA1B11 42975AF7 http://externe.net/pubk=
ey


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
