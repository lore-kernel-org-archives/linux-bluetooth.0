Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] fixing hidp keycodes
Message-ID: <20050422105609.GA16313@externe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Fri, 22 Apr 2005 06:56:09 -0400

Hello

Yes I did apply mh patches. I can put a copy of the kernel online if
you want to see it.

I'm not sure I understand the "report mode". Pressing on a keyboard
key after hidd --connect make the key work in applications. It's not
simply reporting.

hidp_keycode is declared locally in core.c and never used elsewhere.
input_report_key seems to send hidp_keycode[keys[i]] to the input
layer. If I printk this, I only see 0.=20

What I want to do on my strange keyboard is :
swap tab and capslock
swap capslock and esc

So I swapped 15 and 58, then 58 and 1 in the hidp_keycodes, but this
only gets me multiple esc. However, replacing keycodes 65 and 66 by 0
which where incorrectly send when pressing on a special keyboard
modifier key worked, as did swapping keycode 30 and 125 (some library
has keycode 30=3Dmodfier hardcoded in, so I had to do a workaround and
remap the a key to 125 and change the keyboard map accordingly)

This suggest that my approach should work. I don't understand why it's
not working with tab/capslock/esc.

I'm puzzled. Any suggestion is welcome.

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
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
