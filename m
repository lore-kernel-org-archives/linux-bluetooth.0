Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Prepare patch bluez for the CoD in hci_conn
From: Chen Bin <binch@mobilesoft.com.cn>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1102317505.8510.66.camel@pegasus>
References: <1102340081.653.6.camel@debian>
	 <1102315236.8510.55.camel@pegasus>  <1102345868.2011.2.camel@debian>
	 <1102317505.8510.66.camel@pegasus>
Content-Type: text/plain; charset=gbk
Message-Id: <1102348252.3281.2.camel@debian>
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
Date: Mon, 06 Dec 2004 23:50:52 +0800

Hi Marcel,

I haven't patched for the kernel before, so I don't know what is the
Singed-off-by statement.I only added my change log at the header of the
file and in the part of the file I modified I have added some comments.

/*
   BlueZ - Bluetooth protocol stack for Linux
   Copyright (C) 2000-2001 Qualcomm Incorporated

   Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License version 2 as
   published by the Free Software Foundation;

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS
   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY
RIGHTS.
   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR
ANY
   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY
DAMAGES
   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
OF
   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
   SOFTWARE IS DISCLAIMED.

 * Add some code for CoD value, 06/12/04, Chen Bin
 *     binch@mobilesoft.com.cn
*/


Sorry for inconvient.

Chen
=D4=DA 2004-12-06=D2=BB=B5=C4 08:18 +0100=A3=ACMarcel Holtmann=D0=B4=B5=C0=
=A3=BA
> Hi Chen,
>=20
> > I have done this. I searched the BT spec and find two places which wi=
ll
> > let us know the CoD value, and I simply test it, it works find.
> >=20
> > Ok, next step is to make an interface(maybe ioctl) to let the user ge=
t
> > the CoD value, is it needed(if there has been a interface which can g=
et
> > the entire hci_conn structure)? If it is not needed, I will send you =
the
> > patch now.
>=20
> step by step. Send your patch now and don't forget the Signed-off-by
> statement.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users=
.
> Discover which products truly live up to the hype. Start reading now.=20
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
